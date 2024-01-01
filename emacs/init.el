(setq custom-file "~/.config/emacs/custom-file.el")
(load custom-file)
;; use-package refresher:
;; :config runs stuff after package loaded
;; :mode does before
;; :ensure makes sure packages are correctly installed
;; :hook run this when in that mode (that . this)

;; Same as putting :ensure t on all packages
(require 'use-package-ensure)
(setq use-package-always-ensure t)

;; Install use-package if not installed
(package-refresh-contents)
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

;; Define package repos, initialize
(use-package package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(use-package gruvbox-theme
  :preface
  (eval-and-compile(load "~/.config/emacs/client_scripts/theme-switcher.el"))
  :config
  (theme-switcher-init-theme)
  :custom
  (custom-safe-themes t)
)

;; https://github.com/wbolster/emacs-direnv
(use-package direnv
  :config
  (direnv-mode))

;; https://github.com/magit/magit
(use-package magit)

(use-package expand-region
  :config
  (global-set-key (kbd "C-=") 'er/expand-region))

(use-package yasnippet
  :custom
  (yas-snippet-dirs '("~/.config/emacs/snippets"))
  :config
  (yas-global-mode 1))

(use-package ein
  :custom
  (ein:output-area-inlined-images t))

(use-package org
  :preface
  (eval-and-compile(load "~/.config/emacs/client_scripts/org-setup-buffer.el"))
  :custom
  (org-agenda-files '("/home/jerome/misc/gtd/main.org"))
  (org-deadline-warning-days 0)
  (org-refile-targets
   '(("~/misc/gtd/main.org" :maxlevel . 1)
     ("~/misc/gtd/diary.org" :maxlevel . 1)
     ("~/misc/gtd/phone_in.org" :maxlevel . 1)))
   (org-agenda-custom-commands
    '(("c" "Tasks by context with Agenda"
       ((agenda ""
		((org-agenda-span '3)
		 (org-agenda-overriding-header "Agenda")))
	(tags-todo "@school"
		   ((org-agenda-overriding-header "Tasks @school")))
	(tags-todo "@anywhere"
		   ((org-agenda-overriding-header "Tasks @anywhere")))
	(tags-todo "@home"
		   ((org-agenda-overriding-header "Tasks @home")))
	(tags-todo "@couch"
		   ((org-agenda-overriding-header "Tasks @couch")))
	(tags-todo "@waiting"
		   ((org-agenda-overriding-header "Tasks @waiting"))))
       nil nil)))
  :config
  (global-set-key (kbd "C-c l") 'org-store-link)
  (global-set-key (kbd "C-c a") 'org-agenda)
  (global-set-key (kbd "C-c c") 'org-capture)
  :hook (org-mode . org-setup-buffer))

;; https://www.gnu.org/software/emms/
(use-package emms
  :defines
  emms-browser-covers
  emms-player-list
  emms-player-mpv
  emms-source-file-directory-tree-function
  emms-source-file-default-directory
  :config
  (setq emms-source-file-default-directory "~/media/music/")
  (emms-all)
  (setq emms-player-list (list emms-player-mpv)
        emms-source-file-directory-tree-function 'emms-sourpce-file-directory-tree-find
        emms-browser-covers 'emms-browser-cache-thumbnail))

;; https://www.flycheck.org/en/latest/
(use-package flycheck
  :init (global-flycheck-mode))

;; https://github.com/lassik/emacs-format-all-the-code
(use-package format-all)
(add-hook 'prog-mode-hook 'format-all-mode)
(add-hook 'format-all-mode-hook 'format-all-ensure-formatter)

;; https://github.com/abo-abo/avy
(use-package avy)
(global-set-key (kbd "C-:") 'avy-goto-char)

;; https://github.com/emacs-helm/helm/
(use-package helm
  :defines helm-locate-fuzzy-match
  :config
  (setq helm-locate-fuzzy-match t))

(global-set-key (kbd "M-x") 'helm-M-x)

;; https://github.com/vedang/pdf-tools
(use-package pdf-tools
  :defer t
  :config
  (setq-default pdf-view-display-size 'fit-page)
  (pdf-tools-install))

(eval-and-compile(load "~/.config/emacs/client_scripts/PDFView-setup-buffer.el"))
(add-hook 'pdf-view-mode-hook 'pdf-view-setup-buffer)

;; ;; https://github.com/Silex/docker.el
;; (use-package docker
;;   :config
;;   (setq docker-run-as-root t)
;;   :bind ("C-c d" . docker))

;; https://github.com/rnkn/olivetti
(use-package olivetti)

;; https://github.com/bcbcarl/emacs-wttrin
(use-package wttrin
  :config
  (setq wttrin-default-cities '("Irving" "USA")))

;; https://github.com/org-roam/org-roam
(use-package org-roam)

;; https://github.com/joostkremers/writeroom-mode
(use-package writeroom-mode)

;; https://github.com/s-kostyaev/ellama
(use-package ellama
  :init
  (setopt ellama-language "English")
  (require 'llm-ollama)
  (setopt ellama-provider
	  (make-llm-ollama
	   :chat-model "codellama" :embedding-model "codellama")))

;; docker-compose-mode
(use-package docker-compose-mode)

;; https://github.com/weirdNox/org-noter
(use-package org-noter)

;; https://depp.brause.cc/nov.el/
(use-package nov
  :config
  (add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode)))

(require 'python)
;; C-c C-c respects __init__
(define-key python-mode-map (kbd "C-c C-c")
	    (lambda () (interactive) (python-shell-send-buffer t)))

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(set-frame-font "IBM Plex Mono 12" t)

;; eshell colors
(add-hook 'eshell-mode-hook (lambda () (setenv "TERM" "xterm-256color")))

;; Start emacs daemon
(server-start)

;; Use ibuffer instead of BufferMenu
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; Eshell sudo caching, use eshell/sudo
(require 'esh-module)
(setq password-cache t) ; enable password caching
(setq password-cache-expiry 3600) ; for one hour (time in secs)

(add-to-list 'eshell-modules-list 'eshell-tramp)

(provide 'init)
;;; init.el ends here
(put 'dired-find-alternate-file 'disabled nil)

;; Hide scroll bar, menu bar, tool bar
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
