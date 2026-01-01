
(setq show-paren-style 'parenthesis
      show-paren-delay 0
      show-paren-highlight-openparen t
      show-paren-when-point-inside-paren nil
      show-paren-when-point-in-periphery t)
(show-paren-mode 1)

;; Config Tab.
(setq-default default-tab-width 2)
(setq-default tab-width 2)
(setq-local tab-width 2)

;;font	
(when (window-system) ; 仅在图形界面下设置字体
  ;; 设置英文字体 (Nerd Font)
  (set-face-attribute 'default nil :font "FiraCode Nerd Font-16")
  ;; 设置中文字体回退
  (dolist (charset '(kana han cjk-misc bopomofo chinese-gbk))
    (set-fontset-font t charset (font-spec :family "Microsoft YaHei UI")))
  ;; 可选：为符号字符追加 Nerd Font
  (set-fontset-font t 'symbol (font-spec :family "FiraCode Nerd Font") nil 'append)
)

(setq create-lockfiles nil) ; 关闭锁文件生成
(setq make-backup-files nil)
(setq-default make-backup-files nil)
;关闭自动保存模式
(setq auto-save-mode nil)
;不生成 #filename# 临时文件
(setq auto-save-default nil)

;; 设置默认编码为 UTF-8
(set-language-environment "Chinese-GB18030") ; 或 "UTF-8"
(prefer-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-8) ; 关键：剪贴板编码
(setq default-buffer-file-coding-system 'utf-8)
;; Windows 额外配置（如果使用 Windows）
(when (eq system-type 'windows-nt)
  (setq locale-coding-system 'utf-8)
  (setq default-process-coding-system '(utf-8 . utf-8))
  (setq w32-unicode-filenames 't)
  (setq file-name-coding-system 'utf-8)
  (setq selection-coding-system 'utf-8)
  (setq w32-system-coding-system 'gbk) ; 兼容中文 Windows 程序
  (set-clipboard-coding-system 'gbk)
  (setq file-name-coding-system 'gbk)
)	

;; 设置行号显示类型为相对行号
(setq display-line-numbers-type 'relative)
;; 全局启用 display-line-numbers-mode
(global-display-line-numbers-mode 1)

;; Org-mode 中启用视觉换行
(add-hook 'org-mode-hook 'visual-line-mode)

(toggle-frame-maximized)
;; F11 切换最大化或普通化（保留任务栏）
(global-set-key [f11] 'toggle-frame-maximized)

;;新创建创建在右侧
(setq split-height-threshold nil)
(setq split-width-threshold 0)

(server-mode 1)

(setq explicit-shell-file-name bash-path)
(setq shell-file-name "bash")

(global-hl-line-mode +1)

(global-auto-revert-mode 1)

(setq ring-bell-function 'ignore)

(fset 'yes-or-no-p 'y-or-n-p)	

(set-scroll-bar-mode nil)

;; 文件末尾
(provide 'init-better-defaults)