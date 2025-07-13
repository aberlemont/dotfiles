#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# set vi edit mode
set -o vi

# configure fzf
# ... default tool used
export FZF_DEFAULT_COMMAND='ag --nocolor -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
# ... environment (completion, etc.)
source /usr/share/fzf/completion.bash
source /usr/share/fzf/key-bindings.bash
# ... enrich fzf completion
complete -F _fzf_complete_kill -o nospace -o default -o bashdefault pidstat

# launch starship prompt
eval "$(starship init bash)"
