# greenhouse
#   - mood based and modular oh-my-zsh theme
#   - inspired by candy and fino oh-my-zsh themes
# rodrigo-pariente
#   - github: github.com/rodrigo-pariente
#   - email : rodrigo_pariente@proton.me

get_panel_dir() {
  case "$PWD" in
    "$HOME") print '[home]'            ;;
          /) print '[root]'            ;;
          *) print "[${PWD/#$HOME/~}]" ;;
  esac
}

python_venv_prompt() {
  if [[ -n "$VIRTUAL_ENV" ]]; then
    print "[%{$fg[yellow]%}${VIRTUAL_ENV##*/}%{$reset_color%}]"
  fi
}

# more on the `flags` string use can be seen in my bashrc
# version of this theme.
export flags=''
export icon=🐍

# -----------------------------------------------------------------

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[green]%}[%{$reset_color%}%{$fg_bold[magenta]%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[red]%}?"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[orange]%}!"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}%{$fg_bold[green]%}]%{$reset_color%}"

PROMPT='%{$fg_bold[green]%}╭─%(1j.[%j].)$(get_panel_dir)%{$reset_color%}\
$flags$(python_venv_prompt)$(git_prompt_info)
%{$fg_bold[green]%}╰─%{$fg[white]%}[%(?,$icon,%?)]%{$reset_color%}\
%{$reset_color%} $ '

RPROMPT='%{$fg[red]%}%(?..✘)%{$reset_color%}'

# Add battery status if the battery plugin is enabled
if (( $+functions[battery_pct_prompt] )); then
    RPROMPT+='$(battery_time_remaining) $(battery_pct_prompt)%{$reset_color%}'
fi
