#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# misc settings
alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
export EDITOR=nvim

# set vi edit mode
set -o vi

# configure fzf
which fzf &> /dev/null
if [ $? -eq 0 ]
then
    # ... default tool used
    export FZF_DEFAULT_COMMAND='ag --nocolor -g ""'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
    # ... environment (completion, etc.)
    eval "$(fzf --bash)"
    # ... enrich fzf completion
    complete -F _fzf_complete_kill -o nospace -o default -o bashdefault pidstat
fi

# launch starship prompt if need be
which starship &> /dev/null
if [ $? -eq 0 ]
then
    eval "$(starship init bash)"
fi
