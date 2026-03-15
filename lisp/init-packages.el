(use-package package :ensure t)
(setq package-archives '(;("gnu-qh"    . "https://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ;("nongnu-qh" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")
                         ;("melpa-qh"  . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
						 ;("melpa"  . "https://melpa.org/packages/")
						 ;("gnu"    . "https://elpa.gnu.org/packages/")
						 ;("nongnu" . "https://elpa.nongnu.org/nongnu/")
						 ("gnu-nju"    . "https://mirror.nju.edu.cn/elpa/gnu/")						 
                         ("nongnu-nju" . "https://mirror.nju.edu.cn/elpa/nongnu/")
                         ("melpa-nju"  . "https://mirror.nju.edu.cn/elpa/melpa/")))
(package-initialize)

;;防止反复调用 package-refresh-contents 会影响加载速度
(when (not package-archive-contents)
  (package-refresh-contents))

(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-peacock t)
  (doom-themes-visual-bell-config)
  (doom-themes-org-config))

(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode)
  :config
  (setq doom-modeline-enable-word-count t)
  (setq doom-modeline-buffer-encoding t)
  (setq doom-modeline-github nil))

(use-package evil
  :ensure t  ; 确保安装
  :init
  (setq evil-want-keybinding nil)  ; 如果使用 evil-collection 可能需要此设置
  :config
  (evil-mode 1))  ; 启动 evil-mode

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

;; 配置 evil-nerd-commenter
(use-package evil-nerd-commenter
  :ensure t  ; 确保安装
  :after (evil)  ; 确保在 evil 之后加载
  :config
  ;; 设置默认快捷键，这是关键一步！
  (evilnc-default-hotkeys))

;;undo-tree
(use-package undo-tree
  :ensure t
  :diminish
  :init
  (global-undo-tree-mode 1)
  (setq undo-tree-auto-save-history nil)
  (evil-set-undo-system 'undo-tree))

(use-package vertico ;; 补全界面优化
  :ensure t
  :config
  (vertico-mode))
  
(use-package orderless ;; 无序搜索
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)))))
  
(use-package embark :ensure t)
(setq prefix-help-command 'embark-prefix-help-command)

(use-package which-key :ensure t)
(which-key-mode 1)   ; 全局启用 which-key 模式

(use-package org-superstar
  :ensure t               ; 确保从 MELPA 安装包
  :after org              ; 在 org 包之后加载
  :hook (org-mode . org-superstar-mode)  ; 在 org-mode 中自动启用 org-superstar-mode
  :config                 ; 包加载后的配置
  ;; 自定义标题符号（可选）
  (setq org-superstar-headline-bullets-list '("✹" "✸" "✷" "★" "✦" "✶" "*"))
  ;; 隐藏前导星号（可选）
  (setq org-hide-leading-stars t)
)

(use-package consult :ensure t)
(global-set-key (kbd "C-s") 'consult-line)

(use-package embark-consult :ensure t)
(use-package wgrep :ensure t)
(setq wgrep-auto-save-buffer t)

(eval-after-load
  'consult
  '(eval-after-load
     'embark
     '(progn
        (require 'embark-consult)
        (add-hook
         'embark-collect-mode-hook
         #'consult-preview-at-point-mode))))

(use-package evil-surround
  :ensure t
  :hook (after-init . global-evil-surround-mode))		 
		 
(use-package evil-anzu
  :ensure t
  :after evil
  :diminish
  :demand t
  :init
  (global-anzu-mode t))
		 
(use-package evil-snipe
  :ensure t
  :diminish
  :init
  (evil-snipe-mode +1)
  (evil-snipe-override-mode +1))		 
	
(setq treesit-language-source-alist
      '((bash . ("https://github.com/tree-sitter/tree-sitter-bash" "v0.23.0" nil nil nil))
        (python . ("https://github.com/tree-sitter/tree-sitter-python" "v0.23.0" nil nil nil))
		(c . ("https://github.com/tree-sitter/tree-sitter-c" "v0.21.4" nil nil nil))
		(cpp . ("https://github.com/tree-sitter/tree-sitter-cpp" "v0.22.3" nil nil nil))
       ))
	
(use-package treesit-auto
  :ensure t
  :config
  (setq treesit-auto-install t)
  (setq treesit-font-lock-level 4)
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))
  
 
		 
;; 文件末尾
(provide 'init-packages)