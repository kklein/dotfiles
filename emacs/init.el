(setq inhibit-startup-message t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(fset 'yes-or-no-p 'y-or-n-p)
(global-auto-revert-mode t)
(global-display-line-numbers-mode)

;; Dependency management
(require 'package)

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))

(defvar my-packages '(auto-complete
		      elpy
		      flycheck
                      json-mode
                      markdown-mode
                      visual-fill-column
                      yaml-mode
                      ))

(dolist (p my-packages)
  (unless (package-installed-p p)
    (package-refresh-contents)
    (package-install p))
  (add-to-list 'package-selected-packages p))

(ac-config-default)

(add-hook 'after-init-hook #'global-flycheck-mode)
(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'markdown-mode-hook 'outline-minor-mode)
(add-hook 'markdown-mode-hook 'visual-line-mode)
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-hook 'yaml-mode-hook 'visual-line-mode)


(package-initialize)
(elpy-enable)
(setenv "WORKON_HOME" "/usr/local/Caskroom/miniconda/base/envs/")

(setq org-log-done 'time)
(setq org-todo-keywords
      '((sequence "TODO" "PROGRESS" "|" "DONE")))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(epresent yaml-mode visual-fill-column markdown-mode json-mode flycheck elpy auto-complete)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq-default show-trailing-whitespace t)
(setq-default indicate-empty-lines t)

(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/backup/" t)))
(setq backup-directory-alist '(("." . "~/.emacs.d/backup/")))
(setq create-lockfiles nil)
(column-number-mode)

