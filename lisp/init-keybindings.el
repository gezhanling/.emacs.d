;;;;org
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
;;ctrl-c ctrl-w refile org
;;("C-c n d" . org-roam-dailies-map) ;; 日记菜单

(evil-global-set-key 'normal (kbd "C-o") 'evil-jump-backward)
(evil-global-set-key 'normal (kbd "C-u") 'evil-jump-forward)
(evil-define-key 'normal 'global (kbd "C-h") 'evil-window-left)
(evil-define-key 'normal 'global (kbd "C-l") 'evil-window-right)

;; 文件末尾
(provide 'init-keybindings)