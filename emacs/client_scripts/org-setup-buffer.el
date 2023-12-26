;;; org-setup-buffer.el --- Setup for org mode.

;;; Commentary:
;; Enable writeroom, other goodies to make writing easier.

;;; Code:
(defun org-setup-buffer()
  "Set up org buffer."
  (writeroom-mode)
  (flyspell-mode))

;;; org-setup-buffer.el ends here
