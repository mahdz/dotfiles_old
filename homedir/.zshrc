#!/bin/zsh
################################################
# .zshrc - Zsh file loaded on interactive shell sessions.
################################################

source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
source /opt/homebrew/opt/chruby/share/chruby/auto.sh
chruby ruby-3.1.2


##############################################################################
# Python
##############################################################################

#alias -- python='/opt/homebrew/bin/python3'
#command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
#eval "$(pyenv init -)"
#PYENV_ROOT="$HOME/.pyenv"=


##############################################################################
# zsh-completions
##############################################################################

if type brew &>/dev/null; then
          FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

          autoload -Uz compinit
          compinit
        fi


##############################################################################
# FZF
##############################################################################

eval "$(fzf --zsh)"


##############################################################################
# zsh-autosuggestions
##############################################################################
ZSH_AUTOSUGGEST_STRATEGY=(completion match_prev_cmd)
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh


##############################################################################
# zsh-nvm
##############################################################################

if [ -d '/Users/manny/.local/share/fig/plugins/zsh-nvm' ]; then
NVM_COMPLETION="true"
NVM_LAZY_LOAD="true"
NVM_AUTO_USE="true"
source '/Users/manny/.local/share/fig/plugins/zsh-nvm/zsh-nvm.plugin.zsh'
fi

##############################################################################
# zsh-colored-man-pages_ael-code
##############################################################################

if [ -d '/Users/manny/.local/share/fig/plugins/zsh-colored-man-pages_ael-code' ]; then

source '/Users/manny/.local/share/fig/plugins/zsh-colored-man-pages_ael-code/colored-man-pages.plugin.zsh'
fi

alias -- ta='t a -t'
alias -- t='tmux'
alias -- tls='t ls'
alias -- tn='t new -t'

##############################################################################
# colorize_zpm-zsh
##############################################################################

if [ -d '/Users/manny/.local/share/fig/plugins/colorize_zpm-zsh' ]; then

source '/Users/manny/.local/share/fig/plugins/colorize_zpm-zsh/colorize.plugin.zsh'
fi

##############################################################################
# zsh-you-should-use_MichaelAquilina
##############################################################################

if [ -d '/Users/manny/.local/share/fig/plugins/zsh-you-should-use_MichaelAquilina' ]; then

source '/Users/manny/.local/share/fig/plugins/zsh-you-should-use_MichaelAquilina/you-should-use.plugin.zsh'
fi

##############################################################################
# zsh-command-not-found_Tarrasch
##############################################################################

if [ -d '/Users/manny/.local/share/fig/plugins/zsh-command-not-found_Tarrasch' ]; then

source '/Users/manny/.local/share/fig/plugins/zsh-command-not-found_Tarrasch/command-not-found.plugin.zsh'
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
# zsh-aliases-exa_DarrinTisdale

if [ -d '/Users/manny/.local/share/fig/plugins/zsh-aliases-exa_DarrinTisdale' ]; then
source '/Users/manny/.local/share/fig/plugins/zsh-aliases-exa_DarrinTisdale/zsh-aliases-exa.plugin.zsh'
fi

COLUMNS="80"
alias -- l='eza --icons --color=always --group-directories-first'
alias -- ls='eza -F --icons --color=always --group-directories-first'
alias -- ll='eza -alF --icons --color=always --group-directories-first'
alias -- la='eza -a --icons --color=always --group-directories-first'


##############################################################################
# zsh-syntax-highlighting
##############################################################################

source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


##############################################################################
# Brewfile
##############################################################################

HOMEBREW_BREWFILE_APPSTORE="2"

for d in "/share/zsh-completions" "/share/zsh/zsh-site-functions";do
  brew_completion=$(brew --prefix 2>/dev/null)$d
  if [ $? -eq 0 ] && [ -d "$brew_completion" ];then
    fpath=($brew_completion $fpath)
  fi
done
autoload -U compinit
compinit

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
    echo -en '\tlinked';
  done
}
