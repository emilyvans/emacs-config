;; -*- lexical-binding: t; -*-

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-screen t)

(require 'use-package-ensure)
(setq use-package-always-ensure t)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(use-package dracula-theme)

(setq custom-file (file-name-concat user-emacs-directory "custom.el"))
(load custom-file)

(setq backup-directory-alist '(("~/.emacs_saves")))

(use-package company)
(global-company-mode)

(setq company-idle-delay 0)
(setq company-minimum-prefix-length 1)


(use-package irony)
(use-package company-irony)
(use-package magit)

(use-package eshell)
(use-package counsel)
(counsel-mode)

(eval-after-load 'company
  '(add-to-list 'company-backends 'company-irony))

(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)

(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

(set-default 'tab-width '4)
(setq-default indent-tabs-mode t)
(setq c-basic-offset 4)
(setq cperl-indent-level 4)

(set-face-attribute
 'default nil
 :font "CaskaydiaCove Nerd Font"
 :height 100
 :weight 'medium)
(set-face-attribute
 'fixed-pitch nil
 :font "CaskaydiaCove Nerd Font"
 :height 100
 :weight 'medium)

(add-to-list 'default-frame-alist '(font . "CaskaydiaCove Nerd Font"))

(global-display-line-numbers-mode 1)
(global-visual-line-mode t)
(setq display-line-numbers-type 'relative)
(global-whitespace-mode)

;;(keymap-global-unset "<up>")
;;(keymap-global-unset "<down>")
;;(keymap-global-unset "<left>")
;;(keymap-global-unset "<right>")

(global-set-key (kbd "C-x e") #'eglot)
(global-set-key
 (kbd "C-x c")
 (lambda ()
   (interactive)
   (find-file (file-name-concat user-emacs-directory "init.el"))
   )
 )

(add-hook
 'eglot-managed-mode-hook
 (lambda ()
   (keymap-set eglot-mode-map "C-c e f" #'eglot-format)
   (keymap-set eglot-mode-map "C-c e r" #'eglot-rename)
   (keymap-set eglot-mode-map "C-c e x" #'eglot-code-action-extract)
   (keymap-set eglot-mode-map "C-c e a" #'eglot-code-action)
   ))

(add-hook
 'c++-mode-hook
 'eglot-ensure)

(add-hook
 'c-mode-hook
 'eglot-ensure)

