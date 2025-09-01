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

;; Markdown mode
(use-package markdown-mode
  :hook ((markdown-mode . outline-minor-mode)
         (markdown-mode . visual-line-mode)))

;; YAML mode
(use-package yaml-mode
  :mode "\\.yml\\'"
  :hook (yaml-mode . visual-line-mode))

;; JSON mode
(use-package json-mode
  :mode "\\.json\\'")

;; RST mode
(use-package rst)
