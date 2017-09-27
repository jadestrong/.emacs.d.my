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
;; (setq default-frame-alist '((font . "Source Code Pro")))

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

(use-package exec-path-from-shell
      :ensure t
      :if (memq window-system '(mac ns x))
      :config
      (setq exec-path-from-shell-variables '("PATH"))
      )

(use-package json-mode
      :ensure t
      :config
      (setq js2-mode-show-parse-errors nil)
      (setq js2-mode-show-strict-warnings nil))

(use-package magit
      :ensure t
      :bind
      (("C-x g" . magit-status)))

;; (defun modi/revert-all-file-buffers ()
;;   "Refresh all open file buffers without confirmation.
;; Buffers in modified (not yet saved) state in emacs will not be reverted. They
;; will be reverted though if they were modified outside emacs.
;; Buffers visiting files which do not exist any more or are no longer readable
;; will be killed."
;;   (interactive)
;;   (dolist (buf (buffer-list))
;; 	(let ((filename (buffer-file-name buf)))
;; 	  ;; (message "buf:%s  filename:%s  modified:%s  filereadable:%s"
;; 	  ;;          buf filename
;; 	  ;;          (buffer-modified-p buf) (file-readable-p (format "%s" filename)))

;; 	  ;; Revert only buffers containing files, which are not modified;
;; 	  ;; do not try to revert non-file buffers like *Messages*.
;; 	  (when (and filename
;; 				 (not (buffer-modified-p buf)))
;; 		(if (file-readable-p filename)
;; 			;; If the file exists and is readable, revert the buffer.
;; 			(with-current-buffer buf
;; 			  (revert-buffer :ignore-auto :noconfirm :preserve-modes))
;; 		  ;; Otherwise, kill the buffer.
;; 		  (let (kill-buffer-query-functions) ; No query done when killing buffer
;; 			(kill-buffer buf)
;; 			(message "Killed non-existing/unreadable file buffer: %s" filename))))))
;;   (message "Finished reverting buffers containing unmodified files."))
;; (global-set-key (kbd "<C-f5>") 'modi/revert-all-file-buffers)

(global-auto-revert-mode 0)
(setq auto-revert-check-vc-info nil)
(auto-revert-mode 0)

(use-package highlight-indent-guides
      :ensure t
      ;; :init
      ;; (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
      :config
      (
       progn
	(setq highlight-indent-guides-method 'column))
      )

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

(use-package hideshow
      :ensure t
      :bind (("C->" . my-toggle-hideshow-all)
		 ("C-<" . hs-hide-level)
		 ("C-;" . hs-toggle-hiding))
      :config
      ;; Hide the comments too when you do a 'hs-hide-all'
      (setq hs-hide-comments nil)
      ;; Set whether isearch opens folded comments, code, or both
      ;; where x is code, comments, t (both), or nil (neither)
      (setq hs-isearch-open 'x)
      ;; Add more here

      (setq hs-set-up-overlay
		(defun my-display-code-line-counts (ov)
		      (when (eq 'code (overlay-get ov 'hs))
			(overlay-put ov 'display
						 (propertize
						      (format " ... <%d>"
								      (count-lines (overlay-start ov)
											       (overlay-end ov)))
						      'face 'font-lock-type-face)))))
      (defvar my-hs-hide nil "Current state of hideshow for toggling all.")
      ;;; autoload
      (defun my-toggle-hideshow-all () "Toggle hideshow all."
		 (interactive)
		 (setq my-hs-hide (not my-hs-hide))
		 (if my-hs-hide
			 (hs-hide-all)
		       (hs-show-all)))

      (add-hook 'prog-mode-hook (lambda ()
							      (hs-minor-mode 1)
							      ))
      (add-hook 'clojure-mode-hook (lambda ()
								 (hs-minor-mode 1)
								 ))
      )

(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; (use-package evil
;;   :ensure t
;;   :init
;;   (progn
;;     (setq evil-default-cursor t)
;;     (setq evil-toggle-key "")	; remove default evil-toggle-key C-z, manually setup later
;;     (setq evil-want-C-i-jump nil)	; don't bind [tab] to evil-jump-forward
;;     ;; leader shortcuts
;;     (use-package evil-leader
;; 	:ensure t
;; 	:init (global-evil-leader-mode)
;; 	:config
;; 	(progn
;; 	  (setq evil-leader/in-all-states t)
;; 	  ;; keyboard shortcuts
;; 	  (evil-leader/set-key
;; 	    "a" 'ag-project
;; 	    "A" 'ag
;; 	    "b" 'ido-switch-buffer
;; 	    "c" 'mc/mark-next-like-this
;; 	    "C" 'mc/mark-all-like-this
;; 	    "e" 'er/expand-region
;; 	    "E" 'mc/edit-lines
;; 	    "f" 'ido-find-file
;; 	    "g" 'magit-status
;; 	    "i" 'idomenu
;; 	    "j" 'ace-jump-mode
;; 	    "k" 'kill-buffer
;; 	    "K" 'kill-this-buffer
;; 	    "o" 'occur
;; 	    "p" 'magit-find-file-completing-read
;; 	    "r" 'recentf-ido-find-file
;; 	    "s" 'ag-project
;; 	    "t" 'bw-open-term
;; 	    "T" 'eshell
;; 	    "w" 'save-buffer
;; 	    "x" 'smex
;; 	    )
;; 	  ))
;;     ;; boot evil by default
;;     (evil-mode 1)
;;     )
;;   :config
;;   (progn
;;     (evil-leader/set-leader ",")

;;     ;; Treat underscore as part of the word when searching
;;     (setq-default evil-symbol-word-search 'symbol)

;;     ;; Remove all keybindings from insert-state keymap, use emacs-state when editing
;;     (setcdr evil-insert-state-map nil)

;;     ;; ESC to switch back normal-state
;;     (define-key evil-insert-state-map [escape] 'evil-normal-state)

;;     ;; TAB to indent in normal-state
;;     (define-key evil-normal-state-map (kbd "TAB") 'indent-for-tab-command)

;;     ;; Use j/k to move one visual line insted of gj/gk
;;     (define-key evil-normal-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
;;     (define-key evil-normal-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)
;;     (define-key evil-motion-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
;;     (define-key evil-motion-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)

;;     ;; Enter specified state for some mode
;;     (loop for (mode . state) in '((inferior-emacs-lisp-mode . emacs)
;; 				    (git-commit-mode . insert)
;; 				    (git-rebase-mode . emacs)
;; 				    (undo-tree-visualizer-mode . emacs)
;; 				    (dired-mode . emacs))
;; 	    do (evil-set-initial-state mode state))

;;     ;; Set default state into insert
;;     (setq evil-default-state 'insert)

;;     ;; Function to insert date
;;     (defun insert-date ()
;; 	"Insert current date yyyy-mm-dd."
;; 	(interactive)
;; 	(when (use-region-p)
;; 	  (delete-region (region-beginning) (region-end) )
;; 	  )
;; 	(insert (format-time-string "%Y-%m-%d"))
;; 	)
;;     )
;;   )
