export PATH=$HOME/.local/bin:$PATH

export EDITOR=vim

export BAT_THEME='Monokai Extended'

export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border=rounded --info inline'
export FZF_DEFAULT_COMMAND='fd --hidden --follow --type f --exclude .git'
_fzf_compgen_path() {
    fd --hidden --follow --exclude ".git" ."$1"
}
_fzf_compgen_dir() {
    fd --type d --hidden --follow --exclude ".git" . "$1"
}
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh
