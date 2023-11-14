alias ls='ls -G --color=auto'
alias ll='ls -lah'
alias la='ls -A'

alias cp='cp -i'
alias mv='mv -i'

alias ip='ip --color=auto'

which -s fd > /dev/null
[[ $? -ne 0 ]] && alias fd='fdfind'
