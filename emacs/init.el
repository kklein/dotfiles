(require 'clojure-mode)
(autoload 'paredit-mode "paredit"
  "Minor mode for pseudo-structurally editing Lisp code." t)

;; (add-hook clojure-mode-hook (lambda () (paredit-mode +1)))

(setq inhibit-startup-message t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(global-hl-line-mode t)
(line-number-mode t)
(column-number-mode t)
(setq fill-column 100)


(setq org-log-done 'time)
(setq org-todo-keywords '((sequence "TODO" "WAITING" "DONE")))
(setq org-tag-alist '(("IU" . nil) ("I!U" . nil) ("!IU" . nil) ("!I!U" . nil)))

(require 'flyspell)
(flyspell-mode +1)
