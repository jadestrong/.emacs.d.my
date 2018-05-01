;;; package --- Summary
;;; Commentary:
;;; Code:
(maybe-require-package 'vue-mode)
;; (maybe-require-package 'lsp-mode)
;; (maybe-require-package 'lsp-vue)

(when (fboundp 'vue-mode)
  (add-to-list 'auto-mode-alist '("\\.vue\\'" . vue-mode))
  ;; (add-hook 'vue-mode-hook #'lsp-vue-mmm-enable)
  )

;; (require-package 'vue-mode)
;; (require-package 'lsp-mode)
;; (require-package 'lsp-vue)
;; (require-package 'company-lsp)

;; (when (maybe-require-package 'web-mode)
;;   (add-hook 'web-mode-hook #'lsp-vue-enable))
(provide 'init-vue)
;;; init-vue.el ends here
