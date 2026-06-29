;;Location  C:\Users\10117\AppData\Roaming

(defvar bash-path "D:/scoop/apps/msys2/2025-08-30/usr/bin/bash.exe")

(setq custom-file (expand-file-name "C:/Users/10117/AppData/Roaming/.emacs.d/lisp/custom.el"))
(load custom-file 'no-error 'no-message)

(add-to-list 'load-path "C:/Users/10117/AppData/Roaming/.emacs.d/lisp/")

(require 'init-packages)
(require 'init-better-defaults)
(require 'init-keybindings)
(require 'init-org)
(require 'init-ui)

  

