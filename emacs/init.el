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

(use-package elpy
   :init
   (elpy-enable)
   :config
   (setq python-shell-interpreter "ipython"
         python-shell-interpreter-args "-i")
   (setq elpy-eldoc-show-current-function nil)
   :custom
   (elpy-rpc-virtualenv-path 'current)
   (elpy-modules '(elpy-module-company
                   elpy-module-eldoc
                   elpy-module-pyvenv
                   elpy-module-highlight-indentation
                   elpy-module-yasnippet
                   elpy-module-sane-defaults))
   (elpy-enable))

(use-package flyspell
  :hook (text-mode . flyspell-mode))

;; Miscellaneous

(use-package envrc
  :hook (after-init . envrc-global-mode))

(use-package gptel
  :custom
  ;; TODO: Currently, this is redundant. :(
  (gptel-model 'ChatGPT:gpt-5))
