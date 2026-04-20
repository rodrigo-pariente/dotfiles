# bashrc
#   - my bash configuration file
#   - ...
# rodrigo-pariente
#   - github: github.com/rodrigo-pariente
#   -  email: rodrigo_pariente@proton.me
# credits
#   - inspired by dave eddy dotfiles:
#     github.com/bahamas10/dotfiles

# If not running interactively, don't do anything
case "$-" in
    *i*)        ;;
      *) return ;;
esac

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend
shopt -s autocd   2>/dev/null
shopt -s dirspell 2>/dev/null

# history length
HISTSIZE=5000
HISTFILESIZE=5000

# check the window size after each command
shopt -s checkwinsize

# ------------------------
# Prompt theme: Greenhouse
# ------------------------

export VIRTUAL_ENV_DISABLE_PROMPT=1
[[ -f ~/.git-prompt.sh ]] && . ~/.git-prompt.sh || __git_ps1() { :; }
[[ -f ~/.flags ]] && flags="$(<~/.flags)" || flags=''

export flags
export icon=🐍
__last_exit=0
__jobs=
__dir=
__python_prompt=
update_prompt() {
  # last_exit
  __last_exit="${?/#0/$icon}"

  # directory
  case "$PWD" in
    "$HOME") __dir="[home]"             ;;
          /) __dir="[root]"             ;;
          *) __dir="[${PWD/#$HOME/\~}]" ;;
  esac

  # jobs
  local job_count="$(jobs -p | wc -l)"
  case "$job_count" in
    0) __jobs=""             ;;
    *) __jobs="[$job_count]" ;;
  esac

  # python prompt
  __python_prompt=""
  [[ -n "$VIRTUAL_ENV" ]] && __python_prompt="[${VIRTUAL_ENV##*/}]"
}
PROMPT_COMMAND=update_prompt

BGREEN='\[\e[1;32m\]'
YELLOW='\[\e[0;33m\]'
PURPLE='\[\e[0;35m\]'
WHITE='\[\e[0;37m\]'
RESET='\[\e[0;0m\]'
PS1="${BGREEN}"'╭─$__jobs$__dir'"${RESET}"'$flags\
'"${YELLOW}"'$__python_prompt'"${PURPLE}"'$(__git_ps1 "[%s]")
'"${BGREEN}"'╰─['"${WHITE}"'$__last_exit'"${BGREEN}"']'"${RESET}"' \$ '

# As part of my theme greenhouse, variable 'flags' stores colored '[msg]'
badge() {
  _usage() {
    cat <<- 'EOF'
usage: (-a [FLAG ...]) (-d [FLAG ...]) (-u)

  -u: update flag string into flag database
  -a: append flag
  -d: remove flag
EOF
  }

  _get_flag() {
      local border_left="\e[1;32m[\e[0m"
      local border_right="\e[1;32m]\e[0m"
      echo -e "$border_left\e[35m$1\e[0m$border_right"
  }

  local update=false
  local OPTIND OPTARG action
  while getopts 'uad' opt; do
    case "$opt" in
      u) update=true     ;;
      a) action="append" ;;
      d) action="remove" ;;
    esac
  done

  shift $((OPTIND - 1))

  ! "$update" && (( "$#" == 0 )) && _usage 2>&1 && return 1

  for flag in "$@"; do
    case "$action" in
      remove) flags=${flags//"$(_get_flag "$flag")"} ;;
      append) flags+="$(_get_flag "$flag")"          ;;
    esac
  done

  # update
  echo "$flags">"$HOME/.flags"
}

# ------------------------
# End of prompt theme     
# ------------------------

# colored GCC warnings and errors
GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
export GCC_COLORS

# file for alias definitions.
[[ -f ~/.aliases ]] && . ~/.aliases

# enable programmable completion features
if ! shopt -oq posix; then
  if [[ -f /usr/share/bash-completion/bash_completion ]]; then
    . /usr/share/bash-completion/bash_completion
  elif [[ -f /etc/bash_completion ]]; then
    . /etc/bash_completion
  fi
fi

# load homebrew bash functions
[[ -f ~/.bashfn ]] && . ~/.bashfn

# load cargo enviroment
[[ -f ~/.cargo/env ]] && . ~/.cargo/env

if command -v "bat" >/dev/null 2>&1; then
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
  export MANROFFOPT="-c"
fi

export PATH="$PATH:$HOME/.local/bin/"
export VISUAL="/opt/nvim-linux-x86_64/bin/nvim"
export EDITOR="/opt/nvim-linux-x86_64/bin/nvim"

source "$HOME/.vulkan/1.4.341.1/setup-env.sh"
