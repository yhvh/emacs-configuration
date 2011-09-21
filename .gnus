; -*- Lisp -*-
;; Requires gnutls / gnutls-utils
(setq message-send-mail-function 'message-send-mail-with-sendmail)
;(setq sendmail-program "msmtp")
(setq message-sendmail-extra-arguments '("-a" "yhvh"))
(setq mail-host-address "gmail.com")
(setq user-full-name "William Stevenson")
(setq user-mail-address "yhvh2000@gmail.com")
(setq mail-default-reply-to "yhvh2000@gmail.com")

(load-library "nnimap")

;; (setq imap-ssl-program "c:/cygwin/bin/openssl.exe s_client -ssl3 -quiet -connect %s:%p")
(setq gnus-select-method
             '(nnimap "gmail"
                      (nnimap-address "imap.gmail.com")
                      (nnimap-server-port 993)
                      (nnimap-authinfo-file "~/.authinfo")
                      (nnimap-stream ssl)))

(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
      smtpmail-auth-credentials '(("smtp.gmail.com" 587 "yhvh2000@gmail.com" nil))
      smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 587
      smtpmail-local-domain "mouseabuse.co.uk")

;; Virgin Media newsserver
(add-to-list 'gnus-secondary-select-methods 
	     '(nntp "Virgin" (nntp-address "news.virginmedia.com")))
;; Gmane
(add-to-list 'gnus-secondary-select-methods 
	     '(nntp "Gmane" (nntp-address "news.gmane.org")))


(setq gnus-permanently-visible-groups "INBOX")
(setq gnus-posting-styles
      '(((header "to" "yhvh2000@gmail.com")
         (address "yhvh2000@gmail.com"))
	((header "to" "will@mouseabuse.co.uk")
         (address "will@mouseabuse.co.uk"))
	))

;; Set header image
(setq message-required-news-headers
      (nconc message-required-news-headers
	     (list '(Face . (lambda ()
			      (gnus-convert-png-to-face "~/.emacs.d/face.png"))))))

(when window-system
  (setq gnus-sum-thread-tree-indent "  ")
  (setq gnus-sum-thread-tree-root "● ")
  (setq gnus-sum-thread-tree-false-root "◯ ")
  (setq gnus-sum-thread-tree-single-indent "◎ ")
  (setq gnus-sum-thread-tree-vertical        "│")
  (setq gnus-sum-thread-tree-leaf-with-other "├─► ")
  (setq gnus-sum-thread-tree-single-leaf     "╰─► "))
(setq gnus-summary-line-format
      (concat
       "%0{%U%R%z%}"
       "%3{│%}" "%1{%d%}" "%3{│%}" ;; date
       "  "
       "%4{%-20,20f%}"               ;; name
       "  "
       "%3{│%}"
       " "
       "%1{%B%}"
       "%s\n"))
(setq gnus-summary-display-arrow t)
;; (setq-default
;;      gnus-summary-line-format "%U%R%z %(%&user-date;  %-15,15f %* %B%s%)\n"
;;      gnus-user-date-format-alist '((t . "%d.%m.%Y %H:%M"))
;;      gnus-summary-thread-gathering-function 'gnus-gather-threads-by-references
;;      gnus-thread-sort-functions '(gnus-thread-sort-by-date)
;;      gnus-sum-thread-tree-false-root ""
;;      gnus-sum-thread-tree-indent " "
;;      gnus-sum-thread-tree-leaf-with-other "├► "
;;      gnus-sum-thread-tree-root ""
;;      gnus-sum-thread-tree-single-leaf "╰► "
;;      gnus-sum-thread-tree-vertical "│"
;;     )

;; (setq mm-text-html-renderer 'w3m)
;; (setq mm-inline-text-html-with-images t
;;       w3m-safe-url-regexp nil)


;; Correctly fontify Org-mode attachments
;;(add-to-list 'mailcap-mime-extensions '(".org" . "text/org"))
(add-to-list 'mm-automatic-display "text/org")

(add-to-list 'mm-inline-media-tests
             '("text/org" my-display-org-inline
               (lambda (el) t)))

(defun my-display-org-inline (handle)
  (condition-case nil
      (mm-display-inline-fontify handle 'org-mode)
    (error
     (insert (with-temp-buffer (mm-insert-part handle) (buffer-string))
             "\n"))))

;; Update org-src-lang-modes to provide some leeway for posters
;; (add-to-list 'org-src-lang-modes
;;              '("elisp" . emacs-lisp))
;; (add-to-list 'org-src-lang-modes
;;              '("emacs_lisp" . emacs-lisp))

;; Fontify code blocks in the text of messages
(defun my-mm-org-babel-src-extract ()
  (mm-make-handle (mm-uu-copy-to-buffer start-point end-point) '("text/org")))

;; (add-to-list 'mm-uu-type-alist
;;              '(org-src-block
;;                "^[ \t]*#\\+begin_"
;;                "^[ \t]*#\\+end_"
;;                my-mm-org-babel-src-extract
;;                nil))

 ;; (mm-uu-configure)

;;; bbdb
(add-to-list 'load-path "~/.emacs.d/plugins/bbdb/lisp")
(require 'bbdb)
(require 'bbdb-autoloads)
(setq
 bbdb-file "~/.bbdb"
 bbdb-offer-save 'auto
 bbdb-notice-auto-save-file t
 bbdb-expand-mail-aliases t
 bbdb-canonicalize-redundant-nets-p t
 bbdb-always-add-addresses t
 bbdb-complete-name-allow-cycling t
 )
;; Address book
;; (add-to-list 'load-path "~/.emacs.d/plugins/bbdb")
;; (require 'bbdb)
;; (bbdb-initialize 'gnus 'message)
;; (bbdb-insinuate-message)
;; (add-hook 'gnus-startup-hook 'bbdb-insinuate-gnus)
;; (setq
;;  bbdb-offer-save 1
;;  bbdb-use-pop-up nil
;;  bbdb-electric-p t
;;  bbdb-popup-target-lines 1)

(require 'gnus-autocheck)
(gnus-compile)
