;; add repos
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

;; bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; setup use-package
(defvar use-package-enable-imenu-support t)
(require 'use-package)
(setq
 use-package-always-ensure t ;; downloads packages if not installed
 use-package-verbose t)

;; evil mode
(use-package evil
  :ensure t
  :init
  (setq evil-want-C-u-scroll t)
  (setq evil-want-keybinding nil)
  :config
  (define-key evil-insert-state-map "wq" 'evil-normal-state))
  (evil-mode 1)

;; rice
(setq custom-file "~/.config/emacs/custom.el")
(load custom-file 'noerror)

(use-package gruvbox-theme
  :init
  (load-theme 'gruvbox t))

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(setq display-line-numbers-type 'relative)
