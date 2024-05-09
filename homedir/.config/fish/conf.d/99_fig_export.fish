set HOMEBREW_BREWFILE_APPSTORE "1"
alias 'brewup' 'brew update && brew upgrade && brew cu --no-brew-update --all --interactive --cleanup && brew doctor && mas outdated'
alias 'brewg' 'brew graph --installed --highlight-leaves | fdp -T png -o graph.png && open graph.png'
alias 'bfc' 'brew file casklist && o Caskfile'
set -x FONTCONFIG_PATH "/opt/X11/lib/X11/fontconfig"
set -x BROWSER "Safari"
set -x SSH_AUTH_SOCK "/Users/manny/Library/Containers/org.hejki.osx.sshce.agent/Data/socket.ssh"
set -x EDITOR "nano"
set LESS_TERMCAP_md "${yellow}"
# alias 'python' '/opt/homebrew/bin/python3'
# command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init -)"
# set PYENV_ROOT "$HOME/.pyenv"
alias 'dnsflush' 'sudo killall -HUP mDNSResponder'
alias 'ip' 'curl ifconfig.co && curl ifconfig.co/country && curl ifconfig.co/country-iso && curl ifconfig.co/city && curl ifconfig.co/asn'

alias '..' 'cd ../'
alias '...' 'cd ../../'
alias 'rmdir' 'trash'
alias 'del' 'trash'
alias 'rm' 'trash'
alias 'mv' 'mv -i'
alias 'zshrc' '${=EDITOR} ~/.zshrc'
alias 'reload' 'reset && exec $SHELL -l'
alias 'c' 'clear;echo "Currently logged in on $(tty), as $(whoami) in directory $(pwd)."'
alias 'r' 'reset'
alias 'dotfilesinstall' 'cd ~/.dotfiles && ./install.sh'
alias 'path' 'echo -e ${PATH//:/\\n}'
alias 'emptytrash' 'sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* '"'"'delete from LSQuarantineEvent'"'"''
alias 'oa' 'open -a'
alias 'pumpitup' 'osascript -e '"'"'set volume output volume 100'"'"''
alias 'updateall' 'sudo softwareupdate -i -a; brewup; sudo gem update --system; sudo gem update; sudo gem cleanup; mas outdated'
alias 'update' 'sudo softwareupdate -i -a'
alias 'restart' 'sudo fdesetup authrestart'
alias 'stfu' 'osascript -e '"'"'set volume output muted true'"'"''
### zsh-nvm is not supported by fish
### zsh-colored-man-pages_ael-code is not supported by fish
alias 'ta' 't a -t'
alias 't' 'tmux'
alias 'tls' 't ls'
alias 'tn' 't new -t'
### colorize_zpm-zsh is not supported by fish
### zsh-you-should-use_MichaelAquilina is not supported by fish
### zsh-command-not-found_Tarrasch is not supported by fish
### prezto is not supported by fish
### powerlevel10k is not supported by fish
### zsh-aliases-exa_DarrinTisdale is not supported by fish
set COLUMNS "80"
alias 'l' 'eza --icons --color=always --group-directories-first'
alias 'ls' 'eza -F --icons --color=always --group-directories-first'
alias 'll' 'eza -alF --icons --color=always --group-directories-first'
alias 'la' 'eza -a --icons --color=always --group-directories-first'
### fzf-zsh-plugin_unixorn is not supported by fish
### z.lua
if test -d '/Users/manny/.local/share/fig/plugins/z.lua'
set _ZL_MATCH_MODE "true"
set _ZL_MATCH_MODE "true"
source '/Users/manny/.local/share/fig/plugins/z.lua/init.fish'
eval "$(lua /Users/manny/.local/share/fig/plugins/z.lua/z.lua --init fish)"
end

### zsh-completions is not supported by fish
### zsh-syntax-highlighting is not supported by fish
### zsh-autosuggestions is not supported by fish
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
function configunlink
  for file in .*; do
    # create the link
    unlink ~/.config/$file
    echo -en '\tunlinked';ok
  done
end
function configlink
  for file in *; do
    # create the link
    ln -s ~/.dotfiles/homedir/.config/$file ~/.config/$file;
  done
end
# function pyenv-brew-relink
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
# end
function symlink2
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
end
for d in "/share/zsh-completions" "/share/zsh/zsh-site-functions";do
  brew_completion=$(brew --prefix 2>/dev/null)$d
  if [ $? -eq 0 ] && [ -d "$brew_completion" ];then
    fpath=($brew_completion $fpath)
  fi
done
autoload -U compinit
compinit
#Brew-wrap
if [ -f $(brew --prefix)/etc/brew-wrap ];then
  source $(brew --prefix)/etc/brew-wrap

  _post_brewfile_update () {
     echo "Brewfile was updated!"
   }

fi