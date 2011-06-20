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

(setq-default
     gnus-summary-line-format "%U%R%z %(%&user-date;  %-15,15f %* %B%s%)\n"
     gnus-user-date-format-alist '((t . "%d.%m.%Y %H:%M"))
     gnus-summary-thread-gathering-function 'gnus-gather-threads-by-references
     gnus-thread-sort-functions '(gnus-thread-sort-by-date)
     gnus-sum-thread-tree-false-root ""
     gnus-sum-thread-tree-indent " "
     gnus-sum-thread-tree-leaf-with-other "├► "
     gnus-sum-thread-tree-root ""
     gnus-sum-thread-tree-single-leaf "╰► "
     gnus-sum-thread-tree-vertical "│"
    )

;; (setq mm-text-html-renderer 'w3m)
;; (setq mm-inline-text-html-with-images t
;;       w3m-safe-url-regexp nil)



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
