bindkey -e

eval "$(pyenv init -)"
eval "$(rbenv init -)"

autoload colors
colors
PROMPT="%{${fg[green]}%}%(!.#.$) %{${reset_color}%}"

alias t='cd ../'
alias tt='cd ../../'
alias ttt='cd ../../../'
alias p=pbcopy
alias gg='git grep'
alias gap='git ap'
alias g='git'
alias gf='git fg'
alias ga='git ap'

zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
fpath=(~/.zsh $fpath)
autoload -Uz compinit && compinit

function docker-python() {
  cat "$1" | docker run -i python
}

function dockerkill() {
  local container=$(docker ps | sed 1d | peco)
  local container_id=$(echo "$container" |  awk '{ print $1 }')
  docker kill "$container_id"
}

export PATH="$HOME/.gitim/bin:$PATH"
export FPATH="$HOME/.zsh/autoload/:$FPATH"

# For use brew opensssl
export PATH=/usr/local/opt/openssl/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/opt/openssl/lib:$LD_LIBRARY_PATH
export CPATH=/usr/local/opt/openssl/include:$LD_LIBRARY_PATH

# direnv
eval "$(direnv hook zsh)"
export EDITOR=vim

# rbenv binstubs setting
export PATH=./vendor/bin:/Users/yinaura/google-cloud-sdk/bin:$PATH

# Other
export PATH="$HOME/.rbenv/shims:$PATH"
#export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

PATH=${PATH}
export LANG=en_US.UTF-8

zstyle ':completion:*' ignore-parents parent pwd ..

# alias
function g { git $@ }


HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_no_store
setopt share_history
setopt auto_pushd
setopt pushd_ignore_dups
set paste

export LSCOLORS=gxfxbxdxcxegedabagacad
zstyle ':completion:*' list-colors $LSCOLORS

# PROMPT
RPROMPT="%1(v|%F{green}%1v%f|) [%~]"
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '[%b]'
zstyle ':vcs_info:*' actionformats '[%b|%a]'
function precmd_vcs() {
  psvar=()
  LANG=en_US.UTF-8 vcs_info
  [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
precmd_functions+=(precmd_vcs)

# COLORING
export LSCOLORS=gxfxbxdxcxegedabagacad
alias ls="ls -aFG"
zstyle ':completion:*' list-colors $LSCOLORS

autoload colors
colors
PROMPT="%{${fg[green]}%}%(!.#.$) %{${reset_color}%}"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

function peco-history-selection-keep() {
  BUFFER=$(history -n 1 | tail -r  | awk '!a[$0]++' | peco --layout=bottom-up --query="$BUFFER" --print-query | tail -n 1)

  CURSOR=$#BUFFER
}
zle -N peco-history-selection-keep
bindkey '^R' peco-history-selection-keep

function peco-history-pbcopy() {
  history -n 1 | tail -r  | awk '!a[$0]++' | peco --layout=bottom-up | tr -d "\r\n" | pbcopy 
}
zle -N peco-history-pbcopy
bindkey '^P^P' peco-history-pbcopy


function peco-history-current-pbcopy() {
  print "$BUFFER" | tr -d "\r\n" | pbcopy
}

zle -N peco-history-current-pbcopy
bindkey '^P^O' peco-history-current-pbcopy

function rp() {
  RPROMPT=""
}
function rpe() {
  RPROMPT="%1(v|%F{green}%1v%f|) [%~]"
}

# ghq
function peco-src () {
  local selected_dir=$(ghq list -p | peco --query="$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey '^G^G' peco-src


export GOPATH=~/go
export PATH=$PATH:$GOPATH/bin


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/yumainaura/Applications/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/yumainaura/Applications/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/yumainaura/Applications/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/yumainaura/Applications/google-cloud-sdk/completion.zsh.inc'; fi
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
export PATH="/usr/local/opt/ruby/bin:$PATH"

