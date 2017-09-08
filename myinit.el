(setq inhibit-startup-message t)
(tool-bar-mode -1)
(fset 'yes-or-no-p 'y-or-n-p)
(global-set-key (kbd "<f5>") 'revert-buffer)

(use-package try
  :ensure t)

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

;; Org-mode
(use-package org-bullets
      :ensure t
      :config
      (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

;; (setq indo-enable-flex-matching t)	
;; (setq ido-everywhere t)
;; (ido-mode 1)

(defalias 'list-buffers 'ibuffer)
;; (defalias 'list-buffers 'ibuffer-other-window)

;; If you like a tabbar
; (use-package tabbar
;   :ensure t
;   :config
;   (tabbar-mode 1))


(use-package ace-window
      :ensure t
      :init
      (progn
	(global-set-key [remap other-window] 'ace-window)
	(custom-set-faces
	 '(aw-leading-char-face
       ((t (:inherit ace-jump-face-foreground :height 3.0)))))
	))

(use-package counsel
      :ensure t
      :bind
      (("M-y" . counsel-yank-pop)
       :map ivy-minibuffer-map
       ("M-y" . ivy-next-line))
      )

(use-package ivy
      :ensure t
      :diminish (ivy-mode)
      :bind (("C-x b" . ivy-switch-buffer))
      :config
      (ivy-mode 1)
      (setq ivy-use-virtual-buffers t)
      (setq ivy-display-style 'fancy))

(use-package swiper
      :ensure try
      :bind (("C-s" . swiper)
	 ("C-r" . swiper)
	 ("C-c C-r" . ivy-resume)
	 ("M-x" . counsel-M-x)
	 ("C-x C-f" . counsel-find-file))
      :config
      (progn
	(ivy-mode 1)
	(setq ivy-use-virtual-buffers t)
	(setq ivy-display-style 'fancy)
	(define-key read-expression-map (kbd "C-r") 'counsel-expression-history)
	))

(use-package avy
      :ensure t
      :bind ("M-s" . avy-goto-char))

(use-package auto-complete
      :ensure t
      :init
      (progn
	(ac-config-default)
	(global-auto-complete-mode t)
	))

(use-package color-theme
      :ensure t)

;; (use-package zenburn-theme
;; :ensure t							   
;; :config (load-theme 'zenburn t))

(use-package base16-theme
      :ensure t
      )

(use-package moe-theme
      :ensure t)

(use-package eziam-theme
      :ensure t)

(use-package alect-themes
      :ensure t)

;; (load-theme 'base16-flat t)
;; (moe-light) 
(use-package powerline
      :ensure t
      :config
      (powerline-moe-theme)
      )
;; (use-package solarized-theme
;;   :ensure t)
(use-package dracula-theme
      :ensure t
      :config (load-theme 'dracula t))


(use-package vue-mode
      :ensure t
      :config
      (progn
      (use-package vue-html-mode)
      (add-to-list 'auto-mode-alist '("\\.vue\\'" . vue-mode)))
      )
(use-package undo-tree
      :ensure t
      :init
      (global-undo-tree-mode))

(use-package web-mode
      :ensure t
      :config
      (progn
      (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
      (setq web-mode-ac-sources-alist
	'(("css" . (ac-source-css-property))
	      ("html" . (ac-source-words-in-buffer ac-source-abbrev))))
      (setq web-mode-enable-auto-closing t)
      (setq web-mode-enable-auto-quoting t))
      )

;; (use-package js2-mode
;;   :ensure t
;;   :init
;;   (setq exec-path (append exec-path '("/Users/jadestrong/.nvm/versions/node/v8.2.1/bin")))
;;   :config
;;   (progn
;;   (add-to-list 'auto-mode-alist '("\\.js?\\'" . js2-mode)))
;;   )

(use-package js2-mode
      :ensure t
      :ensure ac-js2
      :init
      (progn
	(add-hook 'js-mode-hook 'js2-minor-mode)
	(add-hook 'js2-mode-hook 'ac-js2-mode)
	))

(use-package js2-refactor
      :ensure t
      :config 
      (progn
	(js2r-add-keybindings-with-prefix "C-c C-m")
	;; eg. extract function with `C-c C-m ef`.
	(add-hook 'js2-mode-hook #'js2-refactor-mode)))

(use-package tern
      :ensure tern
      :ensure tern-auto-complete
      :config
      (progn
	(add-hook 'js-mode-hook (lambda () (tern-mode t)))
	(add-hook 'js2-mode-hook (lambda () (tern-mode t)))
	(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
	(tern-ac-setup)
	))

(use-package nodejs-repl
      :ensure t
      )

(add-hook 'js-mode-hook
		      (lambda ()
			(define-key js-mode-map (kbd "C-x C-e") 'nodejs-repl-send-last-sexp)
			(define-key js-mode-map (kbd "C-c C-r") 'nodejs-repl-send-region)
			(define-key js-mode-map (kbd "C-c C-l") 'nodejs-repl-load-file)
			(define-key js-mode-map (kbd "C-c C-z") 'nodejs-repl-switch-to-repl)))

(use-package smart-tabs-mode
      :ensure t
      :config
      (progn
	(smart-tabs-insinuate 'c 'c++ 'java 'javascript 'python)
	(add-hook 'js2-mode-hook 'smart-tabs-mode-enable)
	(smart-tabs-advice js2-indent-line js2-basic-offset))
      )
(use-package projectile
      :ensure t
      :config
      (projectile-mode)
      (setq projectile-global-completion-system 'ivy))

(use-package ag
      :ensure t)

(use-package counsel-projectile
      :ensure t
      :config
      (counsel-projectile-on))

(use-package dumb-jump
      :bind (("M-g o" . dumb-jump-go-other-window)
		 ("M-g j" . dumb-jump-go)
		 ("M-g x" . dumb-jump-go-prefer-external)
		 ("M-g z" . dumb-jump-go-prefer-external-other-window))
      :config (setq dump-jumb-selector 'ivy) ;; (setq dumb-jump-selector 'helm)
      :init
      (dumb-jump-mode)
      :ensure
      )

(use-package linum-relative
      :ensure t
      :init
      (progn
	(global-linum-mode t))
      :config
      (linum-relative-toggle)
)

(set-default-font "Monaco 16")

(use-package eslint-fix
      :config
      (add-to-list 'auto-mode-alist '("\\.js?\\'" . js2-mode))
      (add-hook 'js2-mode-hook (lambda () (add-hook 'after-save-hook 'eslint-fix nil t)))
      )
