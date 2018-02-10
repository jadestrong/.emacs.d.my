;;; package --- Summary
;;; Commentary:
;; This list is is automatically saved across sessions on exiting Emacs
;;; Code:
(add-hook 'after-init-hook 'recentf-mode)
(setq-default
 recentf-max-saved-items 1000
 recentf-exclude '("/tmp/" "/ssh:"))


(provide 'init-recentf)
;;; init-recentf.el ends here
