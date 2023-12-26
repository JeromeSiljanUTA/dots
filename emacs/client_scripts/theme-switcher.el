;;; theme-switcher.el --- Emacs theme switching functions.

;;; Commentary:
;; Functions to switch the theme to light and dark.
;; Read current theme value from file.

;;; Code:
(defun theme-switcher-light()
  "Switch to light theme."
  (interactive)
  (disable-theme 'gruvbox-dark-medium)
  (disable-theme 'gruvbox-light-medium)
  (load-theme 'gruvbox-light-medium))

(defun theme-switcher-dark()
  "Switch to dark theme."
  (interactive)
  (disable-theme 'gruvbox-light-medium)
  (disable-theme 'gruvbox-dark-medium)
  (load-theme 'gruvbox-dark-medium))

(defun theme-switcher-init-theme()
  "Read current theme value and set theme accordingly."
  (defvar theme-val)
  (setq theme-val (with-temp-buffer
		    (insert-file-contents "~/.config/util_ninja/state")
		    (buffer-string)))

  (cond ((string= theme-val "light") (theme-switcher-light))
	((string= theme-val "dark") (theme-switcher-dark))))

;;; theme-switcher.el ends here
