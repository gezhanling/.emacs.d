(use-package package :ensure t)
(setq package-archives '(;("gnu-qh"    . "https://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ;("nongnu-qh" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")
                         ;("melpa-qh"  . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
						 ;("melpa"  . "https://melpa.org/packages/")
						 ;("gnu"    . "https://elpa.gnu.org/packages/")
						 ;("nongnu" . "https://elpa.nongnu.org/nongnu/")
						 ("gnu-nju"    . "https://mirror.nju.edu.cn/elpa/gnu/")						 
                         ("nongnu-nju" . "https://mirror.nju.edu.cn/elpa/nongnu/")
                         ("melpa-nju"  . "https://mirror.nju.edu.cn/elpa/melpa/"))
						)
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
  (setq evil-want-integration t) ;; 关键：让 evil 集成其他包
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

(use-package consult
  :ensure t
  :init
  (setq consult-locate-args "es.exe -i -p -r")  ;; 设置 consult-locate 使用 es.exe
  (add-to-list 'process-coding-system-alist '("es" gbk . gbk))
  :bind
  ;; 全局快捷键绑定
  (("C-s" . consult-line)           ; 替换默认的增量搜索
   ("C-x b" . consult-buffer)       ; 替换切换缓冲区
   ("C-x C-r" . consult-recent-file) ; 替换打开最近文件
   ("C-x i" . consult-locate)
  ))

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
  
(use-package markdown-mode
  :ensure t)
(use-package yasnippet
  :ensure t)	
(add-to-list 'load-path "D:\\OpenProject\\lsp-bridge")
(require 'yasnippet)
(yas-global-mode 1)

(require 'lsp-bridge)
(global-lsp-bridge-mode)
(setq lsp-bridge-enable-auto-start t)
(setq lsp-bridge-python-formatter "ruff")
(setq lsp-bridge-enable-document-highlight t)
(setq lsp-bridge-python-ruff-args '("format" "--line-length" "118" "--stdin-filename"))
(set-face-attribute 'lsp-bridge-document-highlight-face nil
                    :background "#123e71")					
(with-eval-after-load 'lsp-bridge
  ;; 重命名符号
  (define-key lsp-bridge-mode-map (kbd "C-c r") 'lsp-bridge-rename)
  ;; 格式化缓冲区
  (define-key lsp-bridge-mode-map (kbd "C-c f") 'lsp-bridge-code-format)
  (define-key lsp-bridge-mode-map (kbd "C-c o") 'lsp-bridge-peek)
  (define-key evil-normal-state-map (kbd "gd") 'lsp-bridge-find-def)
  (define-key evil-normal-state-map (kbd "gr") 'lsp-bridge-find-references)
  (define-key evil-normal-state-map (kbd "gi") 'lsp-bridge-find-impl)
)

(use-package highlight-indent-guides
  :ensure t
  :hook (python-mode . highlight-indent-guides-mode)
  :hook (python-ts-mode . highlight-indent-guides-mode) ;; 关键：支持新版模式
  :config
  ;; 设置样式：'fill 表示填充色块
  (setq highlight-indent-guides-method 'fill
        highlight-indent-guides-responsive 'top
        highlight-indent-guides-auto-enabled t
        highlight-indent-guides-auto-even-face-perc 20   ; 偶数层加深20%
        highlight-indent-guides-auto-odd-face-perc  10   ; 奇数层加深10%
        highlight-indent-guides-auto-top-odd-face-perc 30 ; 顶层加深30%
        ;; 也可设置顶层偶数层加深百分比
        ;; highlight-indent-guides-auto-top-even-face-perc 25
  ))

(use-package real-auto-save
  :ensure t
  :config
  ;; 设置空闲 2 秒后自动保存
  (setq real-auto-save-interval 228) ; 单位是秒
  ;; 开启全局自动保存模式
  (real-auto-save-mode +1)
  (global-real-auto-save-mode t)
)


	
;; 文件末尾
(provide 'init-packages)