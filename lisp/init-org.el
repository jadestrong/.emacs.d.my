;;; package --- Summary
;;; Commentary:
;;; Code:
(when *is-a-mac*
  (maybe-require-package 'grab-mac-link))

(maybe-require-package 'org-cliplink)

(define-key global-map (kbd "C-c l") 'org-store-link)
(define-key global-map (kbd "C-c a") 'org-agenda)

(when (maybe-require-package 'org-bullets)
  (add-hook 'org-mode-hook (lambda() (org-bullets-mode 1))))

;; (setq org-emphasis-regexp-components
;;       '("   ('\"{\x200B" "-     .,:!?;'\")}\\[\x200B" "
;; ,\"'" "." 1))
;; (defun insert-zero-width-space ()
;;   (interactive)
;;   (insert-char #x200b))

;; (defun my-filter-remove-u200b (text backend info)
;;   "Remove zero width space character (U+200B) from TEXT."
;;   (replace-regexp-in-string "\x200B" "" text))

;; (after-load 'org-mode
;;   (define-key org-mode-map (kbd "C-*") 'insert-zero-width-space)
;;   (add-to-list 'org-export-filter-plain-text-functions
;;                'my-filter-remove-u200b))

;; 必须在 (require 'org) 之前
;; (setq org-emphasis-regexp-components
;;       ;; markup 记号前后允许中文
;;       (list (concat " \t('\"{"            "[:nonascii:]")
;;             (concat "- \t.,:!?;'\")}\\["  "[:nonascii:]")
;;             " \t\r\n,\"'"
;;             "."
;;             1))

(setq org-log-done t
      org-edit-timestamp-down-means-later t
      org-archive-mark-done nil
      org-hide-emphasis-markers t
      org-catch-invisible-edits 'show
      org-export-coding-system 'utf-8
      org-fast-tag-selection-single-key 'expert
      org-html-validation-link nil
      org-export-kill-product-buffer-when-displayed t
      org-tags-column 80)

;; Lots of stuff from http://doc.norang.ca/org-mode.html

;; TODO: fail gracefully
(defun sanityinc/grab-ditaa (url jar-name)
  "Download URL and extract JAR-NAME as `org-ditaa-jar-path'."
  ;; TODO: handle errors
  (message "Grabbing " jar-name " for org.")
  (let ((zip-temp (make-temp-name "emacs-ditaa")))
    (unwind-protect
        (progn
          (when (executable-find "unzip")
            (url-copy-file url zip-temp)
            (shell-command (concat "unzip -p " (shell-quote-argument zip-temp)
                                   " " (shell-quote-argument jar-name) " > "
                                   (shell-quote-argument org-ditaa-jar-path)))))
      (when (file-exists-p zip-temp)
        (delete-file zip-temp)))))

(after-load 'ob-ditaa
  (unless (and (boundp 'org-ditaa-jar-path)
               (file-exists-p org-ditaa-jar-path))
    (let ((jar-name "ditaa0_9.jar")
          (url "http://jaist.dl.sourceforge.net/project/ditaa/ditaa/0.9/ditaa0_9.zip"))
      (setq org-ditaa-jar-path (expand-file-name jar-name (file-name-directory user-init-file)))
      (unless (file-exists-p org-ditaa-jar-path)
        (sanityinc/grab-ditaa url jar-name)))))

(after-load 'ob-plantuml
  (let ((jar-name "plantuml.jar")
        (url "http://jaist.dl.sourceforge.net/project/plantuml/plantuml.jar"))
    (setq org-plantuml-jar-path (expand-file-name jar-name (file-name-directory user-init-file)))
    (unless (file-exists-p org-plantuml-jar-path)
      (url-copy-file url org-plantuml-jar-path))))



(maybe-require-package 'writeroom-mode)

(define-minor-mode prose-mode
  "Set up a buffer for prose editing.
This enables or modifies a number of settings so that the
experience of editing prose is a little more like that of a
typical word processor."
  nil " Prose" nil
  (if prose-mode
      (progn
        (when (fboundp 'writeroom-mode)
          (writeroom-mode 1))
        (setq truncate-lines nil)
        (setq word-wrap t)
        (setq cursor-type 'bar)
        (when (eq major-mode 'org)
          (kill-local-variable 'buffer-face-mode-face))
        (buffer-face-mode 1)
        ;;(delete-selection-mode 1)
        (set (make-local-variable 'blink-cursor-interval) 0.6)
        (set (make-local-variable 'show-trailing-whitespace) nil)
        (set (make-local-variable 'line-spacing) 0.2)
        (ignore-errors (flyspell-mode 1))
        (visual-line-mode 1))
    (kill-local-variable 'truncate-lines)
    (kill-local-variable 'word-wrap)
    (kill-local-variable 'cursor-type)
    (kill-local-variable 'show-trailing-whitespace)
    (kill-local-variable 'line-spacing)
    (buffer-face-mode -1)
    ;; (delete-selection-mode -1)
    (flyspell-mode -1)
    (visual-line-mode -1)
    (when (fboundp 'writeroom-mode)
      (writeroom-mode 0))))

;;(add-hook 'org-mode-hook 'buffer-face-mode)
(add-hook 'org-mode-hook 'toggle-truncate-lines)

(setq org-support-shift-select t)


;;; Task and org-capture management
;; (maybe-require-package 'find-lisp)
(require 'find-lisp)
(setq org-directory "~/.org/gtd/");
(defun org-file-path (filename)
  "Return the absolute address of an org file, given its relative name."
  (concat (file-name-as-directory org-directory) filename))

;; (setq org-inbox-file "~/Dropbox/inbox.org")
;; (setq org-index-file (org-file-path "index.org"))
;; (setq org-review-file (org-file-path "review.org"))
(setq org-archive-location
      (concat (org-file-path "archive.org") "::* From %s"))

;; (defun hrs/copy-tasks-from-inbox ()
;;   (when (file-exists-p org-inbox-file)
;;     (save-excursion
;;       (find-file org-index-file)
;;       (goto-char (point-max))
;;       (insert-file-contents org-inbox-file)
;;       (delete-file org-inbox-file)
;;       )))
(setq org-agenda-files
      (find-lisp-find-files org-directory "\.org$"))
;; (setq org-agenda-files (list org-index-file org-review-file))

(defun hrs/mark-done-and-archive ()
  "Mark the state of an org-mode item as DONE and archive it."
  (interactive)
  (org-todo 'done)
  (org-atchive-subtree))
(after-load 'org
  (define-key org-mode-map (kbd "C-c C-x C-s") 'hrs/mark-done-and-archive))


(;; defun hrs/open-index-file ()
 ;;  "Open the master org TODO list."
 ;;  (interactive)
 ;;  (hrs/copy-tasks-from-inbox)
 ;;  (find-file org-index-file)
 ;;  (flycheck-mode -1)
 ;;  (end-of-buffer)
  )

;; (global-set-key (kbd "C-c i") 'hrs/open-index-file)

;; (defun hrs/open-blog-file ()
;;   "Open the master org TODO list."
;;   (interactive)
;;   (hrs/copy-tasks-from-inbox)
;;   (find-file (org-file-path "blog-ideas.org"))
;;   (flycheck-mode -1)
;;   (end-of-buffer))

;; (global-set-key (kbd "C-c b") 'hrs/open-blog-file)

(defun org-capture-todo ()
  (interactive)
  (org-capture :keys "t"))

(global-set-key (kbd "M-n") 'org-capture-todo)
(add-hook 'gfm-mode-hook
          (lambda () (local-set-key (kbd "M-n") 'org-capture-todo)))

;;; Capturing

(global-set-key (kbd "C-c c") 'org-capture)

;; (setq org-capture-templates
;;       `(("t" "todo" entry (file "")  ; "" => `org-default-notes-file'
;;          "* NEXT %?\n%U\n" :clock-resume t)
;;         ("n" "note" entry (file "")
;;          "* %? :NOTE:\n%U\n%a\n" :clock-resume t)
;;         ))
;; (setq org-capture-templates
;;       '(("b" "Blog idea"
;;          entry
;;          (file (org-file-path "blog-ideas.org"))
;;          "* %?\n")

;;         ("e" "Email" entry
;;          (file+headline org-index-file "Inbox")
;;          "* TODO %?\n\n%a\n\n")

;;         ("f" "Finished book"
;;          table-line (file "~/documents/notes/books-read.org")
;;          "| %^{Title} | %^{Author} | %u |")

;;         ("r" "Reading"
;;          checkitem
;;          (file (org-file-path "to-read.org")))

        ;; ("s" "Subscribe to an RSS feed"
        ;;  plain
        ;;  (file "~/documents/rss/urls")
        ;;  "%^{Feed URL} \"~%^{Feed name}\"")
        ;; ("w" "Weekly Review" entry (file+olp+datetree "~/.org/gtd/reviews.org")
        ;;  (file "~/.org/gtd/templates/weekly_review.org"))

        ;; ("t" "Todo"
        ;;  entry
        ;;  (file+headline org-index-file "Inbox")
        ;;  "* TODO %?\n" :clock-resume t)))

(setq org-capture-templates
      `(("i" "inbox" entry (file "~/.org/gtd/inbox.org")
         "* TODO %?")
        ("p" "paper" entry (file "~/.org/papers/papers.org")
         "* TODO %(jethro/trim-citation-title \"%:title\")\n%a" :immediate-finish t)
        ("e" "email" entry (file+headline "~/.org/gtd/projects.org" "Emails")
         "* TODO [#A] Reply: %a :@home:@school:" :immediate-finish t)
        ("w" "Weekly Review" entry (file+olp+datetree "~/.org/gtd/reviews.org")
         (file "~/.org/gtd/templates/weekly_review.org"))
        ("s" "Snippet" entry (file "~/.org/deft/capture.org")
         "* Snippet %<%Y-%m-%d %H:%M>\n%?")))

;;; Refiling

(setq org-refile-use-cache nil)

;; Targets include this file and any file contributing to the agenda - up to 5 levels deep
;; (setq org-refile-targets '((nil :maxlevel . 5) (org-agenda-files :maxlevel . 5)))
(setq org-refile-targets '(("next.org" :level . 0)
                           ("someday.org" :level . 0)
                           ("projects.org" :maxlevel . 1)))

(defvar jethro/org-agenda-bulk-process-key ?f
  "Default key for bulk processing inbox items.")

(defun jethro/org-process-inbox ()
  "Called in org-agenda-mode, processes all inbox items."
  (interactive)
  (org-agenda-bulk-mark-regexp "inbox:")
  (jethro/bulk-process-entries))

(defun jethro/org-agenda-process-inbox-item ()
  "Process a single item in the org-agenda."
  (org-with-wide-buffer
   (org-agenda-set-tags)
   (org-agenda-priority)
   (org-agenda-set-effort)
   (org-agenda-refile nil nil t)))

(defun jethro/bulk-process-entries ()
  (if (not (null org-agenda-bulk-marked-entries))
      (let ((entries (reverse org-agenda-bulk-marked-entries))
            (processed 0)
            (skipped 0))
        (dolist (e entries)
          (let ((pos (text-property-any (point-min) (point-max) 'org-hd-marker e)))
            (if (not pos)
                (progn (message "Skipping removed entry at %s" e)
                       (cl-incf skipped))
              (goto-char pos)
              (let (org-loop-over-headlines-in-active-region) (funcall 'jethro/org-agenda-process-inbox-item))
              ;; `post-command-hook' is not run yet.  We make sure any
              ;; pending log note is processed.
              (when (or (memq 'org-add-log-note (default-value 'post-command-hook))
                        (memq 'org-add-log-note post-command-hook))
                (org-add-log-note))
              (cl-incf processed))))
        (org-agenda-redo)
        (unless org-agenda-persistent-marks (org-agenda-bulk-unmark-all))
        (message "Acted on %d entries%s%s"
                 processed
                 (if (= skipped 0)
                     ""
                   (format ", skipped %d (disappeared before their turn)"
                           skipped))
                 (if (not org-agenda-persistent-marks) "" " (kept marked)")))
    ))

(defun jethro/org-inbox-capture ()
  "Capture a task in agenda mode."
  (org-capture nil "i"))

(setq org-agenda-bulk-custom-functions '((jethro/org-agenda-bulk-process-key jethro/org-agenda-process-inbox-item)))

;; (define-key org-agenda-mode-map "i" 'org-agenda-clock-in)
;; (define-key org-agenda-mode-map "r" 'jethro/org-process-inbox)
;; (define-key org-agenda-mode-map "R" 'org-agenda-refile)
;; (define-key org-agenda-mode-map "c" 'jethro/org-inbox-capture)
(after-load 'org-agenda
  (define-key org-agenda-mode-map (kbd "i") 'org-agenda-clock-in)
  (define-key org-agenda-mode-map (kbd "r") 'jethro/org-process-inbox)
  (define-key org-agenda-mode-map (kbd "R") 'org-agenda-refile)
  (define-key org-agenda-mode-map (kbd "c") 'jethro/org-inbox-capture))

(defvar jethro/new-project-template
  "
    *Project Purpose/Principles*:

    *Project Outcome*:
    "
  "Project template, inserted when a new project is created")

(defvar jethro/is-new-project nil
  "Boolean indicating whether it's during the creation of a new project")

(defun jethro/refile-new-child-advice (orig-fun parent-target child)
  (let ((res (funcall orig-fun parent-target child)))
    (save-excursion
      (find-file (nth 1 parent-target))
      (goto-char (org-find-exact-headline-in-buffer child))
      (org-add-note)
      )
    res))

(advice-add 'org-refile-new-child :around #'jethro/refile-new-child-advice)

(defun jethro/set-todo-state-next ()
  "Visit each parent task and change NEXT states to TODO"
  (org-todo "NEXT"))

(add-hook 'org-clock-in-hook 'jethro/set-todo-state-next 'append)

(after-load 'org-agenda
  (add-to-list 'org-agenda-after-show-hook 'org-show-entry))

(defadvice org-refile (after sanityinc/save-all-after-refile activate)
  "Save all org buffers after each refile operation."
  (org-save-all-org-buffers))

;; Exclude DONE state tasks from refile targets
(defun sanityinc/verify-refile-target ()
  "Exclude todo keywords with a done state from refile targets."
  (not (member (nth 2 (org-heading-components)) org-done-keywords)))
(setq org-refile-target-verify-function 'sanityinc/verify-refile-target)

(defun sanityinc/org-refile-anywhere (&optional goto default-buffer rfloc msg)
  "A version of `org-refile' which allows refiling to any subtree."
  (interactive "P")
  (let ((org-refile-target-verify-function))
    (org-refile goto default-buffer rfloc msg)))

(defun sanityinc/org-agenda-refile-anywhere (&optional goto rfloc no-update)
  "A version of `org-agenda-refile' which allows refiling to any subtree."
  (interactive "P")
  (let ((org-refile-target-verify-function))
    (org-agenda-refile goto rfloc no-update)))

;; Targets start with the file name - allows creating level 1 tasks
;;(setq org-refile-use-outline-path (quote file))
(setq org-refile-use-outline-path t)
(setq org-outline-path-complete-in-steps nil)

;; Allow refile to create parent tasks with confirmation
(setq org-refile-allow-creating-parent-nodes 'confirm)


;;; To-do settings

(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!/!)")
              (sequence "PROJECT(p)" "|" "DONE(d!/!)" "CANCELLED(c@/!)")
              (sequence "WAITING(w@/!)" "DELEGATED(e!)" "HOLD(h)" "|" "CANCELLED(c@/!)")))
      org-todo-repeat-to-state "NEXT")

(setq org-todo-keyword-faces
      (quote (("NEXT" :inherit warning)
              ("PROJECT" :inherit font-lock-string-face))))

(setq org-tag-alist (quote (("@errand" . ?e)
                            ("@office" . ?o)
                            ("@home" . ?h)
                            (:newline)
                            ("WAITING" . ?w)
                            ("HOLD" . ?H)
                            ("CANCELLED" . ?c))))

(setq org-fast-tag-selection-single-key nil)



;;; Agenda views

;; (setq-default org-agenda-clockreport-parameter-plist '(:link t :maxlevel 3))


;; (let ((active-project-match "-INBOX/PROJECT"))

;;   (setq org-stuck-projects
;;         `(,active-project-match ("NEXT")))

;;   (setq org-agenda-compact-blocks t
;;         org-agenda-sticky t
;;         org-agenda-start-on-weekday nil
;;         ;; org-agenda-span 'week
;;         org-agenda-include-diary nil
;;         org-agenda-sorting-strategy
;;         '((agenda habit-down time-up user-defined-up effort-up category-keep)
;;           (todo category-up effort-up)
;;           (tags category-up effort-up)
;;           (search category-up))
;;         org-agenda-window-setup 'other-window
;;         org-agenda-custom-commands
;;         `(("N" "Notes" tags "NOTE"
;;            ((org-agenda-overriding-header "Notes")
;;             (org-tags-match-list-sublevels t)))
;;           ("g" "GTD"
;;            ((agenda "" nil)
;;             (tags "INBOX"
;;                   ((org-agenda-overriding-header "Inbox")
;;                    (org-tags-match-list-sublevels nil)))
;;             (stuck ""
;;                    ((org-agenda-overriding-header "Stuck Projects")
;;                     (org-agenda-tags-todo-honor-ignore-options t)
;;                     (org-tags-match-list-sublevels t)
;;                     (org-agenda-todo-ignore-scheduled 'future)))
;;             (tags-todo "-INBOX"
;;                        ((org-agenda-overriding-header "Next Actions")
;;                         (org-agenda-tags-todo-honor-ignore-options t)
;;                         (org-agenda-todo-ignore-scheduled 'future)
;;                         (org-agenda-skip-function
;;                          '(lambda ()
;;                             (or (org-agenda-skip-subtree-if 'todo '("HOLD" "WAITING"))
;;                                 (org-agenda-skip-entry-if 'nottodo '("NEXT")))))
;;                         (org-tags-match-list-sublevels t)
;;                         (org-agenda-sorting-strategy
;;                          '(todo-state-down effort-up category-keep))))
;;             (tags-todo ,active-project-match
;;                        ((org-agenda-overriding-header "Projects")
;;                         (org-tags-match-list-sublevels t)
;;                         (org-agenda-sorting-strategy
;;                          '(category-keep))))
;;             (tags-todo "-INBOX/-NEXT"
;;                        ((org-agenda-overriding-header "Orphaned Tasks")
;;                         (org-agenda-tags-todo-honor-ignore-options t)
;;                         (org-agenda-todo-ignore-scheduled 'future)
;;                         (org-agenda-skip-function
;;                          '(lambda ()
;;                             (or (org-agenda-skip-subtree-if 'todo '("PROJECT" "HOLD" "WAITING" "DELEGATED"))
;;                                 (org-agenda-skip-subtree-if 'nottododo '("TODO")))))
;;                         (org-tags-match-list-sublevels t)
;;                         (org-agenda-sorting-strategy
;;                          '(category-keep))))
;;             (tags-todo "/WAITING"
;;                        ((org-agenda-overriding-header "Waiting")
;;                         (org-agenda-tags-todo-honor-ignore-options t)
;;                         (org-agenda-todo-ignore-scheduled 'future)
;;                         (org-agenda-sorting-strategy
;;                          '(category-keep))))
;;             (tags-todo "/DELEGATED"
;;                        ((org-agenda-overriding-header "Delegated")
;;                         (org-agenda-tags-todo-honor-ignore-options t)
;;                         (org-agenda-todo-ignore-scheduled 'future)
;;                         (org-agenda-sorting-strategy
;;                          '(category-keep))))
;;             (tags-todo "-INBOX"
;;                        ((org-agenda-overriding-header "On Hold")
;;                         (org-agenda-skip-function
;;                          '(lambda ()
;;                             (or (org-agenda-skip-subtree-if 'todo '("WAITING"))
;;                                 (org-agenda-skip-entry-if 'nottodo '("HOLD")))))
;;                         (org-tags-match-list-sublevels nil)
;;                         (org-agenda-sorting-strategy
;;                          '(category-keep))))
;;             ;; (tags-todo "-NEXT"
;;             ;;            ((org-agenda-overriding-header "All other TODOs")
;;             ;;             (org-match-list-sublevels t)))
;;             )))))

(setq jethro/org-agenda-inbox-view
      `("i" "Inbox" todo ""
        ((org-agenda-files '("~/.org/gtd/inbox.org")))))

(setq jethro/org-agenda-someday-view
      `("s" "Someday" todo ""
        ((org-agenda-files '("~/.org/gtd/someday.org")))))

(setq org-agenda-block-separator nil)
(setq org-agenda-start-with-log-mode t)
(setq jethro/org-agenda-todo-view
      `(" " "Agenda"
        ((agenda ""
                 ((org-agenda-span 'day)
                  (org-deadline-warning-days 365)))
         (todo "TODO"
               ((org-agenda-overriding-header "To Refile")
                (org-agenda-files '("~/.org/gtd/inbox.org"))))
         (todo "NEXT"
               ((org-agenda-overriding-header "In Progress")
                (org-agenda-files '("~/.org/gtd/someday.org"
                                    "~/.org/gtd/projects.org"
                                    "~/.org/gtd/next.org"))
                ;; (org-agenda-skip-function '(org-agenda-skip-entry-if 'deadline 'scheduled))
                ))
         (todo "TODO"
               ((org-agenda-overriding-header "Todo")
                (org-agenda-files '("~/.org/gtd/projects.org"
                                    "~/.org/gtd/next.org"))
                (org-agenda-skip-function '(org-agenda-skip-entry-if 'deadline 'scheduled))))
         nil)))

(defun jethro/org-agenda-skip-all-siblings-but-first ()
  "Skip all but the first non-done entry."
  (let (should-skip-entry)
    (unless (or (org-current-is-todo)
                (not (org-get-scheduled-time (point))))
      (setq should-skip-entry t))
    (save-excursion
      (while (and (not should-skip-entry) (org-goto-sibling t))
        (when (org-current-is-todo)
          (setq should-skip-entry t))))
    (when should-skip-entry
      (or (outline-next-heading)
          (goto-char (point-max))))))

(defun org-current-is-todo ()
  (string= "TODO" (org-get-todo-state)))

(defun jethro/switch-to-agenda ()
  (interactive)
  (org-agenda nil " ")
  (delete-other-windows))

;; (bind-key "<f1>" 'jethro/switch-to-agenda)
(global-set-key (kbd "C-c i") 'jethro/switch-to-agenda)

(setq org-columns-default-format "%40ITEM(Task) %Effort(EE){:} %CLOCKSUM(Time Spent) %SCHEDULED(Scheduled) %DEADLINE(Deadline)")

(setq jethro/org-agenda-papers-view
      `("p" "Papers"
        ((todo "NEXT"
               ((org-agenda-overriding-header "In Progress")
                (org-agenda-files '("~/.org/papers/papers.org"))))
         (todo "TODO"
               ((org-agenda-overriding-header "To Read")
                (org-agenda-files '("~/.org/papers/papers.org"))))
         (todo "DONE"
               ((org-agenda-overriding-header "To Read")
                (org-agenda-files '("~/.org/papers/papers.org"))))
         nil)))

(setq org-agenda-custom-commands
      `(,jethro/org-agenda-inbox-view
        ,jethro/org-agenda-someday-view
        ,jethro/org-agenda-todo-view
        ,jethro/org-agenda-papers-view))


(when (maybe-require-package 'deft)
  (setq deft-default-extension "org")
  (setq deft-direcory "~/.org/deft")
  (setq deft-use-filename-as-title t)

  (global-set-key (kbd "C-c n") 'deft))

(add-hook 'org-agenda-mode-hook 'hl-line-mode)


;;; Org clock

;; Save the running clock and all clock history when exiting Emacs, load it on startup
(after-load 'org
  (org-clock-persistence-insinuate))
(setq org-clock-persist t)
(setq org-clock-in-resume t)

;; Save clock data and notes in the LOGBOOK drawer
(setq org-clock-into-drawer t)
;; Save state changes in the LOGBOOK drawer
(setq org-log-into-drawer t)
;; Removes clocked tasks with 0:00 duration
(setq org-clock-out-remove-zero-time-clocks t)

;; Show clock sums as hours and minutes, not "n days" etc.
(setq org-time-clocksum-format
      '(:hours "%d" :require-hours t :minutes ":%02d" :require-minutes t))


;;; Show the clocked-in task - if any - in the header line
(defun sanityinc/show-org-clock-in-header-line ()
  (setq-default header-line-format '((" " org-mode-line-string " "))))

(defun sanityinc/hide-org-clock-from-header-line ()
  (setq-default header-line-format nil))

(add-hook 'org-clock-in-hook 'sanityinc/show-org-clock-in-header-line)
(add-hook 'org-clock-out-hook 'sanityinc/hide-org-clock-from-header-line)
(add-hook 'org-clock-cancel-hook 'sanityinc/hide-org-clock-from-header-line)

(after-load 'org-clock
  (define-key org-clock-mode-line-map [header-line mouse-2] 'org-clock-goto)
  (define-key org-clock-mode-line-map [header-line mouse-1] 'org-clock-menu))


(when (and *is-a-mac* (file-directory-p "/Applications/org-clock-statusbar.app"))
  (add-hook 'org-clock-in-hook
            (lambda () (call-process "/usr/bin/osascript" nil 0 nil "-e"
                                (concat "tell application \"org-clock-statusbar\" to clock in \"" org-clock-current-task "\""))))
  (add-hook 'org-clock-out-hook
            (lambda () (call-process "/usr/bin/osascript" nil 0 nil "-e"
                                     "tell application \"org-clock-statusbar\" to clock out"))))


;; TODO: warn about inconsistent items, e.g. TODO inside non-PROJECT
;; TODO: nested projects!



;;; Archiving

(setq org-archive-mark-done nil)
(setq org-archive-location "%s_archive::* Archive")





(require-package 'org-pomodoro)
(setq org-pomodoro-keep-killed-pomodoro-time t)
(after-load 'org-agenda
  (define-key org-agenda-mode-map (kbd "P") 'org-pomodoro))

(after-load 'org
  (define-key org-mode-map (kbd "C-M-<up>") 'org-up-element)
  (when *is-a-mac*
    (define-key org-mode-map (kbd "M-h") nil)
    (define-key org-mode-map (kbd "C-c g") 'org-mac-grab-link)))

(after-load 'org
  (org-babel-do-load-languages
   'org-babel-load-languages
   `((ditaa . t)
     (dot . t)
     (emacs-lisp . t)
     (gnuplot . t)
     (latex . t)
     (ledger . t)
     (ocaml . nil)
     (octave . t)
     (plantuml . t)
     (python . t)
     (screen . nil)
     (,(if (locate-library "ob-sh") 'sh 'shell) . t)
     (sql . nil)
     (sqlite . t))))

;; Github Flavored Markdown exporter for Org Mode
(eval-after-load "org"
  '(require 'ox-gfm nil t))

(provide 'init-org)
;;; init-org.el ends here
