# vim: foldmethod=marker
# Geral {{{ #
export PATH=$PATH:$HOME/.local/bin

# previne C-S de bloquear entrada de caracteres
unsetopt flow_control

HISTSIZE=500000
SAVEHIST=100000
HISTFILE="$HOME/.zsh_history"
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data

# }}} Geral #

# zplug {{{ #
source ~/.zplug/init.zsh

zplug "zsh-users/zsh-syntax-highlighting", defer:2

zplug "zsh-users/zsh-autosuggestions"

zplug "softmoth/zsh-vim-mode"

# prompt alternativo
# zplug "denysdovhan/spaceship-prompt", use:spaceship.zsh, from:github, as:theme

zplug "Aloxaf/fzf-tab"


if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load


# }}} zplug #

# fzf {{{ #
export FZF_ALT_C_OPTS="
  --walker-skip .git,node_modules,target,.local,.cache,.wine,.steam,pfx
  --preview 'eza --tree --level=3 {}'
  --bind 'ctrl-/:toggle-preview'"
export FZF_CTRL_R_OPTS="
  --preview 'echo {}' --preview-window up:3:hidden:wrap
  --bind 'ctrl-/:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | xclip -s clipboard --)+abort'"
export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:toggle-preview'"
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
# }}} fzf #

# alias {{{ #
alias ls="eza"
alias ll="eza -l"
alias la="eza -la"
alias nano="nvim"
alias nv="nvim"
alias vim="nvim"
alias cat="bat -pp"
alias syr="sioyek-remote"
# }}} alias #

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

autoload -U up-line-or-beginning-search
zle -N up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search
bindkey -M vicmd '^p' up-line-or-beginning-search
bindkey -M viins '^p' up-line-or-beginning-search
bindkey -M vicmd '^n' down-line-or-beginning-search
bindkey -M viins '^n' down-line-or-beginning-search

bindkey -M vicmd "${terminfo[kcuu1]}" up-line-or-beginning-search
bindkey -M viins "${terminfo[kcuu1]}" up-line-or-beginning-search
bindkey -M vicmd "${terminfo[kcud1]}" down-line-or-beginning-search
bindkey -M viins "${terminfo[kcud1]}" down-line-or-beginning-search

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
# neofetch
# }}} Fim #
