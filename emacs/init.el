; Generated by Ansible for {{ ansible_nodename  }}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; パッケージ
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'package)
(add-to-list 'package-archives '("gnu"   . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("org"   . "http://orgmode.org/elpa/"))

(package-initialize)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 基本設定
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 言語
(set-language-environment 'Japanese);           ; 日本語
(prefer-coding-system 'utf-8-unix)              ; 文字コードは基本 UTF-8
(set-default 'buffer-file-coding-system 'utf-8-unix)

; タブ
(setq-default tab-width 4)                      ; タブ幅は 4
(setq-default indent-tabs-mode nil)             ; タブはスペースに変換
(setq-default indent-level 4)                   ; インデント幅は 4
(setq c-basic-offset 4)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 色
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(package-install 'moe-theme)
(require 'moe-theme)
(moe-dark)

(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 表示
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 行
(setq line-number-display-limit-width 10000)
(line-number-mode t)
(column-number-mode t)

; 括弧
(show-paren-mode t)
(setq show-paren-delay 0)
(setq show-paren-style 'parenthesis)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 便利機能
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 自動保存
(package-install 'auto-save-buffers-enhanced)
(auto-save-buffers-enhanced t)

; カーソル位置を保存
(package-install 'session)
(setq session-save-file "~/.emacs-session")
(add-hook 'after-init-hook 'session-initialize)

; 最近使ったファイル
(package-install 'recentf-ext)
(setq recentf-max-saved-items 1000)
(setq recentf-auto-cleanup 10)
(setq recentf-auto-save-timer (run-with-idle-timer 30 t 'recentf-save-list))

; 履歴を永続化
(savehist-mode 1)

; スペースの自動挿入
(package-install 'electric-spacing)

; helm
(package-install 'helm)

(require 'helm-config)
(helm-mode 1)

(define-key global-map          (kbd "M-x"      ) 'helm-M-x)
(define-key global-map          (kbd "C-x C-f"  ) 'helm-find-files)
(define-key global-map          (kbd "C-x C-r"  ) 'helm-recentf)
(define-key global-map          (kbd "M-y"      ) 'helm-show-kill-ring)
(define-key helm-map            (kbd "C-h"      ) 'delete-backward-char)
(define-key helm-find-files-map (kbd "C-h"      ) 'delete-backward-char)
(define-key helm-find-files-map (kbd "TAB"      ) 'helm-execute-persistent-action)
(define-key helm-map            (kbd "C-z"      ) 'helm-select-action)
; NOTE: helm-find-files では C-j でディレクトリオープン．C-l で上のディレクトリ移動．

; 補完
(global-set-key (kbd "C-M-_") 'dabbrev-completion)

; ファイルが更新されたら読み込み直す
(global-auto-revert-mode 1)

; バッファ切り替え
(require 'ibuffer)
(setq ibuffer-default-sorting-mode 'alphabetic)

(define-ibuffer-column row
  (:name "Rows" :inline t)
  (format "%5d" (count-lines (point-min) (point-max))))

(define-ibuffer-column coding
  (:name " coding ")
  (if (coding-system-get buffer-file-coding-system 'mime-charset)
      (format " %s" (coding-system-get buffer-file-coding-system 'mime-charset))
    " undefined"))

(define-ibuffer-column size-h
  (:name "Size" :inline t)
  (cond
   ((> (buffer-size) 1000000) (format "%7.1fM" (/ (buffer-size) 1000000.0)))
   ((> (buffer-size) 1000) (format "%7.1fk" (/ (buffer-size) 1000.0)))
   (t (format "%8d" (buffer-size)))))

(setq ibuffer-formats '((mark modified read-only
                              " " (name 25 40 :left :elide)
                              " " (size-h 9 -1 :right)
                              " " (row 5 -1 :right)
                              " " (mode 16 16 :left :elide)
                              " " (coding 12 12 :right)
                              " " filename-and-process)
                        (mark " " (name 16 -1)
                              " " filename)))

(define-key global-map (kbd "C-x b") 'helm-buffers-list)
(define-key global-map (kbd "C-x C-b") 'ibuffer)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; バックアップ
(setq make-backup-files t)                      ; バックアップを作成
(setq vc-make-backup-files t)                   ; VC の管理下にあっても作成
(setq backup-directory-alist
      (cons (cons "\\.*$" (expand-file-name "~/.emacs.d/backup"))
                        backup-directory-alist))
(setq version-control t)                        ; バージョン管理する
(setq kept-new-versions 20)                     ; 新しいものは 10 世代
(setq delete-old-versions t)                    ; 確認せずに古いものを削除

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ファイルタイプ別のメジャーモード
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(package-install 'flycheck)
(package-install 'ruby-mode)
(package-install 'perl-mode)
(package-install 'yaml-mode)
(package-install 'css-mode)
(package-install 'typescript-mode)
(package-install 'vue-mode)
(setq js-indent-level 2)

(package-install 'rust-mode)
(setq rust-format-on-save t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; その他
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; #! で始まっていればファイル保存時に実行権限を与える
(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)

; サイズ 0 のファイルは削除
(if (not (memq 'delete-file-if-no-contents after-save-hook))
    (setq after-save-hook
          (cons 'delete-file-if-no-contents after-save-hook)))
(defun delete-file-if-no-contents ()
  (when (and
         (buffer-file-name (current-buffer))
         (= (point-min) (point-max)))
    (when (y-or-n-p "Delete file and kill buffer?")
      (delete-file
       (buffer-file-name (current-buffer)))
      (kill-buffer (current-buffer)))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (perl-mode ruby-mode migemo yaml-mode session redo+ recentf-ext moe-theme helm electric-spacing auto-save-buffers-enhanced)))
 '(session-use-package t nil (session)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
