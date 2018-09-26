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
  (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.vue\\'" . web-mode))
  ;; 修改注释格式
  (setq-default web-mode-comment-formats
                '(("javascript" . "//")
                  ("css"        . "//")))
  ;; 关闭web-mode的自动匹配
  (setq web-mode-enable-auto-pairing nil)
  (defun electric-pair ()
      "If at end of line, insert character pair without surrounding spaces.
    Otherwise, just insert the typed character."
      (interactive)
      (if (eolp) (let (parens-require-spaces) (insert-pair)) (self-insert-command 1)))

  (defun my-web-mode-hook ()
    "Hooks for Web mode."
    (defvar web-mode-markup-indent-offset)
    (setq web-mode-markup-indent-offset 2)
    (setq web-mode-code-indent-offset 4)
    (setq web-mode-style-padding 0)
    (setq web-mode-script-padding 0)
    (setq web-mode-comment-style 2)
    (setq web-mode-content-types-alist
          '(("jsx" . ".*\\.js\\'"))
          )
    )
  (defun open-in-browser()
    "open buffer in browser, unless it is not a file. Then fail silently(ouch)."
    (interactive)
    (if (buffer-file-name)
        (let ((filename (buffer-file-name)))
          (browse-url (concat "file://" filename))
          ))
    )
  (after-load 'web-mode
    (add-hook 'web-mode-hook 'my-web-mode-hook)
    (add-hook 'web-mode-hook (lambda ()
                               (define-key web-mode-map "\'" 'electric-pair)
                               (define-key web-mode-map (kbd "C-c b") 'web-beautify-html)
                               (define-key web-mode-map (kbd "C-c v") 'open-in-browser)
                               )))
  )

(when (maybe-require-package 'web-beautify)
  (after-load 'web-mode
    (add-hook 'web-mode (lambda ()
                          (define-key web-mode-map (kbd "C-c b") 'web-beautify-html)
                          (define-key web-mode-map (kbd "C-c v") 'open-in-browser)
                          ))))

(provide 'init-html)
;;; init-html.el ends here
