(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(calendar-mark-holidays-flag t)
 '(custom-safe-themes
   '("046a2b81d13afddae309930ef85d458c4f5d278a69448e5a5261a5c78598e012" "ba323a013c25b355eb9a0550541573d535831c557674c8d59b9ac6aa720c21d3" "98ef36d4487bf5e816f89b1b1240d45755ec382c7029302f36ca6626faf44bbd" "19a2c0b92a6aa1580f1be2deb7b8a8e3a4857b6c6ccf522d00547878837267e7" "fa49766f2acb82e0097e7512ae4a1d6f4af4d6f4655a48170d0a00bcb7183970" "21055a064d6d673f666baaed35a69519841134829982cbbb76960575f43424db" "9ab9441566f7c3b059a205a7c5fad32a58422c2695815436d8cc087860b8c2e5" "1781e8bccbd8869472c09b744899ff4174d23e4f7517b8a6c721100288311fa5" "e7820b899036ae7e966dcaaec29fd6b87aef253748b7de09e74fdc54407a7a02" "3e374bb5eb46eb59dbd92578cae54b16de138bc2e8a31a2451bf6fdb0f3fd81b" "d80952c58cf1b06d936b1392c38230b74ae1a2a6729594770762dc0779ac66b7" "72ed8b6bffe0bfa8d097810649fd57d2b598deef47c992920aef8b5d9599eefe" default))
 '(holiday-bahai-holidays nil)
 '(holiday-islamic-holidays nil)
 '(holiday-oriental-holidays nil)
 '(org-export-preserve-breaks nil)
 '(package-selected-packages
   '(dumb-jump arduino-mode docker-cli docker docker-compose-mode docker-tramp debian-el dockerfile-mode bluetooth pylint lua-mode pdf-tools eat jupyter codespaces ayu-theme nano-theme writeroom-mode helm numpydoc sphinx-doc avy flycheck format-all company yasnippet use-package tablist reformatter python-mode magit gruvbox-theme expand-region evil emms ein direnv blacken auto-complete)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; use-package refresher:
;; :config runs stuff after package loaded
;; :mode does before
;; :ensure makes sure packages are correctly installed
;; :hook run this when in that mode (that . this)

;; First change the theme so I'm not blinded on startup
;; https://github.com/greduan/emacs-theme-gruvbox

(use-package gruvbox-theme
  :config (load-theme 'gruvbox-light-medium))

;; Hide scroll bar, menu bar, tool bar
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)

;; Install use-package if not installed
(package-refresh-contents)
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

;; Same as putting :ensure t on all packages
(eval-and-compile
  (setq use-package-always-ensure t))

;; Define package repos, initialize
(use-package package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

;; https://github.com/wbolster/emacs-direnv
(use-package direnv
  :config
  (direnv-mode))

;; https://github.com/magnars/expand-region.el
(use-package expand-region
  :config
  (global-set-key (kbd "C-=") 'er/expand-region))

;; https://github.com/joaotavora/yasnippet
(use-package yasnippet
  :defines
  yas-snippet-dirs
  :config
  (yas-global-mode 1)
  (setq yas-snippet-dirs '("~/.config/emacs/snippets")))


;; https://github.com/millejoh/emacs-ipython-notebook
(use-package ein
  :defines
  ein:output-area-inlined-images
  :config
  (setq ein:output-area-inlined-images t))

(global-set-key "\C-cd" 'kill-whole-line)

;; https://orgmode.org/
(use-package org
  :defines
  org-agenda-files
  org-deadline-warning-days
  :config
  (setq org-agenda-files
	'("~/learning/school/QUANTITATIVE COMPUTER ARCHITECTURE CSE4323/cse4323.org"
	  "~/learning/school/EMBEDDED SYSTEMS II CSE4342/cse4342.org"
	  "~/learning/school/SENIOR DESIGN II CSE4317/cse4317.org"
	  "~/misc/gtd/main.org"))

  (setq org-deadline-warning-days 0))
(setq org-refile-targets
      '(("~/misc/gtd/main.org" :maxlevel . 1)
        ("~/misc/gtd/phone_in.org" :maxlevel . 1)))

(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)

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
  :ensure t
  :init (global-flycheck-mode))

;; https://github.com/lassik/emacs-format-all-the-code
(use-package format-all
  :ensure t)
(add-hook 'prog-mode-hook 'format-all-mode)
(add-hook 'format-all-mode-hook 'format-all-ensure-formatter)

;; https://github.com/abo-abo/avy
(use-package avy
  :ensure t)
(global-set-key (kbd "C-:") 'avy-goto-char)

;; https://github.com/naiquevin/sphinx-doc.el
;;(use-package sphinx-doc
;;  :defines sphinx-doc-include-types
;;  :config
;;  (setq sphinx-doc-include-types t)
;;  :init (add-hook 'python-mode-hook (lambda ()
;;				      (require 'sphinx-doc)
;;				      (sphinx-doc-mode t))))

;; https://github.com/emacs-helm/helm/
(use-package helm
  :defines helm-locate-fuzzy-match
  :config
  (setq helm-locate-fuzzy-match t))

(global-set-key (kbd "M-x") 'helm-M-x)


;; Commented because I don't think I'll ever use this again
;;;; https://github.com/patrickt/codespaces.el
;;(use-package codespaces
;;  :bind ("C-c S" . #'codespaces-connect)
;;  :config
;;  (codespaces-setup)
;;  (setq vc-handled-backends '(Git)))

;; https://github.com/vedang/pdf-tools
(use-package pdf-tools
  :defer t
  :config
  (pdf-tools-install)
  (setq-default pdf-view-display-size 'fit-page))

;; https://github.com/Silex/docker.el
(use-package docker
  :ensure t
  :config
  (setq docker-run-as-root t)
  :bind ("C-c d" . docker))

;; https://github.com/emacs-pe/docker-tramp.el
;;(use-package docker-tramp
;;  :ensure t)


(require 'python)
;; C-c C-c respects __init__
(define-key python-mode-map (kbd "C-c C-c")
  (lambda () (interactive) (python-shell-send-buffer t)))

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(set-frame-font "IBM Plex Mono Medium 12" nil t)

;; active Babel languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '((shell . t)))

(provide 'init)
;;; init.el ends here
(put 'dired-find-alternate-file 'disabled nil)
