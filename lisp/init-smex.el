;;; package --- Summary
;;; Commentary:
;;; Code:
;; Use smex to handle M-x
(when (maybe-require-package 'smex)
  ;; Change path for ~/.smex-items
  (setq-default smex-save-file (expand-file-name ".smex-items" user-emacs-directory))
  ;; (global-set-key [remap execute-extended-command] 'smex)
  (global-set-key (kbd "M-x") 'smex)
  (global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
  )

(provide 'init-smex)
;;; init-smex.el ends here
