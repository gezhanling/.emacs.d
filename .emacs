;;Location  C:\Users\ge_zh\AppData\Roaming

(defvar bash-path "D:/msys64/usr/bin/bash.exe")

(setq custom-file (expand-file-name "C:/Users/ge_zh/AppData/Roaming/.emacs.d/lisp/custom.el"))
(load custom-file 'no-error 'no-message)

(add-to-list 'load-path "C:/Users/ge_zh/AppData/Roaming/.emacs.d/lisp/")

(require 'init-packages)
(require 'init-better-defaults)
(require 'init-keybindings)
(require 'init-org)
(require 'init-ui)

  

