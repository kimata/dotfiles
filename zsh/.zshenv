###############################################################################
# Zsh 設定ファイル - 環境変数
###############################################################################
alias ls='ls -F --color=always'

export LANG=ja_JP.UTF-8
source /etc/zsh_command_not_found

HISTFILE=${HOME}/.zsh_history          	# change history file for root/sudo
HISTSIZE=100000                         # メモリ内の履歴の数
SAVEHIST=100000                         # 保存される履歴の数
setopt extended_history                 # コマンドの開始時刻と経過時間を登録
setopt hist_ignore_all_dups             # 重複ヒストリは古い方を削除
setopt hist_reduce_blanks               # 余分なスペースを削除
setopt share_history                    # ヒストリの共有 for GNU Screen
setopt hist_no_store                    # historyコマンドは登録しない
setopt hist_ignore_space                # コマンド行先頭が空白の時登録しない

setopt extended_glob 

###############################################################################
# 基本設定
# ターミナルが日本語を表示出来ることが前提
export LANGUAGE=ja                      # 日本語
export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8
export G_BROKEN_FILENAMES=1

export TZ=Asia/Tokyo                    # タイムゾーン

umask 022                               # パーミッションのマスク

export EMACS_VERSION=${${${(f)"$(emacs --version)"}[1]}##GNU Emacs } # Emacs

###############################################################################
# コマンド
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

export GREP_COLOR='01;33'		# grep

###############################################################################
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

###############################################################################
# エイリアス
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

# Local Variables:
# mode: sh
# End:
###############################################################################
