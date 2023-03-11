(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("3e374bb5eb46eb59dbd92578cae54b16de138bc2e8a31a2451bf6fdb0f3fd81b" "d80952c58cf1b06d936b1392c38230b74ae1a2a6729594770762dc0779ac66b7" "72ed8b6bffe0bfa8d097810649fd57d2b598deef47c992920aef8b5d9599eefe" default))
 '(org-export-preserve-breaks nil)
 '(package-selected-packages
   '(sphinx-doc avy flycheck format-all pdf-tools company yasnippet use-package tablist reformatter python-mode magit gruvbox-theme expand-region evil emms ein direnv blacken auto-complete)))
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
  :config (load-theme 'gruvbox-dark-hard))

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
  (setq org-agenda-files '("~/misc/gtd/main.org"
                           "~/misc/gtd/in.org"))
  (setq org-deadline-warning-days 0))

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

;; https://www.flycheck.org/en/
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
  :ensure t
  :defines sphinx-doc-include-types
  :config
  (setq sphinx-doc-include-types t)
  :init (add-hook 'python-mode-hook (lambda ()
				      (require 'sphinx-doc)
				      (sphinx-doc-mode t))))

(require 'python)
;; C-c C-c respects __init__
(define-key python-mode-map (kbd "C-c C-c")
  (lambda () (interactive) (python-shell-send-buffer t)))

(provide 'init)
;;; init.el ends here
