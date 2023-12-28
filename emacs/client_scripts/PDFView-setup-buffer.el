;;; PDFView-setup-buffer.el --- Setup for PDFView mode.

;;; Commentary:
;; Enable writeroom, other goodies to make writing easier.

;;; Code:
(defun pdf-view-setup-buffer()
  "Read current theme value and set theme accordingly."
  (defvar theme-val)
  (setq theme-val (with-temp-buffer
 		    (insert-file-contents "~/.config/util_ninja/state")
 		    (buffer-string)))

  (cond ((string= theme-val "dark") (pdf-view-midnight-minor-mode))))

;;; PDFView-setup-buffer.el ends here
