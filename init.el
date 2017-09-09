
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

;; Bootstrap 'use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
;; (setq exec-path (append exec-path '("/Users/jadestrong/.nvm/versions/node/v8.2.1/bin")))
;; (setq exec-path (append exec-path '("/usr/local/bin")))
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

(org-babel-load-file (expand-file-name "~/.emacs.d/myinit.org"))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#5f5f5f" "#ff4b4b" "#a1db00" "#fce94f" "#5fafd7" "#d18aff" "#afd7ff" "#ffffff"])
 '(custom-safe-themes
   (quote
	("a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" default)))
 '(indent-tabs-mode t)
 '(package-selected-packages
   (quote
	(smartparens better-shell exec-path-from-shell dracula-theme linum-relative solarized-theme ag dumb-jump smart-tabs-mode eslint-fix js2-mode web-mode undo-tree djvu vue-mode vue-mod elfeed-org zenburn-theme which-key use-package try org-bullets counsel color-theme auto-complete ace-window)))
 '(tab-width 4))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(aw-leading-char-face ((t (:inherit ace-jump-face-foreground :height 3.0)))))
