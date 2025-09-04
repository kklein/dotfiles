;; Basic UI and behavior settings

(setq mac-command-modifier 'meta)
(setq inhibit-startup-message t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(fset 'yes-or-no-p 'y-or-n-p)
(global-auto-revert-mode t)
(global-display-line-numbers-mode)
(column-number-mode)
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

(global-whitespace-mode 1)
(setq-default show-trailing-whitespace t)
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/backup/" t)))
(setq backup-directory-alist '(("." . "~/.emacs.d/backup/")))
(setq create-lockfiles nil)

;; Package management setup via straight.el

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(setq package-enable-at-startup nil)
(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

;; Modes for various text files

(use-package markdown-mode
  :hook ((markdown-mode . outline-minor-mode)
         (markdown-mode . visual-line-mode)))

(use-package yaml-mode
  :mode "\\.yml\\'"
  :hook (yaml-mode . visual-line-mode))

(use-package json-mode
  :mode "\\.json\\'")

(use-package rst)

(use-package org
  :config
  (setq org-log-done 'time)
  (setq org-todo-keywords
        '((sequence "TODO" "PROGRESS" "|" "DONE" "ABORTED"))))

;; Modes for programming languages

(use-package rust-mode)

(use-package lsp-mode
  :hook (python-mode . lsp-deferred)
  :commands lsp-deferred
  :custom
  (lsp-headerline-breadcrumb-enable nil)) ; optional minimalism

(use-package lsp-pyright
  :after lsp-mode
  :hook (python-mode . (lambda () (require 'lsp-pyright))))

;; Miscellaneous

(use-package flyspell
  :hook (text-mode . flyspell-mode)
  :config
  (setq ispell-program-name "/opt/homebrew/bin/hunspell")
  (setq ispell-really-hunspell t)
  (setq ispell-dictionary "english"))

(use-package envrc
  :hook (after-init . envrc-global-mode))

(use-package gptel
  :custom
  (gptel-model 'gpt-5))
