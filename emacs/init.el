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

;; Package repositories setup
(require 'package)
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

;; Setup use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))
(setq use-package-always-ensure t)  ;; Always ensure packages are installed

;; General editor settings
(use-package emacs
  :ensure nil  ;; 'emacs' is a built-in package
  :config
  (setq-default show-trailing-whitespace t)
  (setq-default indicate-empty-lines t)
  (setq auto-save-file-name-transforms '((".*" "~/.emacs.d/backup/" t)))
  (setq backup-directory-alist '(("." . "~/.emacs.d/backup/")))
  (setq create-lockfiles nil)
  (remove-hook 'text-mode-hook #'turn-on-auto-fill))

;; Text modes and spell checking
(use-package flyspell
  :hook (text-mode . flyspell-mode))

;; Auto-complete
(use-package auto-complete
  :config
  (ac-config-default))

;; Python development with elpy
(use-package elpy
  :init
  (elpy-enable)
  :config
  (setenv "WORKON_HOME" "/Users/kevinklein/micromamba/envs")
  (setq elpy-rpc-virtualenv-path "/Users/kevinklein/micromamba/envs/elpy-rpc/")
  (setq python-shell-interpreter "ipython"
        python-shell-interpreter-args "-i")
  (setq elpy-eldoc-show-current-function nil)
  :custom
  (elpy-modules '(elpy-module-company
                  elpy-module-eldoc
                  elpy-module-pyvenv
                  elpy-module-highlight-indentation
                  elpy-module-yasnippet
                  elpy-module-sane-defaults)))

;; Conda support
(use-package conda)

;; Syntax checking
(use-package flycheck
  :init
  (global-flycheck-mode)
  :config
  (setq-default flycheck-disabled-checkers '(python-pylint)))

;; Markdown mode
(use-package markdown-mode
  :hook ((markdown-mode . outline-minor-mode)
         (markdown-mode . visual-line-mode)))

;; YAML mode
(use-package yaml-mode
  :mode "\\.yml\\'"
  :hook (yaml-mode . visual-line-mode))

;; JSON mode
(use-package json-mode)

;; RST mode
(use-package rst)

;; Git interface
(use-package magit)

;; Multiple cursors
(use-package multiple-cursors
  :bind (("C-c m c" . mc/edit-lines)))

;; Rust mode
(use-package rust-mode)

;; Org mode configuration
(use-package org
  :ensure nil  ;; org is built-in
  :config
  (setq org-log-done 'time)
  (setq org-todo-keywords
        '((sequence "TODO" "PROGRESS" "|" "DONE" "ABORTED"))))

;; Web preview mode
(use-package impatient-mode)

(setq warning-suppress-log-types '(((python python-shell-completion-native-turn-on-maybe))))
