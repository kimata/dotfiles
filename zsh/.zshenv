################################################################################
# 環境変数
################################################################################
export LANG=ja_JP.UTF-8
export LANGUAGE=ja                      # 日本語
export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8
export G_BROKEN_FILENAMES=1

export TZ=Asia/Tokyo                    # タイムゾーン

export GREP_COLOR='01;33'		# grep
export LESS='-x4 -g -M -i -R -W'        # less
export EMACS_VERSION=${${${(f)"$(emacs --version)"}[1]}##GNU Emacs } # Emacs

# Local Variables:
# mode: sh
# End:
################################################################################
