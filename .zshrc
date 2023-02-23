#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

export JDTLS_HOME="/Users/bombrary/.cache/jdt"

export PATH="/Library/Java/JavaVirtualMachines/adoptopenjdk-16.jdk/Contents/Home:$PATH"
export JAVA_HOME="/Library/Java/JavaVirtualMachines/adoptopenjdk-16.jdk/Contents/Home"

export PATH="$HOME/.cargo/bin:$PATH"

alias xargs="gxargs"


if [[ $(command -v exa) ]]; then
  alias e='exa --icons'
  alias l=e
  alias ls=e
  alias ea='exa -a --icons'
  alias la=ea
  alias ee='exa -aal --icons'
  alias ll=ee
  alias et='exa -T -L 3 -a -I "node_modules|.git|.cache" --icons'
  alias lt=et
  alias eta='exa -T -a -I "node_modules|.git|.cache" --color=always --icons | less -r'
  alias lta=eta
fi

# opam configuration
[[ ! -r /Users/bombrary/.opam/opam-init/init.zsh ]] || source /Users/bombrary/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
