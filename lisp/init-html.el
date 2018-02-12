;;; package --- Summary
;;; Commentary:
;;; Code:
;; (require-package 'tagedit)
;; (after-load 'sgml-mode
;;   (tagedit-add-paredit-like-keybindings)
;;   (add-hook 'sgml-mode-hook (lambda () (tagedit-mode 1))))

;; (add-auto-mode 'html-mode "\\.\\(jsp\\|tmpl\\)\\'")

;; Note: ERB is configured in init-ruby

;; emmet-mode
(when (maybe-require-package 'emmet-mode)
  (add-hook 'sgml-mode-hook 'emmet-mode)
  (add-hook 'html-mode-hook 'emmet-mode)
  (add-hook 'web-mode-hook 'emmet-mode)
  (add-hook 'css-mode-hook 'emmet-mode)
  (after-load 'emmet-mode
    (diminish 'emmet-mode))
  )

;; web-mode
(when (maybe-require-package 'web-mode)
  ;; (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
  ;; (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
  ;; (add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
  ;; (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
  ;; (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
  ;; (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
  ;; (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  (add-auto-mode 'web-mode "\\.\\(jsp\\|tmpl\\)\\'")
  (defun my-web-mode-hook ()
    "Hooks for Web mode."
    (defvar web-mode-markup-indent-offset)
    (setq web-mode-markup-indent-offset 2))
  (after-load 'web-mode
    (add-hook 'web-mode-hook 'my-web-mode-hook))
  )

(provide 'init-html)
;;; init-html.el ends here
