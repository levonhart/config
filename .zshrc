export PATH=$PATH:$HOME/.local/bin

HISTFILE=~/.histfile

# zplug begin
source ~/.zplug/init.zsh

zplug "zsh-users/zsh-syntax-highlighting", defer:2

zplug "zsh-users/zsh-autosuggestions"

zplug "softmoth/zsh-vim-mode"

#zplug "Aloxaf/fzf-tab"


if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load --verbose


# zplug end

source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

alias ls="exa"
alias ll="exa -l"
alias la="exa -la"

# completion
bindkey -M menuselect '^o' accept-and-infer-next-history
zstyle ':completion:*:*:*:*:*' menu select

#compdef lab
function _lab {
    source <(lab _carapace zsh)
}

if compquote '' 2>/dev/null; then _lab; else compdef _lab lab; fi

eval "$(starship init zsh)"
neofetch
