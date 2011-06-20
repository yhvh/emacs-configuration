(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(fancy-splash-image nil)
 '(inhibit-splash-screen t)
 '(menu-bar-mode nil)
 '(python-python-command "python")
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil)
 '(transient-mark-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(defun w32-maximize-frame ()
  "Maximize the current frame"
  (interactive)
  (w32-send-sys-command 61488))
 
(add-hook 'window-setup-hook 'w32-maximize-frame t)
 
 
(require 'smooth-scrolling)
(smooth-scroll-lines-from-window-bottom)
(setq visible-bell t)
(global-set-key [f5] 'call-last-kbd-macro)
 
;;YASnippet
(add-to-list 'load-path "~/.emacs.d/plugins")
(require 'yasnippet-bundle)
 
;;Fancy Pants TAB
          ; necessary support function for buffer burial
(defun crs-delete-these (delete-these from-this-list)
  "Delete DELETE-THESE FROM-THIS-LIST."
  (cond
   ((car delete-these)
    (if (member (car delete-these) from-this-list)
  (crs-delete-these (cdr delete-these) (delete (car delete-these)
                                                     from-this-list))
      (crs-delete-these (cdr delete-these) from-this-list)))
   (t from-this-list)))
 
          ; this is the list of buffers I never want to see
(defvar crs-hated-buffers
  '("KILL" "*Compile-Log*" "*scratch*" "*Messages*" "*Completions*" "*tramp output*" "*tramp/plink nungu@209.40.204.161*"))
 
          ; might as well use this for both
(setq iswitchb-buffer-ignore (append '("^ " "*Buffer") crs-hated-buffers))
 
(defun crs-hated-buffers ()
  "List of buffers I never want to see, converted from names to buffers."
  (delete nil
    (append
     (mapcar 'get-buffer crs-hated-buffers)
     (mapcar (lambda (this-buffer)
         (if (string-match "^ " (buffer-name this-buffer))
       this-buffer))
       (buffer-list)))))
 
          ; I'm sick of switching buffers only to find KILL right in front of me
          ; Me too asshole.
(defun crs-bury-buffer (&optional n)
  (interactive)
  (unless n
    (setq n 1))
  (let ((my-buffer-list (crs-delete-these (crs-hated-buffers)
            (buffer-list (selected-frame)))))
    (switch-to-buffer
     (if (< n 0)
   (nth (+ (length my-buffer-list) n)
        my-buffer-list)
       (bury-buffer)
       (nth n my-buffer-list)))))
 
(global-set-key [(control tab)] 'crs-bury-buffer)
(global-set-key [(control shift tab)] (lambda ()
               (interactive)
               (crs-bury-buffer -1)))
 
 (global-set-key [(mouse-4)] 'crs-bury-buffer)
(global-set-key [(mouse-5)] (lambda ()
               (interactive)
               (crs-bury-buffer -1)))
 
;;tramp stuff
(require 'tramp)
(setq tramp-auto-save-directory "c:\\tmp")
(setq tramp-default-method "plink")

(set-default-font "-outline-Consolas-normal-r-normal-normal-*-*-96-96-c-*-iso8859-13")
 
 
;;GNU Common Lisp
(set-variable 'inferior-lisp-program
        "C:/Progra~1/GCL-2.6.1/bin/gcl1.bat")
(autoload 'fi:common-lisp "fi-site-init" "" t)
 
 
;;fancy transparency
(defun djcb-opacity-modify (&optional dec)
  "modify the transparency of the emacs frame; if DEC is t,
    decrease the transparency, otherwise increase it in 10%-steps"
  (let* ((alpha-or-nil (frame-parameter nil 'alpha)) ; nil before setting
   (oldalpha (if alpha-or-nil alpha-or-nil 100))
   (newalpha (if dec (- oldalpha 10) (+ oldalpha 10))))
    (when (and (>= newalpha frame-alpha-lower-limit) (<= newalpha 100))
      (modify-frame-parameters nil (list (cons 'alpha newalpha))))))
 
;; C-8 will increase opacity (== decrease transparency)
;; C-9 will decrease opacity (== increase transparency
;; C-0 will returns the state to normal
(global-set-key (kbd "C-8") '(lambda()(interactive)(djcb-opacity-modify)))
(global-set-key (kbd "C-9") '(lambda()(interactive)(djcb-opacity-modify t)))
(global-set-key (kbd "C-0") '(lambda()(interactive)
                               (modify-frame-parameters nil `((alpha . 100)))))
 
;;spell checker windows specific
;;(setq-default ispell-program-name               ; Spell check that works for me  
 ;;             "C:\\Program Files (x86)\\Aspell\\bin\\aspell.exe")  
;;(setq text-mode-hook '(lambda()  
;;      (flyspell-mode t)       ; spellchek (sic) on the fly  
;;      ))
 
;;yegge
(global-set-key [f5] 'call-last-kbd-macro)
;;and his Javascript mode
(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
 
(setq tramp-default-user "xxxxx"
      tramp-default-host "xxx.xx.xxx.xxx")
 
(require 'color-theme)
(color-theme-initialize)
;;; Color theme based on Tango Palette. Created by danranx@gmail.com
(defun color-theme-tango ()
  "A color theme based on Tango Palette."
  (interactive)
  (color-theme-install
   '(color-theme-tango
     ((background-color . "#2e3436")
      (background-mode . dark)
      (border-color . "#888a85")
      (cursor-color . "#fce94f")
      (foreground-color . "#eeeeec")
      (mouse-color . "#8ae234"))
     ((help-highlight-face . underline)
      (ibuffer-dired-buffer-face . font-lock-function-name-face)
      (ibuffer-help-buffer-face . font-lock-comment-face)
      (ibuffer-hidden-buffer-face . font-lock-warning-face)
      (ibuffer-occur-match-face . font-lock-warning-face)
      (ibuffer-read-only-buffer-face . font-lock-type-face)
      (ibuffer-special-buffer-face . font-lock-keyword-face)
      (ibuffer-title-face . font-lock-type-face))
     (border ((t (:background "#888a85"))))
     (fringe ((t (:background "grey10"))))
     (mode-line ((t (:foreground "#eeeeec" :background "#555753"))))
     (region ((t (:background "#555753"))))
     (font-lock-builtin-face ((t (:foreground "#729fcf"))))
     (font-lock-comment-face ((t (:foreground "#888a85"))))
     (font-lock-constant-face ((t (:foreground "#8ae234"))))
     (font-lock-doc-face ((t (:foreground "#888a85"))))
     (font-lock-keyword-face ((t (:foreground "#729fcf" :bold t))))
     (font-lock-string-face ((t (:foreground "#ad7fa8" :italic t))))
     (font-lock-type-face ((t (:foreground "#8ae234" :bold t))))
     (font-lock-variable-name-face ((t (:foreground "#eeeeec"))))
     (font-lock-warning-face ((t (:bold t :foreground "#f57900"))))
     (font-lock-function-name-face ((t (:foreground "#edd400" :bold t :italic t))))
     (comint-highlight-input ((t (:italic t :bold t))))
     (comint-highlight-prompt ((t (:foreground "#8ae234"))))
     (isearch ((t (:background "#f57900" :foreground "#2e3436"))))
     (isearch-lazy-highlight-face ((t (:foreground "#2e3436" :background "#e9b96e"))))
     (show-paren-match-face ((t (:foreground "#2e3436" :background "#73d216"))))
     (show-paren-mismatch-face ((t (:background "#ad7fa8" :foreground "#2e3436"))))
     (minibuffer-prompt ((t (:foreground "#729fcf" :bold t))))
     (info-xref ((t (:foreground "#729fcf"))))
     (info-xref-visited ((t (:foreground "#ad7fa8"))))
     )))
 
(provide 'color-theme-tango)
(color-theme-tango)
 
(setq erc-hide-list '("JOIN" "PART" "QUIT"))

;;org mode stuff
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(setq org-agenda-files (list "~/org/work.org"
                             "~/org/home.org"))