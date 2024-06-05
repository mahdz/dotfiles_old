#!/bin/zsh
################################################
# .zprofile - Zsh file loaded on login.
################################################

eval "$(/opt/homebrew/bin/brew shellenv)"

#█▓▒░ clean home
export XDG_CONFIG_HOME="$HOME"/.config
#export NAVE_DIR="$HOME"/.local/lib/nodejs
#export GOPATH="$HOME"/.local/lib/go
export XDG_DATA_HOME="$HOME"/.local/share
export XDG_CACHE_HOME="$HOME"/.local/cache
export XDG_STATE_HOME="$HOME"/.local/state
#export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:=/tmp}"
#export ZDOTDIR="$HOME"/.config/zsh
#export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
#export NPM_CONFIG_PREFIX="$XDG_DATA_HOME"/npm
#export NPM_CONFIG_CACHE="$XDG_CACHE_HOME"/npm
#export STARSHIP_CACHE="$XDG_CACHE_HOME"/starship

###############################################################################
#Import the shell-agnostic (Bash or Zsh) environment config
##############################################################################
source ~/.profile


################################################
# Paths
################################################

# Ensure path arrays do not contain duplicates.
typeset -gU path fpath

