;;; package --- Summary
;;; Commentary:
;;; Code:
;; If you want to use powerline, (require 'powerline) must be
;; before (require 'moe-theme).

;; Moe-theme
;; (require-package 'powerline)
(when (maybe-require-package 'powerline)
  (powerline-center-theme)
  )
;; (require-package 'moe-theme)
;; (when (maybe-require-package 'powerline)
;;   (after-load 'powerline
;;     (when (maybe-require-package 'moe-theme)
;;       (after-load 'moe-theme
;;         (setq moe-theme-highlight-buffer-id t)
;;         (setq moe-theme-resize-markdown-title '(1.5 1.4 1.3 1.2 1.0 1.0))
;;         (setq moe-theme-resize-org-title '(1.5 1.4 1.3 1.2 1.1 1.0 1.0 1.0 1.0))
;;         (setq moe-theme-resize-rst-title '(1.5 1.4 1.3 1.2 1.1 1.0))
;;         (moe-theme-set-color 'blue)
;;         (moe-dark)
;;         (powerline-moe-theme)
;;         ))
;;     ))
;; Show highlighted buffer-id as decoration. (Default: nil)

;; Resize titles (optional).


;; Choose a color for mode-line.(Default: blue)
;; blue, orange, green ,magenta, yellow, purple, red, cyan, w/b

(provide 'init-powerline)
;;; init-powerline.el ends here
