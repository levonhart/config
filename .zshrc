# vim: foldmethod=marker
# Geral {{{ #
export PATH=$PATH:$HOME/.local/bin

# previne C-S de bloquear entrada de caracteres
unsetopt flow_control

HISTSIZE=10000
HISTFILE=~/.histfile
# }}} Geral #

# zplug {{{ #
source ~/.zplug/init.zsh

zplug "zsh-users/zsh-syntax-highlighting", defer:2

zplug "zsh-users/zsh-autosuggestions"

zplug "softmoth/zsh-vim-mode"

# prompt alternativo
# zplug "denysdovhan/spaceship-prompt", use:spaceship.zsh, from:github, as:theme

# zplug "Aloxaf/fzf-tab"


if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load --verbose


# }}} zplug #

# fzf {{{ #
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
# }}} fzf #

# alias {{{ #
alias ls="exa"
alias ll="exa -l"
alias la="exa -la"
alias nano="nvim"
# }}} alias #

# spaceship {{{ #
# source ~/.config/spaceship.zsh
# }}} spaceship #

# completion {{{ #
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit

setopt menu_complete
setopt complete_in_word
setopt always_to_end

autoload -U +X bashcompinit && bashcompinit
# }}} completion #

# keybindings {{{ #
bindkey -v
bindkey -M vicmd '^?' backward-delete-char
bindkey -M vicmd "${terminfo[kdch1]}" delete-char
bindkey -M menuselect '^o' accept-and-infer-next-history

bindkey -M menuselect '^j' vi-down-line-or-history
bindkey -M menuselect '^k' vi-up-line-or-history

bindkey '^ ' autosuggest-accept

autoload -U edit-command-line
zle -N edit-command-line
bindkey '^e' edit-command-line
# }}} keybindings #

# autosuggestions {{{ #
ZSH_AUTOSUGGEST_USE_ASYNC=true
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=7"
# }}} autosuggestions #

# lab {{{ #
#compdef lab
function _lab {
    source <(lab _carapace zsh)
}

if compquote '' 2>/dev/null; then _lab; else compdef _lab lab; fi
# }}} lab #

# Fim {{{ #
eval "$(starship init zsh)"
neofetch
# }}} Fim #
