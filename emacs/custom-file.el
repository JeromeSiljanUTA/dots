(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(calendar-mark-holidays-flag t)
 '(custom-file "~/.config/emacs/custom-file.el")
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
