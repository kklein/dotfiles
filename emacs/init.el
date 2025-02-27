(setq mac-command-modifier 'meta)

(setq inhibit-startup-message t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(fset 'yes-or-no-p 'y-or-n-p)
(global-auto-revert-mode t)
(global-display-line-numbers-mode)

;; Dependency management
(require 'package)
(require 'use-package)

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))

(defvar my-packages '(auto-complete
		      elpy
		      flycheck
                      json-mode
                      markdown-mode
                      yaml-mode
		      rst
		      magit
		      multiple-cursors
		      conda
		      rust-mode
		      csv-mode
		      graphviz-dot-mode
                      ))

(dolist (p my-packages)
  (unless (package-installed-p p)
    (package-refresh-contents)
    (package-install p))
  (add-to-list 'package-selected-packages p))

(remove-hook 'text-mode-hook #'turn-on-auto-fill)
(remove-hook 'markdown-mode-hook #'turn-on-auto-fill)

(add-hook 'after-init-hook #'global-flycheck-mode)
(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'markdown-mode-hook 'outline-minor-mode)
(add-hook 'markdown-mode-hook 'visual-line-mode)
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-hook 'yaml-mode-hook 'visual-line-mode)

(elpy-enable)
(setenv "WORKON_HOME" "/Users/kevinklein/micromamba/envs")
(setq elpy-rpc-virtualenv-path "/Users/kevinklein/micromamba/envs/elpy-rpc/")
(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args "-i --simple-prompt")
(setq elpy-eldoc-show-current-function nil)


(setq org-log-done 'time)
(setq org-todo-keywords
      '((sequence "TODO" "PROGRESS" "|" "DONE" "ABORTED")))


(setq-default show-trailing-whitespace t)
(setq-default indicate-empty-lines t)

(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/backup/" t)))
(setq backup-directory-alist '(("." . "~/.emacs.d/backup/")))
(setq create-lockfiles nil)
(column-number-mode)

(setq-default flycheck-disabled-checkers '(python-pylint))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(elpy-modules
   '(elpy-module-company elpy-module-eldoc elpy-module-pyvenv elpy-module-highlight-indentation elpy-module-yasnippet elpy-module-sane-defaults))
 '(package-selected-packages
   '(impatient-mode magit rst yaml-mode visual-fill-column markdown-mode json-mode flycheck elpy auto-complete))
 '(warning-suppress-log-types '(((python python-shell-completion-native-turn-on-maybe)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(global-set-key (kbd "C-c m c") 'mc/edit-lines)

(use-package graphviz-dot-mode
  :ensure t
  :config
  (setq graphviz-dot-indent-width 4))

(setq markdown-command '("pandoc" "--from=markdown" "--to=html5"))

