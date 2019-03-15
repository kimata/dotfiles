################################################################################
# 基本設定
umask 022                               # パーミッションのマスク

HISTFILE=${HOME}/.zsh_history          	# change history file for root/sudo
HISTSIZE=100000                         # メモリ内の履歴の数
SAVEHIST=100000                         # 保存される履歴の数

setopt extended_history                 # コマンドの開始時刻と経過時間を登録
setopt hist_ignore_all_dups             # 重複ヒストリは古い方を削除
setopt hist_reduce_blanks               # 余分なスペースを削除
setopt share_history                    # ヒストリの共有 for GNU Screen
setopt hist_no_store                    # historyコマンドは登録しない
setopt hist_ignore_space                # コマンド行先頭が空白の時登録しない

setopt autopushd
setopt pushd_ignore_dups

setopt extended_glob
setopt menu_complete
setopt correct

zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

bindkey -e
bindkey "^[[Z" reverse-menu-complete

autoload -Uz zmv
autoload -Uz is-at-least

if [ -f /etc/zsh_command_not_found ]; then
    source /etc/zsh_command_not_found
fi

if [ ! -f /usr/share/autojump/autojump.sh ]; then
    sudo apt install autojump
fi
. /usr/share/autojump/autojump.sh

################################################################################
# エイリアス
if (which dircolors >& /dev/null) then	# dircolors
   eval `dircolors ~/.dircolors`
fi
if (which gnuls >& /dev/null) then
    alias ls='gnuls -F --color=auto'
elif (uname | grep Linux >& /dev/null) then
    alias ls='ls -F --color=auto'
else
    alias ls='ls -FG'
fi
     
if (which colordiff >& /dev/null) then	# diff
    alias diff=colordiff
fi

for editor in vim vi			# editor
do
  if (which $editor >& /dev/null) then
      export EDITOR=$editor
      break
  fi
done

alias rm='nocorrect =rm -i'             # スペル訂正をしない
alias mv='nocorrect =mv -i'
alias cp='nocorrect =cp -i'

alias keychain='keychain --nogui'       # keychain

if [[ ($EMACS_VERSION > 22.9) && ($SUDO_USER != root) ]] then # emacs
    alias emacs='emacsclient -a =emacs -t' 
fi

alias less='less -R'                    # less
alias vi='vim'                          # vi

alias ack='ack -group --color'          # ack
alias nl='nl -ba'                       # nl
alias df='df -h'                        # df

alias bell='echo -ne "\a"'              # bell
alias reset='echo -ne "\eP\ec\e\\" && =reset && clear' # reset

alias lshw='lshw -disable scsi'         # lshw

################################################################################
# グローバルエイリアス
alias -g L='|& less -R'
alias -g G='|& grep'
alias -g H='| head'
alias -g C='| colordiff'
alias -g T='| tail'
alias -g S='| sort'
alias -g A='| awk'
alias -g W='| wc'

alias -g O='2>&1'
alias -g N='>/dev/null'
alias -g NE='2>/dev/null'
alias -g NB='>&/dev/null'

alias -g P='| perl -pe "s/\e\[\d+(;\d+)?m//g" | col -bx'

################################################################################
# サフィックスエイリアス
if is-at-least 4.2; then
    alias -s {tar.gz,tar.Z,tgz,tar,gz,zip,tar,bz2,tbz2,bz2,lzh,rar,Z}='muncompress'
fi

muncompress () {
    for file in "$@"
      do
      case $file in
          *.tar.gz ) tar xzvf   $file ;;
          *.tar.Z  ) tar xzvf   $file ;;
          *.tgz    ) tar xzvf   $file ;;
          *.tar    ) tar xvf    $file ;;
          *.gz     ) gunzip     $file ;;
          *.zip    ) unzip      $file ;;
          *.tar.bz2) tar xjvf   $file ;;
          *.tbz2   ) tar xjvf   $file ;;
          *.bz2    ) bzip2 -d   $file ;;
          *.lzh    ) lha x      $file ;;
          *.rar    ) rar x      $file ;;
          *.Z      ) uncompress $file ;;
	      *)
              echo "Can't decide how to uncompress $file."
              ;;
		esac
	done
}

################################################################################
# zplug
################################################################################
if [ ! -f ~/.zplug/init.zsh ]; then
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh
fi
source ~/.zplug/init.zsh
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-history-substring-search"
zplug "willghatch/zsh-cdr"
zplug "zsh-users/zsh-completions"

zplug "plugins/git",   	    from:oh-my-zsh
zplug "plugins/autojump",   from:oh-my-zsh
zplug "modules/prompt",     from:prezto
zplug 'dracula/zsh', as:theme

zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zaw", defer:2

zplug check || zplug install
zplug load

################################################################################
# カラー
################################################################################
case ${SOLARIZED_THEME:-dark} in
    light) bkg=white;;
    *)     bkg=black;;
esac

case `whoami` in
     root) ucolor=red;;
     *)    ucolor=green;;   
esac

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
ZSH_HIGHLIGHT_STYLES[alias]='none'
ZSH_HIGHLIGHT_STYLES[builtin]='none'
ZSH_HIGHLIGHT_STYLES[function]='none'
ZSH_HIGHLIGHT_STYLES[command]='none'
ZSH_HIGHLIGHT_STYLES[precommand]='none'
ZSH_HIGHLIGHT_STYLES[commandseparator]='none'
ZSH_HIGHLIGHT_STYLES[hashed-command]='none'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=198'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=215'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=215'

################################################################################
# プロンプト
################################################################################

setopt prompt_subst

ZSH_THEME_GIT_PROMPT_PREFIX=" [%{%B%F{blue}%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{%f%k%b%K{${bkg}}%B%F{green}%}]"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{%F{red}%}*%{%f%k%b%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

PROMPT='%{%f%k%b%}
%{%K{${bkg}}%B%F{${ucolor}}%}%n%{%B%F{blue}%}@%{%B%F{cyan}%}%m%{%B%F{green}%} %{%b%F{yellow}%K{${bkg}}%}%~%{%B%F{green}%}$(git_prompt_info)%E%{%f%k%b%}
%{%K{${bkg}}%}%{%K{${bkg}}%} %B%# %{%f%k%b%}%b'
RPROMPT=''

################################################################################
# Keychain 等
################################################################################
stty stop undef
if [[ ($TERM == xterm*) || (-z $SSH_CLIENT && -z $EMACS) ]]; then
    if [[ -z $TMUX_PANE ]]; then
        # keychain
        if (which =keychain >& /dev/null) then
            keychain ~/.ssh/*.id_rsa
            if [[ -e ~/.keychain/`hostname`-sh ]]; then
                    source ~/.keychain/`hostname`-sh >& /dev/null
            fi
        fi

        # emacs
        local EMACS_VERSION=${${${(f)"$(emacs --version)"}[1]}##GNU Emacs }
        if [[ $EMACS_VERSION > 22.9 ]] then
#            =emacs --daemon
        fi

        # tmux
        tmux a || tmux || echo 'Unable to start tmux.'
    elif (which =keychain >& /dev/null) then
        keychain ~/.ssh/*.id_rsa
        if [[ -e ~/.keychain/`hostname`-sh ]]; then
	        source ~/.keychain/`hostname`-sh >& /dev/null
        fi
        # clear
    fi
fi

# Local Variables:
# mode: sh
# End:
###############################################################################
