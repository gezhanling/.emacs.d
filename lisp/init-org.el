(defvar my-roam-path "D:/OneDrive/orgMode/")
(defvar my-agenda-path "D:/OneDrive/orgMode/agenda/")
(defvar my-next-file (concat my-agenda-path "next.org"))
(defvar my-projects-file (concat my-agenda-path "projects.org"))
(defvar my-reading-file (concat my-agenda-path "reading.org"))
(defvar my-temp-file (concat my-roam-path "20240512115955-aatemp.org"))

(use-package org-roam
  :ensure t ;; 自动安装
  :custom
  (org-roam-directory my-roam-path) ;; 默认笔记目录, 提前手动创建好
  (org-roam-dailies-directory "daily\\") ;; 默认日记目录, 上一目录的相对路径
  (org-roam-db-gc-threshold most-positive-fixnum) ;; 提高性能
  :bind (("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ("C-c n l" . org-roam-buffer-toggle) ;; 显示后链窗口
         ("C-c n u" . org-roam-ui-mode) ;; 浏览器中可视化
		 ("C-c n t" . org-roam-tag-add)
		 ("C-c n d c" . org-roam-dailies-capture-today)
		 ("C-c n d t" . org-roam-dailies-goto-today)) 
  :config
  (org-roam-db-autosync-mode)) ;; 启动时自动同步数据库

(use-package org-roam-ui
  :ensure t ;; 自动安装
  :after org-roam
  :custom
  (org-roam-ui-sync-theme t) ;; 同步 Emacs 主题
  (org-roam-ui-follow t) ;; 笔记节点跟随
  (org-roam-ui-update-on-save t))

(setq org-todo-keywords
    '((sequence "TODO(t!)" "NEXT(n)" "WAITTING(w)" "SOMEDAY(s)" "|" "DONE(d@/!)" "ABORT(a@/!)")
     ))

(setq org-agenda-files (directory-files-recursively my-agenda-path "\\.org$"))

(require 'org-capture)
(add-to-list 'org-capture-templates
             `("i" "inbox" entry (file ,(concat my-agenda-path "\\inbox.org"))
               "* TODO %?"))
(setq org-refile-use-outline-path 'file
      org-outline-path-complete-in-steps nil)
(setq org-refile-allow-creating-parent-nodes 'confirm)
(setq org-refile-targets `((my-next-file :level . 0)
                           (my-projects-file :maxlevel . 1)
                           (my-reading-file :level . 0)))

;;Structure Templates
(require 'org-tempo)

;; 在配置中添加
(setq org-file-apps
      '((auto-mode . emacs)
        ("\\.docx\\'" . system)
		("\\.md\\'" . system)
		("\\.xmind\\'" . system)
		("\\.drawio\\'" . system)
        (t . mailcap)))

(use-package org
  :custom-face
  (org-level-1 ((t (:height 1.2 :weight bold))))
  (org-level-2 ((t (:height 1.1 :weight bold))))
  (org-level-3 ((t (:height 1.0 :weight bold))))
  (org-level-4 ((t (:height 1.0 :weight bold))))
  (org-level-5 ((t (:height 1.0 :weight bold))))
  (org-level-6 ((t (:height 1.0 :weight bold))))
  (org-level-7 ((t (:height 1.0 :weight bold))))
)

(with-eval-after-load 'org
  ;; 在 Evil Normal 状态和 Motion 状态下，将 TAB 键绑定到 org-cycle
  (evil-define-key 'normal org-mode-map (kbd "TAB") 'org-cycle)
  (evil-define-key 'motion org-mode-map (kbd "TAB") 'org-cycle)

  ;; 如果你想在 Insert 模式下按 TAB 时，根据上下文执行不同操作
  ;; 例如，在标题行执行 org-cycle，在其他地方插入制表符或执行片段扩展
  (evil-define-key 'insert org-mode-map (kbd "TAB")
    (lambda ()
      (interactive)
      (if (org-at-heading-p) ; 如果当前在标题行
          (org-cycle)        ; 执行 org-cycle
        (indent-for-tab-command)))) ; 否则，执行正常的缩进（可能会触发 Yasnippet 等）
)

;; 启动时打开指定的 Org 文件 以进入org模式
(find-file my-temp-file)

(use-package org-pomodoro
  :ensure t
  :after org
  :config
  (setq org-pomodoro-length 45             ; 工作时长 (分钟)
        org-pomodoro-short-break-length 5  ; 短休息时长 (分钟)
        org-pomodoro-long-break-length 10  ; 长休息时长 (分钟)
        org-pomodoro-keep-completed-for-long-break 4) ; 每4个番茄钟后长休息
  (add-hook 'org-pomodoro-finished-hook
            (lambda ()
              (org-notify "Take a break!!!")
              ))
  (add-hook 'org-pomodoro-short-break-finished-hook
            (lambda ()
              (org-notify "Short break done!!!")
              ))
  (add-hook 'org-pomodoro-long-break-finished-hook
            (lambda ()
              (org-notify "Long break done!!!")
              ))
  (define-key org-mode-map (kbd "C-c p") 'org-pomodoro)
)


;; 文件末尾
(provide 'init-org)