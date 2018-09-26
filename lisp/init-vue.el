;;; package --- Summary
;;; Commentary:
;;; Code:
(maybe-require-package 'vue-mode)
;; (maybe-require-package 'lsp-mode)
;; (maybe-require-package 'lsp-vue)

;; (when (maybe-require-package 'vue-mode)
;;   (add-to-list 'auto-mode-alist '("\\.vue\\'" . vue-mode))
;;   (add-hook 'vue-mode-hook (lambda ()
;;                              (define-key vue-mode-map (kbd "C-c '") 'vue-mode-edit-indirect-at-point)
;;                              (define-key vue-mode-map (kbd "C-c C-l") 'vue-mode-reparse)))
;;   )

(when (fboundp 'vue-mode)
  (add-to-list 'auto-mode-alist '("\\.vue\\'" . vue-mode))
  ;; (add-hook 'vue-mode-hook (lambda ()
  ;;                            (define-key vue-mode-map (kbd "C-'") 'vue-mode-edit-indirect-at-point)
  ;;                            (define-key vue-mode-map (kbd "C-c C-l") 'vue-mode-reparse)))
  ;; (add-hook 'vue-mode-hook #'lsp-vue-mmm-enable)
  )

;; (when (maybe-require-package 'vue-mode)
;;   (define-key vue-mode-map "\C-c'" 'vue-mode-edit-indirect-at-point)
;;   (define-key vue-mode-map "\C-c\C-l" 'vue-mode-reparse))
(after-load 'vue-mode
  (define-key vue-mode-map (kbd "C-c '") 'vue-mode-edit-indirect-at-point)
  (define-key vue-mode-map (kbd "C-c C-l") 'vue-mode-reparse))

;; (require-package 'vue-mode)
;; (require-package 'lsp-mode)
;; (require-package 'lsp-vue)
;; (require-package 'company-lsp)

;; (when (maybe-require-package 'web-mode)
;;   (add-hook 'web-mode-hook #'lsp-vue-enable))
(provide 'init-vue)
;;; init-vue.el ends here
