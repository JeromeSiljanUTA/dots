;;; Bible-setup-buffer.el --- Setup for reading the Bible

;;; Commentary:
;; Enable writeroom, other goodies to make reading easier.

;;; Code:
(defun Bible-setup-buffer()
  "Set up Bible buffer."
  (interactive)
  (writeroom-mode)
  (text-scale-increase 2))

;;; Bible-setup-buffer.el ends here
