#!/bin/zsh
################################################
# .zshrc - Zsh file loaded on interactive shell sessions.
################################################

setopt AUTO_CD
setopt NO_CASE_GLOB
setopt CORRECT
setopt CORRECT_ALL

##############################################################################
# History Configuration
##############################################################################
HISTSIZE=5000               #How many lines of history to keep in memory
HISTFILE=$XDG_STATE_HOME/zsh/.zsh_history     #Where to save history to disk
SAVEHIST=5000               #Number of history entries to save to disk
HISTDUP=erase               #Erase duplicates in the history file
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data
setopt INC_APPEND_HISTORY # adds commands as they are typed, not at shell exit

LESSHISTFILE="$XDG_STATE_HOME"/less/history

##############################################################################
# Python
##############################################################################

#alias python='/opt/homebrew/bin/python3'
#command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
#eval "$(pyenv init -)"
#PYENV_ROOT="$HOME/.pyenv"=


##############################################################################
# zsh-nvm
##############################################################################

export NVM_DIR="$XDG_CONFIG_HOME/nvm"
export NVM_COMPLETION=true
# export NVM_LAZY_LOAD=true
source ~/.config/.zsh-nvm/zsh-nvm.plugin.zsh


##############################################################################
# FZF
##############################################################################

source <(fzf --zsh)


##############################################################################
# zsh-you-should-use_MichaelAquilina
##############################################################################

source $HOMEBREW_PREFIX/share/zsh-you-should-use/you-should-use.plugin.zsh



##############################################################################
# colorize_zpm-zsh
##############################################################################

#if [ -d '/Users/manny/.local/share/fig/plugins/colorize_zpm-zsh' ]; then
#source '/Users/manny/.local/share/fig/plugins/colorize_zpm-zsh/colorize.plugin.zsh'
#fi



##############################################################################
# homebrew-command-not-found
##############################################################################

HB_CNF_HANDLER="$HOMEBREW_PREFIX/Library/Taps/homebrew/homebrew-command-not-found/handler.sh"
if [ -f "$HB_CNF_HANDLER" ]; then
source "$HB_CNF_HANDLER";
fi

##############################################################################
# prezto
##############################################################################

#if [ -d '/Users/manny/.local/share/fig/plugins/prezto' ]; then
#zstyle ':prezto:*:*' case-sensitive 'yes'
#zstyle ':prezto:module:editor' key-bindings emacs
#zstyle ':prezto:load' pmodule 'git' 'history' 'homebrew' 'osx' 'spectrum' 'terminal' 'utility'
#zstyle ':prezto:module:git:status:ignore' submodules all
##zstyle ':prezto:module:prompt' theme 
#zstyle ':prezto:load' pmodule-allow-overrides "attr" "stat"
#source '/Users/manny/.local/share/fig/plugins/prezto/init.zsh'
#fi



##############################################################################
# eza
##############################################################################

alias l='eza --icons --color=always --group-directories-first'
alias ls='eza -F --icons --color=always --group-directories-first'
alias ll='eza -alF --icons --color=always --group-directories-first'
alias la='eza -a --icons --color=always --group-directories-first'


##############################################################################
# zsh-autosuggestions
##############################################################################
ZSH_AUTOSUGGEST_STRATEGY=(completion match_prev_cmd)
source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh



# ╭─────────────╮
# │ COMPLETIONS │
# ╰─────────────╯

# zstyle pattern
# :completion:<function>:<completer>:<command>:<argument>:<tag>

# load more completions
if type brew &>/dev/null
then
  fpath=(${HOMEBREW_PREFIX}/share/zsh/site-functions $fpath)
fi

# called before compinit
zmodload zsh/complist

# register homebrew completions
if type brew &>/dev/null
then
  fpath=(${HOMEBREW_PREFIX}/share/zsh-completions $fpath)
fi

# load functions and use the cache directory
autoload -Uz compinit && compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"

# basic completers
zstyle ':completion:*' completer _extensions _complete _approximate

# turn to cache for commands that use it
zstyle ':completion:*' use-cache on
zstyle ':completion::complete:*' cache-path "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"

# autocomplete options for `cd` instead of directory stack
zstyle ':completion:*' complete-options true

# sorty by modification date
zstyle ':completion:*' file-sort modification

# format completion tags
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:*:*:*:descriptions' format '%F{blue}-- %D %d --%f'
zstyle ':completion:*:*:*:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:*:*:*:warnings' format ' %F{red}-- no matches found --%f'

# only display some tags for `cd`
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories

# ordering of groups
zstyle ':completion:*' group-name ''
zstyle ':completion:*:*:-command-:*:*' group-order aliases builtins functions commands

# keep the prefix when activating autocomplete
zstyle ':completion:*' keep-prefix true

#zstyle ':completion:*' menu select



#brew_completion=$(brew --prefix 2>/dev/null)/share/zsh/zsh-site-functions
#if [ $? -eq 0 ] && [ -d "$brew_completion" ];then
#  fpath=($brew_completion $fpath)
#fi
#autoload -U compinit
#compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"

# for d in "/share/zsh-completions" "/share/zsh/zsh-site-functions";do
#  brew_completion=$(brew --prefix 2>/dev/null)$d
#  if [ $? -eq 0 ] && [ -d "$brew_completion" ];then
#    fpath=($brew_completion $fpath)
#  fi
# done

  

##############################################################################
# Brewfile + Brew Wrap
##############################################################################

export HOMEBREW_BUNDLE_FILE="$XDG_CONFIG_HOME"/brewfile/Brewfile
export HOMEBREW_BREWFILE_APPSTORE="2"

# Brew-wrap
 if [ -f $(brew --prefix)/etc/brew-wrap ];then
   source $(brew --prefix)/etc/brew-wrap

   _post_brewfile_update () {
     echo "Brewfile was updated!"
   }
fi

alias -- brewup='brew update && brew upgrade && brew cu --no-brew-update --interactive --include-mas --cleanup && brew doctor'
alias -- brewg='brew graph --installed --highlight-leaves | fdp -T png -o graph.png && open graph.png'
alias -- bfc='brew file casklist && o Caskfile'


################################################
# Paths
################################################

# Ensure path arrays do not contain duplicates.
typeset -gU path fpath
typeset -U PATH path



##############################################################################
function configunlink() {
  for file in .*; do
    # create the link
    unlink ~/.config/$file
    echo -en '\tunlinked';ok
  done
}

##############################################################################
function configlink() {
  for file in *; do
    # create the link
    ln -s ~/.dotfiles/homedir/.config/$file ~/.config/$file;
  done
}

##############################################################################
# function pyenv-brew-relink() {
# rm -f "$HOME/.pyenv/versions/*-brew"
#     for i in $(brew --cellar)/python* ; do
#       for p in $i/*; do
#         echo $p
#         ln -s -f $p $HOME/.pyenv/versions/${p##/*/}-brew
#       done  
#     done
#     pyenv rehashrm -f "$HOME/.pyenv/versions/*-brew"
#     for i in $(brew --cellar)/python* ; do
#         ln -s -f "$p" "$HOME/.pyenv/versions/${i##/*/}-brew"
#     done
#     pyenv rehashrm -f "$HOME/.pyenv/versions/*-brew"
#     for i in $(brew --cellar)/python* ; do
#       for p in $i/*; do
#         echo $p
#         ln -s -f $p $HOME/.pyenv/versions/${p##/*/}-brew
#       done  
#     done
#     pyenv rehashrm -f "$HOME/.pyenv/versions/*-brew"
#     for i in $(brew --cellar)/python* ; do
#       for p in $i/*; do
#         echo $p
#         ln -s -f $p $HOME/.pyenv/versions/${p##/*/}-brew
#       done  
#     done
#     pyenv rehash
# }

##############################################################################
function symlink2() {  
  bot "creating symlinks for project dotfiles..."
  pushd homedir > /dev/null 2>&1
  now=$(date +"%Y.%m.%d.%H.%M.%S")

  for file in .*; do
    if [[ $file == "." || $file == ".." ]]; then
      continue
    fi
    running "~/$file"
    # if the file exists:
    if [[ -e ~/$file ]]; then
        mkdir -p ~/.dotfiles_backup/$now
        mv ~/$file ~/.dotfiles_backup/$now/$file
        echo "backup saved as ~/.dotfiles_backup/$now/$file"
    fi
    # symlink might still exist
    unlink ~/$file > /dev/null 2>&1
    # create the link
    ln -s ~/.dotfiles/homedir/$file ~/$file
    echo -en '\tlinked';ok
  done

  popd > /dev/null 2>&1
  }

##############################################################################
# zoxide
##############################################################################
export _ZO_DATA_DIR=$XDG_DATA_HOME/zoxide
export FZF_DEFAULT_OPTS='--height 40%'
eval "$(zoxide init zsh)"


##############################################################################
# zsh-syntax-highlighting
##############################################################################
source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh