;;; package --- Summary
;;; Commentary:
;;; Code:
(when (maybe-require-package 'projectile)
  (add-hook 'after-init-hook 'projectile-mode)

  ;; The following code means you get a menu if you hit "C-c p" and wait
  (after-load 'guide-key
    (add-to-list 'guide-key/guide-key-sequence "C-c p"))

  ;; Shorter modeline
  (after-load 'projectile
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
