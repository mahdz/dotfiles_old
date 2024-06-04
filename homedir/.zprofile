################################################
# .zprofile - Zsh file loaded on login.
################################################

eval "$(/opt/homebrew/bin/brew shellenv)"


# Make sure XDG dirs are set
[[ -n "$XDG_CONFIG_HOME" ]] || export XDG_CONFIG_HOME=$HOME/.config
[[ -n "$XDG_CACHE_HOME"  ]] || export XDG_CACHE_HOME=$HOME/.cache
[[ -n "$XDG_DATA_HOME"   ]] || export XDG_DATA_HOME=$HOME/.local/share
[[ -n "$XDG_STATE_HOME"   ]] || export XDG_STATE_HOME=$HOME/.local/state


###############################################################################
#Import the shell-agnostic (Bash or Zsh) environment config
##############################################################################
source ~/.profile


################################################
# Paths
################################################

# Ensure path arrays do not contain duplicates.
typeset -gU path fpath

