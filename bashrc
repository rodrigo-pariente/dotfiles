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

[[ -f ~/.git-prompt.sh ]] && . ~/.git-prompt.sh
[[ -f ~/.flags ]] && flags="$(<~/.flags)" || flags=''

export flags
export icon=🐍

dir_prompt() {
  case "$PWD" in
    "$HOME") echo '[home]'             ;;
          /) echo '[root]'             ;;
          *) echo "[${PWD/#$HOME/\~}]" ;;
  esac
}

python_prompt() {
  [[ -n "$VIRTUAL_ENV" ]] && echo "[${VIRTUAL_ENV##*/}]"
}

__last_exit=0
update_last_exit() { __last_exit="${?/#0/$icon}" ; }
PROMPT_COMMAND=update_last_exit

PS1='\[\033[1;32m\]╭─$([ \j != 0 ] && echo [\j])$(dir_prompt)\[\033[0m\]\
$flags\[\033[33m\]$(python_prompt)\[\033[35m\]$(__git_ps1 "[%s]")\[\033[0m\]
\[\033[1;32m\]╰─\[\033[37m\][\[\033[0m\]$__last_exit\[\033[37m\]]\
\[\033[0m\] \$ '

# As part of my theme greenhouse, variable 'flags' stores colored '[msg]'
badge() {
  _usage() {
    cat <<- 'EOF'
usage: (-a [FLAG ...]) (-r [FLAG ...]) (-u)

  -u: update flag string into flag database
  -a: append flag
  -d: remove flag
EOF
  }

  _get_flag() {
      local border_left="\033[1;32m[\033[0m"
      local border_right="\033[1;32m]\033[0m"
      echo -e "$border_left\033[1;35m$1\033[0m$border_right"
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

export PATH="$PATH:$HOME/.local/bin/"
export VISUAL="nvim"
export EDITOR="nvim"

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

case ":$PATH:" in
    *:/home/polyssance/.juliaup/bin:*)
        ;;

    *)
        export PATH=/home/polyssance/.juliaup/bin${PATH:+:${PATH}}
        ;;
esac

# <<< juliaup initialize <<<
