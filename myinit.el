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

(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(use-package ace-window
  :ensure t
  :init
  (progn
	(global-set-key [remap other-window] 'ace-window)
	(custom-set-faces
	 '(aw-leading-char-face
   ((t (:inherit ace-jump-face-foreground :height 3.0)))))
	))

(use-package ivy
	:ensure t
	:diminish (ivy-mode)
	:bind (
		       ("C-x b" . ivy-switch-buffer)
		       ("C-C C-r" . ivy-resume)
		       ("M-y" . ivy-next-line))
	:config
	(ivy-mode 1)
	(setq ivy-use-virtual-buffers t)
	(setq ivy-display-style 'fancy))

      (use-package swiper
	:ensure try
	:bind (("C-s" . swiper)
		       )
	:config
	(progn
	      (ivy-mode 1)
	      (setq ivy-use-virtual-buffers t)
	      (setq ivy-display-style 'fancy)
	      (define-key read-expression-map (kbd "C-r") 'counsel-expression-history)
	      ))

      (use-package counsel
	:ensure t
	:bind
	(("M-y" . counsel-yank-pop)
	 ("M-x" . counsel-M-x)
	 ("C-x C-f" . counsel-find-file)
	 ("C-c g" . counsel-git)
	 ("C-c j" . counsel-git-grep)
	 ("C-x l" . counsel-locate)
	 ("C-c k" . counsel-ag)
	 ("C-r" . counsel-expression-history))
	)
;;	 :map ivy-minibuffer-map
      (use-package projectile
	:ensure t
	:config
	;; (projectile-mode)
	(setq projectile-global-completion-system 'ivy))

      (use-package counsel-projectile
	:ensure t
	:config
	(counsel-projectile-on)
	:bind
	(("C-c p p" . counsel-projectile-switch-project)
	 ("C-c p b" . counsel-projectile-switch-to-buffer)
	 ("C-c p f" . counsel-projectile-find-file)
	 ("C-c p d" . counsel-projectile-find-dir)
	 ("C-c p s s" . counsel-projectile-ag))
	)

(use-package avy
      :ensure t
      :bind ("M-s" . avy-goto-char))

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

;; (use-package auto-complete
;;   :ensure t
;;   :init
;;   (progn
;; 	(ac-config-default)
;; 	(global-auto-complete-mode t)
;; 	))

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

(use-package vue-mode
      :ensure t
      ;; :config
      ;; (progn
      ;; 	(use-package vue-html-mode)
      ;; 	(add-to-list 'auto-mode-alist '("\\.vue\\'" . vue-mode)))
      )

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

(defalias 'list-buffers 'ibuffer)
;; (defalias 'list-buffers 'ibuffer-other-window)

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

(use-package smart-tabs-mode
      :ensure t
      :config
      (progn
	(smart-tabs-insinuate 'c 'c++ 'java 'javascript 'python)
	(add-hook 'js2-mode-hook 'smart-tabs-mode-enable)
	(smart-tabs-advice js2-indent-line js2-basic-offset))
      )

(use-package linum-relative
      :ensure t
      :init
      (progn
	(global-linum-mode t))
      :config
      (linum-relative-toggle)
)

(setq default-frame-alist '((font . "Monaco-16")))
;; (set-default-font "Monaco 16")

(use-package eslint-fix
      :config
      (add-to-list 'auto-mode-alist '("\\.js?\\'" . js2-mode))
      (add-hook 'js2-mode-hook (lambda () (add-hook 'after-save-hook 'eslint-fix nil t)))
      )

(use-package better-shell
      :ensure t
      :bind (("C-'" . better-shell-shell)
		 ("C-;" . better-shell-remote-open))
      )

(use-package smartparens
      :ensure t
      :config
      (use-package smartparens-config)
      (use-package smartparens-html)
      (smartparens-global-mode t)
      (show-smartparens-global-mode t))
