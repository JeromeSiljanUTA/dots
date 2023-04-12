(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("19a2c0b92a6aa1580f1be2deb7b8a8e3a4857b6c6ccf522d00547878837267e7" "fa49766f2acb82e0097e7512ae4a1d6f4af4d6f4655a48170d0a00bcb7183970" "21055a064d6d673f666baaed35a69519841134829982cbbb76960575f43424db" "9ab9441566f7c3b059a205a7c5fad32a58422c2695815436d8cc087860b8c2e5" "1781e8bccbd8869472c09b744899ff4174d23e4f7517b8a6c721100288311fa5" "e7820b899036ae7e966dcaaec29fd6b87aef253748b7de09e74fdc54407a7a02" "3e374bb5eb46eb59dbd92578cae54b16de138bc2e8a31a2451bf6fdb0f3fd81b" "d80952c58cf1b06d936b1392c38230b74ae1a2a6729594770762dc0779ac66b7" "72ed8b6bffe0bfa8d097810649fd57d2b598deef47c992920aef8b5d9599eefe" default))
 '(org-agenda-files '("/home/jerome/misc/gtd/main.org"))
 '(org-export-preserve-breaks nil)
 '(package-selected-packages
   '(codespaces ayu-theme nano-theme writeroom-mode helm numpydoc sphinx-doc avy flycheck format-all company yasnippet use-package tablist reformatter python-mode magit gruvbox-theme expand-region evil emms ein direnv blacken auto-complete)))
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
  (setq org-agenda-files '("~/misc/gtd/main.org"))
  (setq org-deadline-warning-days 0))

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
(use-package sphinx-doc
  :defines sphinx-doc-include-types
  :config
  (setq sphinx-doc-include-types t)
  :init (add-hook 'python-mode-hook (lambda ()
				      (require 'sphinx-doc)
				      (sphinx-doc-mode t))))

;; https://github.com/emacs-helm/helm/
(use-package helm
  :defines helm-locate-fuzzy-match
  :config
  (setq helm-locate-fuzzy-match t))

(global-set-key (kbd "M-x") 'helm-M-x)

;; https://github.com/patrickt/codespaces.el
(use-package codespaces
  :bind ("C-c S" . #'codespaces-connect)
  :config
  (codespaces-setup)
  (setq vc-handled-backends '(Git)))



(require 'python)
;; C-c C-c respects __init__
(define-key python-mode-map (kbd "C-c C-c")
  (lambda () (interactive) (python-shell-send-buffer t)))

(provide 'init)
;;; init.el ends here
