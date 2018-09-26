;;; package --- Summary
;;; Commentary:
;;; Code:
(when (maybe-require-package 'projectile)
  (add-hook 'after-init-hook 'projectile-mode)
  (setq projectile-keymap-prefix (kbd "C-c p"))
  (after-load 'projectile
    ;; (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
    ;; Shorter modeline
    (setq-default
     projectile-mode-line
     '(:eval
       (if (file-remote-p default-directory)
           " Proj"
         (format " [%s]" (projectile-project-name))))))
  (when (maybe-require-package 'counsel-projectile)
    (add-hook 'after-init-hook 'counsel-projectile-mode))
  )

(provide 'init-projectile)
;;; init-projectile.el ends here
