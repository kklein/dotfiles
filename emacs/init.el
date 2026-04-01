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
;; This is just a hack to avoid overbearing visualization for long lines.
(setq whitespace-line-column 100000)

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
  :mode "\\.json\\'"
  :config
  (setq js-indent-level 2))

(use-package rst)

(use-package yasnippet
  :config
  (yas-global-mode 1))

(use-package org
  :config
  (setq org-log-done 'time)
  (setq org-todo-keywords
        '((sequence "TODO" "PROGRESS" "|" "DONE" "ABORTED"))))

;; Modes for programming languages

(use-package rust-mode

  :config
  (add-hook 'rust-mode-hook
            (lambda () (setq indent-tabs-mode nil)))
  (setq rust-format-on-save t)
  (define-key rust-mode-map (kbd "C-c C-c") 'rust-run)
  (setq error_stack-regexps
    '("\\(?:at\\|',\\) \\(\\([^:\s]+\\):\\([0-9]+\\)\\)"
      2 3 nil nil 1))
  (setf (cdr (assoc 'cargo compilation-error-regexp-alist-alist))
        error_stack-regexps)
  )

;; install required inheritenv dependency:
(use-package inheritenv
  :straight (:type git :host github :repo "purcell/inheritenv"))

;; for eat terminal backend:
(use-package eat
  :straight (:type git
                   :host codeberg
                   :repo "akib/emacs-eat"
                   :files ("*.el" ("term" "term/*.el") "*.texi"
                           "*.ti" ("terminfo/e" "terminfo/e/*")
                           ("terminfo/65" "terminfo/65/*")
                           ("integration" "integration/*")
                           (:exclude ".dir-locals.el" "*-tests.el"))))

(use-package monet
  :straight (:type git :host github :repo "stevemolitor/monet"))

;; install claude-code.el, using :depth 1 to reduce download size:
(use-package claude-code
  :straight (:type git :host github :repo "stevemolitor/claude-code.el" :branch "main" :depth 1
                   :files ("*.el" (:exclude "images/*")))
  :bind-keymap
  ("C-c c" . claude-code-command-map) ;; or your preferred key
  ;; Optionally define a repeat map so that "M" will cycle thru Claude auto-accept/plan/confirm modes after invoking claude-code-cycle-mode / C-c M.
  :bind
  (:repeat-map my-claude-code-map ("M" . claude-code-cycle-mode))
  :config
  ;; optional IDE integration with Monet
  (add-hook 'claude-code-process-environment-functions #'monet-start-server-function)
  (monet-mode 1)

  (claude-code-mode))

(use-package magit
  :straight t
  :defer t
  :bind (("C-x g" . magit-status)))

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

(with-eval-after-load 'lsp-mode
  (add-to-list 'lsp-file-watch-ignored-directories "/\\.pixi\\'"))
