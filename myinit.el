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
  :diminish (counsel-mode)
  :config
  (progn
    (setq counsel-grep-base-command "rg -i -M 120 --no-heading --line-number --color never '%s' %s"))
  :bind
  (("M-y" . counsel-yank-pop)
   ;; ("M-x" . counsel-M-x)
   ("C-x C-f" . counsel-find-file)
   ("C-c g" . counsel-git)
   ("C-c j" . counsel-git-grep)
   ("C-x l" . counsel-locate)
   ("C-c k" . counsel-ag)
   ("C-r" . counsel-expression-history))
  )

(use-package projectile
  :ensure t
  :delight '(:eval (concat " [" (projectile-project-name) "]"))
  :config
  (progn
    ;; (setq projectile-global-completion-system 'ivy)
    (setq projectile-completion-system 'ivy)
    (setq projectile-indexing-method 'alien)
    (setq projectile-enable-caching t)
    (add-to-list 'projectile-globally-ignored-directories "node_modules")
    (add-to-list 'projectile-globally-ignored-files "node_modules"))
  )

(use-package counsel-projectile
  :ensure t
  :bind
  (("C-c p p" . counsel-projectile-switch-project)
   ("C-c p b" . counsel-projectile-switch-to-buffer)
   ("C-c p f" . counsel-projectile-find-file)
   ("C-c p d" . counsel-projectile-find-dir)
   ("C-c p s s" . counsel-projectile-ag))
  :config
  (counsel-projectile-mode)
  )

(use-package avy
      :ensure t
      :bind ("M-s" . avy-goto-char))

;; (use-package color-theme
;;   :ensure t)

;; (use-package zenburn-theme
;; :ensure t
;; :config (load-theme 'zenburn t))

(use-package base16-theme
  :ensure t
  )

(use-package moe-theme
  :ensure t)

;; (use-package eziam-theme
;;   :ensure t)

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
(use-package arjen-grey-theme
  :ensure t
  :config (load-theme 'arjen-grey t))

;; (use-package auto-complete
;;   :ensure t
;;   :init
;;   (progn
;; 	(ac-config-default)
;; 	(global-auto-complete-mode t)
;; 	))

(use-package undo-tree
  :ensure t
  :diminish (undo-tree-mode)
  :init
  (global-undo-tree-mode))

(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 4)
  )
(use-package web-mode
  :ensure t
  :init
  (add-hook 'web-mode-hook #'my-web-mode-hook)
  :config
  (progn
    (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
    (setq web-mode-ac-sources-alist
          '(("css" . (ac-source-css-property))
            ("html" . (ac-source-words-in-buffer ac-source-abbrev))))
    (setq web-modep-enable-auto-closing t)
    (setq web-mode-enable-auto-quoting t))
  )
(use-package vue-html-mode
  :ensure t
  :custom
  (vue-html-tab-width 4 "modify vue-html-mode tab width as 4")
  (vue-html-extra-indent 4 "The number of columns added to every line's indention is 4"))

(use-package vue-mode
  :ensure t
  :bind (("C-c C-k" . vue-mode-edit-indirect-at-point))
  :custom-face
  (vue-dedicated-modes (vue-html-mode html-mode))
  :config
  (vue-html-mode)
  )

;; (use-package js2-mode
;;   :ensure t
;;   :init
;;   (progn
;;     (add-hook 'js-mode-hook 'js2-minor-mode)
;;     )
;;   :config
;;   (bind-key "C-c C-c" 'compile js2-mode-map)
;;   (add-hook 'js2-mode-hook 'jasminejs-mode)
;;   )

;; (use-package jasminejs-mode
;;   :disabled
;;   :diminish (jasminejs-mode)
;;   :config
;;   (add-hook 'jasminejs-mode-hook 'jasminejs-add-snippets-to-yas-snippet-dirs)
;;   )

;; (defvar my/javascript-test-regexp (concat (regexp-quote "/** Testing **/") "\\(.*\n\\)*")
;;   "Regular expression matching testing-related code to remove.
;; See `my/copy-javascript-region-or-buffer'.")

;; (defun my/copy-javascript-region-or-buffer (beg end)
;;   "Copy the active region or the buffer, wrapping it in script tags.
;; Add a comment with the current filename and skip test-related
;; code. See `my/javascript-test-regexp' to change the way
;; test-related code is detected."
;;   (interactive "r")
;;   (unless (region-active-p)
;;     (setq beg (point-min) end (point-max)))
;;   (kill-new
;;    (concat
;;     "<script type=\"text/javascript\">\n"
;;     (if (buffer-file-name) (concat "// " (file-name-nondirectory (buffer-file-name)) "\n") "")
;;     (replace-regexp-in-string
;;      my/javascript-test-regexp
;;      ""
;;      (buffer-substring (point-min) (point-max))
;;      nil)
;;     "\n</script>")))

;; (defvar my/debug-counter 1)
;; (defun my/insert-or-flush-debug (&optional reset beg end)
;;   (interactive "pr")
;;   (cond
;;    ((= reset 4)
;;     (save-excursion
;;       (flush-lines "console.log('DEBUG: [0-9]+" (point-min) (point-max))
;;       (setq my/debug-counter 1)))
;;    ((region-active-p)
;;     (save-excursion
;;       (goto-char end)
;;       (insert ");\n")
;;       (goto-char beg)
;;       (insert (format "console.log('DEBUG: %d', " my/debug-counter))
;;       (setq my/debug-counter (1+ my/debug-counter))
;;       (js2-indent-line)))
;;    (t
;;     ;; Wrap the region in the debug
;;     (insert (format "console.log('DEBUG: %d');\n" my/debug-counter))
;;     (setq my/debug-counter (1+ my/debug-counter))
;;     (backward-char 3)
;;     (js2-indent-line))))

;; (use-package js2-mode
;;   :commands js2-mode
;;   :init
;;   (progn
;;     (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
;;     ;; (setq-default js2-basic-offset 2)
;;     (add-to-list 'interpreter-mode-alist (cons "node" 'js2-mode)))
;;   :config
;;   (progn
;;     (js2-imenu-extras-setup)
;;     (bind-key "C-x C-e" 'js-send-last-sexp js2-mode-map)
;;     (bind-key "C-M-x" 'js-send-last-sexp-and-go js2-mode-map)
;;     (bind-key "C-c b" 'js-send-buffer js2-mode-map)
;;     (bind-key "C-c d" 'my/insert-or-flush-debug js2-mode-map)
;;     (bind-key "C-c C-b" 'js-send-buffer-and-go js2-mode-map)
;;     (bind-key "C-c w" 'my/copy-javascript-region-or-buffer js2-mode-map))
;;   )

;; (use-package js2-refactor
;;   :ensure t
;;   :diminish (js2-refactor-mode)
;;   :config
;;   (progn
;;     (js2r-add-keybindings-with-prefix "C-c C-m")
;;     ;; eg. extract function with `C-c C-m ef`.
;;     (add-hook 'js2-mode-hook #'js2-refactor-mode)))

;; (use-package tern
;;   :ensure tern
;;   :diminish tern-mode
;;   :ensure tern-auto-complete
;;   :config
;;   (progn
;;     (add-hook 'js-mode-hook (lambda () (tern-mode t)))
;;     (add-hook 'js2-mode-hook (lambda () (tern-mode t)))
;;     (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
;;     (tern-ac-setup)
;;     ))

;; (use-package nodejs-repl
;;   :ensure t
;;   )

;; (add-hook 'js-mode-hook
;;           (lambda ()
;;             (define-key js-mode-map (kbd "C-x C-e") 'nodejs-repl-send-last-sexp)
;;             (define-key js-mode-map (kbd "C-c C-r") 'nodejs-repl-send-region)
;;             (define-key js-mode-map (kbd "C-c C-l") 'nodejs-repl-load-file)
;;             (define-key js-mode-map (kbd "C-c C-z") 'nodejs-repl-switch-to-repl)))

(defalias 'list-buffers 'ibuffer)
(defalias 'list-buffers 'ibuffer-other-window)

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

;; (use-package linum-relative
;;   :ensure t
;;   :init
;;   (progn
;;     (global-linum-mode t))
;;   :config
;;   (linum-relative-toggle)
;; )

(setq default-frame-alist '((font . "Monaco-16")))

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

;; (use-package smartparens
;;   :ensure t
;;   :diminish (smartparens-mode)
;;   :config
;;   (use-package smartparens-config)
;;   (use-package smartparens-html)
;;   (smartparens-global-mode t)
;;   (show-smartparens-global-mode t))

(use-package json-mode
      :ensure t
      :config
      (setq js2-mode-show-parse-errors nil)
      (setq js2-mode-show-strict-warnings nil))

(use-package magit
  :ensure t
  :config
  (setq default-process-coding-system '(utf-8 . utf-8))
  :bind
  (("C-x g" . magit-status)))

;; (global-auto-revert-mode 0)
;; (setq auto-revert-check-vc-info nil)
;; (auto-revert-mode 0)

(use-package highlight-indent-guides
  :ensure t
  :init
  (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
  :config
  (
   progn
    (setq highlight-indent-guides-method 'column))
  )

(use-package rainbow-delimiters
  :ensure t
  :init
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(defun bjm/kill-this-buffer ()
      "Kill the current buffer."
      (interactive)
      (kill-buffer (current-buffer))
      )
(global-set-key (kbd "C-x k") 'bjm/kill-this-buffer)

(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil)))
(setq mouse-wheel-progressive-speed nil)

(setq mac-option-modifier 'none)
(setq mac-command-modifier 'meta)
(setq ns-function-modifier 'hyper)

(setq ns-pop-up-frames nil)

(defun iwb ()
  "indent whole buffer"
  (interactive)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max))
  )

(global-set-key (kbd "C-c n") 'iwb)

(electric-pair-mode t)

;; (use-package hideshow
;;   :ensure t
;;   :bind (("C->" . my-toggle-hideshow-all)
;; 		 ("C-<" . hs-hide-level)
;; 		 ("C-;" . hs-toggle-hiding))
;;   :config
;;   ;; Hide the comments too when you do a 'hs-hide-all'
;;   (setq hs-hide-comments nil)
;;   ;; Set whether isearch opens folded comments, code, or both
;;   ;; where x is code, comments, t (both), or nil (neither)
;;   (setq hs-isearch-open 'x)
;;   ;; Add more here

;;   (setq hs-set-up-overlay
;; 		(defun my-display-code-line-counts (ov)
;; 		  (when (eq 'code (overlay-get ov 'hs))
;; 			(overlay-put ov 'display
;; 						 (propertize
;; 						  (format " ... <%d>"
;; 								  (count-lines (overlay-start ov)
;; 											   (overlay-end ov)))
;; 						  'face 'font-lock-type-face)))))
;;   (defvar my-hs-hide nil "Current state of hideshow for toggling all.")
;;   ;;; autoload
;;   (defun my-toggle-hideshow-all () "Toggle hideshow all."
;; 		 (interactive)
;; 		 (setq my-hs-hide (not my-hs-hide))
;; 		 (if my-hs-hide
;; 			 (hs-hide-all)
;; 		   (hs-show-all)))

;;   (add-hook 'prog-mode-hook (lambda ()
;; 							  (hs-minor-mode 1)
;; 							  ))
;;   (add-hook 'clojure-mode-hook (lambda ()
;; 								 (hs-minor-mode 1)
;; 								 ))
;;   )

(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; (use-package mysql-to-org
;;   :ensure t)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80))
(setq indent-line-function 'insert-tab)

(use-package rg
  :ensure t)

(use-package lua-mode
  :ensure t)

;; (use-package flycheck
;;   :ensure t
;;   :init
;;   (add-hook 'after-init-hook #'global-flycheck-mode)
;;   :config
;;   (setq flycheck-display-errors-function #'flycheck-display-error-messages-unless-error-list)
;;   )

;; (use-package flycheck-color-mode-line
;;   :ensure t
;;   :hook flycheck-mode-hook)

(use-package yasnippet
      :ensure t
      :diminish (yas-minor-mode))
