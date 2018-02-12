;;; package --- Summary
;;; Commentary:
;;; Code:
(when (maybe-require-package 'vue-mode)
  (add-to-list 'auto-mode-alist '("\\.vue\\'" . vue-mode)))
;; (require-package 'vue-mode)
(provide 'init-vue)
;;; init-vue.el ends here
