PROMPT='%{$fg[cyan]%}%c %(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )'
PROMPT+='$(git_prompt_info)%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%} %{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[blue]%}·"
