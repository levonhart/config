function color_my_prompt {
    local __user_and_host="\[\e[32m\]\u\[\e[37m\]@\[\e[32m\]\H"
    local __cur_location="\[\e[33m\]\w"
    local __git_branch_color="\[\e[31m\]"
    #local __git_branch="\`ruby -e \"print (%x{git branch 2> /dev/null}.grep(/^\*/).first || '').gsub(/^\* (.+)$/, '(\1) ')\"\`"
    local __git_branch='`git branch 2> /dev/null | sed -E  s/^\\\\\*\ \(.+\)$/\(\\\\\1\)\ /`'
    local __prompt_tail="\[\e[35m\]\$"
    local __last_color="\[\e[00m\]"
    export PS1="$__user_and_host $__cur_location $__git_branch_color$__git_branch$__prompt_tail$__last_color "
}
color_my_prompt

alias ls='ls --color=auto'
alias ll='ls -l'
alias ag='ag --color-path "0;36" --color-line-number "0;33" --color-match "30;46"'

dircolors=$HOME/.dircolors-$(tput colors)

if [[ -f $dircolors ]]; then
    eval $(dircolors -b $dircolors)
else
    eval $(dircolors)
fi

alias devdir='cd /d/Development'
alias midir='cd ~/OneDrive/Documentos/Matemática\ Industrial'

