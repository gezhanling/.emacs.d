
; (use-package flash
;              :ensure t
;              :defer t
;              :commands (flash-jump flash-jump-continue flash-treesitter)
;              :custom
;              ;; 核心设置：跨窗口跳转、自动跳转gs、折叠识别
;              (flash-multi-window t)
;              (flash-autojump-single t)
;              (flash-fold-aware t)
;              (flash-minimal-label-length 1)
;              ;; 跳转标签字符（顺手的按键）
;              (flash-labels "asdfjkl;ghqwertyuiopzxcvbnm")
;              (flash-label-uppercase nil)
;              :init
;              ;; 与你的 Evil 模式完美集成
;              (with-eval-after-load 'evil
;                                    (require 'flash-evil)
;                                    (flash-evil-setup t)) ; 自动替换 f/t/F/T 为 flash 跳转
;              :config
;              ;; 与 isearch 搜索集成（C-s 时显示跳转标签）
;              (require 'flash-isearch)
;              (flash-isearch-mode 1)
;
;              ;; 全局快捷键：Alt + j 触发快速跳转
;              ;:bind
;              ;("M-j" . flash-jump)
;              )
;
; (use-package smartparens
;              :ensure t
;              :hook (prog-mode . smartparens-mode) ; 编程模式自动开启
;              :config
;              (require 'smartparens-config)          ; 加载默认配置
;              (show-smartparens-global-mode 1))      ; 高亮匹配括号
;
; (use-package rainbow-delimiters
;              :ensure t
;              :hook (prog-mode . rainbow-delimiters-mode))

(pixel-scroll-precision-mode 1)



;; 文件末尾
(provide 'init-ui)
