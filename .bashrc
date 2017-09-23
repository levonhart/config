function color_my_prompt {
    local __user_and_host="\[\e[01;32m\]\u@\H"
    local __cur_location="\[\e[01;34m\]\w"
    local __git_branch_color="\[\e[31m\]"
    #local __git_branch="\`ruby -e \"print (%x{git branch 2> /dev/null}.grep(/^\*/).first || '').gsub(/^\* (.+)$/, '(\1) ')\"\`"
    local __git_branch='`git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\(\\\\\1\)\ /`'
    local __prompt_tail="\[\e[35m\]\$"
    local __last_color="\[\e[00m\]"
    export PS1="$__user_and_host $__cur_location $__git_branch_color$__git_branch$__prompt_tail$__last_color "
}
color_my_prompt

alias ls='ls --color=auto'
alias ll='ls -l'

dircolors=$HOME/.dircolors-$(tput colors)

if [[ -f $dircolors ]]; then
    eval $(dircolors -b $dircolors)
else
    eval $(dircolors)
fi

alias devdir='cd /d/Development'
