;;; Bible-setup-buffer.el --- Setup for reading the Bible

;;; Commentary:
;; Enable writeroom, other goodies to make reading easier.

;;; Code:
(defun Bible-setup-buffer()
  "Set up Bible buffer."
  (interactive)
  (text-scale-increase 2)
  (writeroom-mode)
  (writeroom-adjust-width -40)
  (nov-render-document))

;;; Bible-setup-buffer.el ends here
