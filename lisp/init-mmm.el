;;; package --- Summary
;;; Commentary:
;;; Code:
;;----------------------------------------------------------------------------
;; Multiple major modes
;;----------------------------------------------------------------------------
(require-package 'mmm-mode)
(after-load 'mmm-mode
  (diminish 'mmm-mode))
(require 'mmm-auto)
(setq mmm-global-mode 'buffers-with-submode-classes)
(setq mmm-submode-decoration-level 2)


(provide 'init-mmm)
;;; init-mmm.el ends here
