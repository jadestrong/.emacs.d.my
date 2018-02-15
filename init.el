;;; package --- Summary -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(require 'init-benchmarking) ;; Measure startup time

(defconst *spell-check-support-enabled* nil) ;; Enable with t if you prefer
(defconst *is-a-mac* (eq system-type 'darwin))

;;----------------------------------------------------------------------------
;; Adjust garbage collection thresholds during startup, and thereafter
;;----------------------------------------------------------------------------
(let ((normal-gc-cons-threshold (* 20 1024 1024))
      (init-gc-cons-threshold (* 128 1024 1024)))
  (setq gc-cons-threshold init-gc-cons-threshold)
  (add-hook 'after-init-hook
            (lambda () (setq gc-cons-threshold normal-gc-cons-threshold))))

;;----------------------------------------------------------------------------
;; Bootstrap config
;;----------------------------------------------------------------------------
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(require 'init-utils)
(require 'init-elpa)
(require 'init-exec-path)

(require-package 'wgrep)
(require-package 'diminish)
(require-package 'scratch)

(require 'init-themes)
(require 'init-powerline)
(require 'init-osx-keys)
(require 'init-gui-frames)
(require 'init-dired)
(require 'init-grep)
(require 'init-uniquify)
(require 'init-ibuffer)
(require 'init-flycheck)
(require 'init-recentf)
(require 'init-ivy)
(require 'init-projectile)
(require 'init-smex)
(require 'init-hippie-expand)

(require 'init-company)
(require 'init-windows)
(require 'init-sessions)

(require 'init-fonts)
(require 'init-mmm)

(require 'init-editing-utils)
(require 'init-whitespace)

(require 'init-vc)
(require 'init-git)

(require 'init-markdown)
(require 'init-javascript)
;; (require 'init-php)
(require 'init-org)
(require 'init-html)
(require 'init-css)
(require 'init-http)

(require 'init-sql)
;; (require 'init-paredit)
;; (require 'init-lisp)
;; (require 'init-slime)

(require 'init-misc)
(require 'init-folding)
(require 'init-dash)

(require 'init-vue)
(require 'init-highlight-indent)
(require 'init-backups)

(require-package 'gnuplot)
(require-package 'lua-mode)
(require-package 'htmlize)
(when *is-a-mac*
  (require-package 'osx-location))
(maybe-require-package 'regex-tool)
;; (maybe-require-package 'dotenv-mode)

(when (maybe-require-package 'uptimes)
  (setq-default uptimes-keep-count 200)
  (add-hook 'after-init-hook (lambda () (require 'uptimes))))

;;----------------------------------------------------------------------------
;; Allow access from emacsclient
;;----------------------------------------------------------------------------
(require 'server)
(unless (server-running-p)
  (server-start))

;; Bootstrap 'use-package'

;; (unless (package-installed-p 'use-package)
;;   (package-refresh-contents)
;;   (package-install 'use-package))
;;; powerline
;; (org-babel-load-file (expand-file-name "~/.emacs.d/powerline.org"))

;; (use-package exec-path-from-shell
;;    :if (memq window-system '(mac ns))
;;    :ensure t
;;    :config
;;    (exec-path-from-shell-initialize))

;; (org-babel-load-file (expand-file-name "~/.emacs.d/myinit.org"))

(when (file-exists-p custom-file)
  (load custom-file))

(require 'init-locales)

(provide 'init)
;;; init.el ends here
