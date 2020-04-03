PROMPT='%F{green}%n@%m%f %F{blue}%1~%f %# '

alias ls='ls -G'

# Japanese setting
export LANG=ja_JP.UTF-8

# pyenv settings
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
export PATH=$HOME/.pyenv/shims:$PATH
