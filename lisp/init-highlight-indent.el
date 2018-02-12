;;; package --- Summary
;;; Commentary:
;;; Code:
(when (maybe-require-package 'highlight-indent-guides)
  (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
  (after-load 'highlight-indent-guides
    (setq highlight-indent-guides-method 'column))
  )

(when (maybe-require-package 'rainbow-delimiters)
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))
(provide 'init-highlight-indent)
;;; init-highlight-indent ends here
