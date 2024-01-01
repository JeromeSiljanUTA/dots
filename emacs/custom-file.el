(custom-set-variables
;; custom-set-variables was added by Custom.
;; If you edit it by hand, you could mess it up, so be careful.
;; Your init file should contain only one such instance.
;; If there is more than one, they won't work right.
'(calendar-mark-holidays-flag t)
'(custom-file "~/.config/emacs/custom-file.el")
'(custom-safe-themes
  '("046a2b81d13afddae309930ef85d458c4f5d278a69448e5a5261a5c78598e012" "ba323a013c25b355eb9a0550541573d535831c557674c8d59b9ac6aa720c21d3" "98ef36d4487bf5e816f89b1b1240d45755ec382c7029302f36ca6626faf44bbd" "19a2c0b92a6aa1580f1be2deb7b8a8e3a4857b6c6ccf522d00547878837267e7" "fa49766f2acb82e0097e7512ae4a1d6f4af4d6f4655a48170d0a00bcb7183970" "21055a064d6d673f666baaed35a69519841134829982cbbb76960575f43424db" "9ab9441566f7c3b059a205a7c5fad32a58422c2695815436d8cc087860b8c2e5" "1781e8bccbd8869472c09b744899ff4174d23e4f7517b8a6c721100288311fa5" "e7820b899036ae7e966dcaaec29fd6b87aef253748b7de09e74fdc54407a7a02" "3e374bb5eb46eb59dbd92578cae54b16de138bc2e8a31a2451bf6fdb0f3fd81b" "d80952c58cf1b06d936b1392c38230b74ae1a2a6729594770762dc0779ac66b7" "72ed8b6bffe0bfa8d097810649fd57d2b598deef47c992920aef8b5d9599eefe" default))
'(global-hl-line-mode t)
'(helm-move-to-line-cycle-in-source nil)
'(holiday-bahai-holidays nil)
'(holiday-islamic-holidays nil)
'(holiday-oriental-holidays nil)
'(olivetti-body-width 0.85)
'(org-agenda-custom-commands
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
'(org-agenda-files '("/home/jerome/misc/gtd/main.org"))
'(org-agenda-loop-over-headlines-in-active-region nil)
'(org-babel-load-languages '((shell . t) (C . t) (R . t) (python . t)))
'(org-edit-src-content-indentation 0)
'(org-export-preserve-breaks nil)
'(org-noter-always-create-frame nil)
'(package-selected-packages
  '(nov org-noter ess multiple-cursors ellama em-tramp org-roam wttrin olivetti package pandoc-mode dumb-jump arduino-mode docker-cli docker-compose-mode debian-el dockerfile-mode bluetooth pylint lua-mode pdf-tools eat jupyter codespaces ayu-theme nano-theme writeroom-mode helm numpydoc sphinx-doc avy flycheck format-all company yasnippet use-package reformatter python-mode magit expand-region evil emms ein direnv blacken auto-complete))
'(writeroom-fullscreen-effect 'maximized)
'(writeroom-maximize-window nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
