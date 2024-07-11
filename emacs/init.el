;;; init.el --- Emacs startup.

;;; Commentary:
;;; Everything I expect to be run when I launch Emacs.

;;; Code:

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

(use-package gruvbox-theme
  :preface
  (eval-and-compile(load "~/.config/emacs/client_scripts/theme-switcher.el"))
  :config
  (theme-switcher-init-theme)
  :custom
  (custom-safe-themes t)
)

;; Define package repos, initialize
(use-package package
  :config
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/")))

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
  (org-babel-load-languages
   '(
     (C . t)
     (R . t)
     (R . t)
     (emacs-lisp . t)
     (emacs-lisp . t)
     (plantuml . t)
     (python . t)))

  ;; When selecting a region, commands apply to the whole region
  (org-agenda-loop-over-headlines-in-active-region nil)
  ;; Change agenda deadline to purple
  (org-warning ((t (:foreground "#d3869b" :underline nil :weight bold))))
  (org-format-latex-options
  '(:foreground default :background default :scale 1.5 :html-foreground "Black" :html-background "Transparent" :html-scale 1.0 :matchers
		 ("begin" "$1" "$" "$$" "\\(" "\\[")))
  (org-edit-src-content-indentation 0)
  (org-plantuml-jar-path "/usr/share/plantuml/lib/plantuml.jar")
  (org-deadline-warning-days 0)
  (org-agenda-start-on-weekday nil)
  (org-agenda-files '("/home/jerome/misc/gtd/main.org"))
    (org-refile-targets
   '(("~/misc/gtd/main.org" :maxlevel . 1)
     ("~/misc/gtd/diary.org" :maxlevel . 1)
     ("~/misc/gtd/phone_in.org" :maxlevel . 1)))
   (org-agenda-custom-commands
    '(("c" "Tasks by context with Agenda"
       ((agenda ""
		((org-agenda-span '7)
		 (org-agenda-overriding-header "Agenda")))
	(tags-todo "@school"
		   ((org-agenda-overriding-header "Tasks @school")))
	(tags-todo "@anywhere"
		   ((org-agenda-overriding-header "Tasks @anywhere")))
	(tags-todo "@home"
		   ((org-agenda-overriding-header "Tasks @home")))
	(tags-todo "@recreation"
		   ((org-agenda-overriding-header "Tasks @recreation")))
	(tags-todo "@waiting"
		   ((org-agenda-overriding-header "Tasks @waiting"))))
       nil nil)))
  :config
  (global-set-key (kbd "C-c l") 'org-store-link)
  (global-set-key (kbd "C-c a") 'org-agenda)
  (global-set-key (kbd "C-c c") 'org-capture)
  :hook (org-mode . org-setup-buffer))

(use-package flycheck
  :init (global-flycheck-mode))

(use-package format-all
  :hook
  (prog-mode . format-all-mode)
  (format-all-mode . format-all-ensure-formatter))
;;(add-hook 'prog-mode-hook 'format-all-mode)
;;(add-hook 'format-all-mode-hook 'format-all-ensure-formatter)

(use-package avy
  :config
  (global-set-key (kbd "C-:") 'avy-goto-char))

(use-package helm
  :custom
  (helm-locate-fuzzy-match t)
  (helm-move-to-line-cycle-in-source nil)
  :config
  (global-set-key (kbd "M-x") 'helm-M-x))

(use-package pdf-tools
  :preface
  (eval-and-compile(load "~/.config/emacs/client_scripts/PDFView-setup-buffer.el"))  
  :defer t
  :custom
  (pdf-view-display-size 'fit-page)
  :hook
  (pdf-view-mode . pdf-view-setup-buffer)
  :config
  (pdf-tools-install))

(use-package org-roam)

(use-package writeroom-mode
  :custom
  (writeroom-fullscreen-effect 'maximized)
  (writeroom-maximize-window nil)
  :bind
  ("C-M-<" . writeroom-decrease-width)
  ("C-M->". writeroom-increase-width)
  ("C-M-=". writeroom-adjust-width))

(use-package docker-compose-mode)

(use-package org-noter
  :custom
  (org-noter-always-create-frame nil))

(use-package nov
  :mode ("\\.epub\\'" . nov-mode))

(use-package ledger-mode
  :config
   (setq ledger-reports
    '(("bal" "%(binary) -f %(ledger-file) bal")
      ("reg" "%(binary) -f %(ledger-file) reg")
      ("payee" "%(binary) -f %(ledger-file) reg @%(payee)")
      ("account" "%(binary) -f %(ledger-file) reg %(account)"))))

(use-package hass
  :preface
  (eval-and-compile(load "~/.config/emacs/client_scripts/hass-setup-buffer.el"))
  :custom
  (hass-port 8123)
  (hass-host "192.168.2.96")
  (hass-insecure t)
  :init
  (setq hass-apikey (lambda () (auth-source-pick-first-password :host "emacs-hass" :user "jerome")))
  (setq hass-dash-layouts
	'((default .
		   ((hass-dash-group
		     :title "Home Assistant"
		     :format "%t\n\n%v"
		     (hass-dash-group
		      :title "Bedroom"
		      :title-face outline-2
		      (hass-dash-toggle
		       :entity-id "light.curve_lamp_light_2"
		       :label "Curve Lamp"
		       :icon "💡")
		      (hass-dash-toggle
		       :entity-id "light.desk_lamp_light"
		       :label "Desk Lamp"
		       :icon "💡")))))))
  :hook
  (hass-dash-mode . hass-setup-buffer))

(use-package empv
  :custom
  (empv-invidious-instance "https://vid.puffyan.us/api/v1")
  (empv-youtube-use-tabulated-results t)
  (empv-mpv-args
   '("--save-position-on-quit" "--ytdl-format=best" "--slang=en" "--speed=2" "--no-terminal" "--idle" "--input-ipc-server=/tmp/empv-socket")))

(use-package mu4e
  :preface
  (eval-and-compile(load "~/.config/emacs/client_scripts/mu4e-setup.el"))
  :ensure nil
  :load-path "/usr/share/emacs/site-lisp/mu4e/"
  :custom
  (mu4e-search-results-limit -1)
  :config
  ;; This is set to 't' to avoid mail syncing issues when using mbsync
  (setq mu4e-change-filenames-when-moving t)
  ;; Refresh mail using isync every 10 minutes
  (setq mu4e-update-interval (* 10 60))
  (setq mu4e-get-mail-command "mbsync -c ~/.config/mbsync/mbsyncrc -a")
  (setq mu4e-maildir "~/.mail")
  (mu4e-bookmarks-setup)
  (mu4e-context-setup))

(use-package ytdl
  :custom
  (ytdl-command "yt-dlp")
  (ytdl-download-folder "/home/jerome/downloads"))

(use-package god-mode
  :custom
  (god-exempt-major-modes nil)
  (god-exempt-predicates nil)
  :config
  (god-mode)
  :bind(("<escape>" . god-mode-all)))

(use-package ess)

(use-package python
  :bind
  ;; C-c C-c respects __init__
  ("C-c C-c" . (lambda () (interactive) (python-shell-send-buffer t))))

(require 'esh-module)
(setq password-cache t)
(setq password-cache-expiry 3600)
(add-to-list 'eshell-modules-list 'eshell-tramp)
(add-hook 'eshell-mode-hook (lambda () (setenv "TERM" "xterm-256color")))

;;(setq auth-sources '("~/.authinfo.gpg"))
(setq epg-pinentry-mode 'loopback)

(eval-and-compile(load "~/.config/emacs/client_scripts/Bible-setup-buffer.el"))

(add-hook 'nov-mode-hook 'Bible-setup-buffer)

(setq calendar-mark-holidays-flag t)
(setq holiday-bahai-holidays nil)
(setq holiday-islamic-holidays nil)
(setq holiday-oriental-holidays nil)

;; Hide scroll bar, menu bar, tool bar
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(set-frame-font "IBM Plex Mono 12" t)

;; Start emacs daemon
(server-start)

;; Use ibuffer instead of BufferMenu
(global-set-key (kbd "C-x C-b") 'ibuffer)

(save-place-mode 1)

(setq tab-bar-close-button-show nil)
(setq tab-bar-show 1)

(setq global-hl-line-mode t)
(global-hl-line-mode)

(setq dired-listing-switches "-alh")

(provide 'init)

;;; init.el ends here
(put 'dired-find-alternate-file 'disabled nil)
