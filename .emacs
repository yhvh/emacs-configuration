(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(browse-url-browser-function (quote browse-url-generic))
 '(browse-url-generic-program "google-chrome")
 '(canlock-password "92547bba86cedd258579715cc85c0f82f9ac86fc")
 '(display-time-default-load-average nil)
 '(erc-hide-list (quote ("JOIN" "KICK" "NICK" "PART" "QUIT" "MODE")))
 '(fancy-splash-image "~/Documents/triangle.png")
 '(global-subword-mode t)
 '(image-animate-loop t)
 '(inhibit-startup-screen t)
 '(initial-scratch-message nil)
 '(menu-bar-mode nil)
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(add-to-list 'load-path "~/.emacs.d/plugins/")
;; Don't type yes or no, type y or n
(fset 'yes-or-no-p 'y-or-n-p)
(setq visible-bell t)
(prefer-coding-system 'utf-8)

(define-key global-map "\C-cc" 'comment-or-uncomment-region)

(require 'smooth-scrolling)
(smooth-scroll-lines-from-window-bottom)

(require 'yasnippet-bundle)

;; org mode stuff
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(setq org-agenda-files (list "~/org/work.org"
                             "~/org/home.org"))

(defun toggle-fullscreen (&optional f)
  (interactive)
  (let ((current-value (frame-parameter nil 'fullscreen)))
    (set-frame-parameter nil 'fullscreen
			 (if (equal 'fullboth current-value)
			     (if (boundp 'old-fullscreen) old-fullscreen nil)
			   (progn (setq old-fullscreen current-value)
				  'fullboth)))))
(global-set-key [f11] 'toggle-fullscreen)
;;(run-with-idle-timer 0.1 nil 'toggle-fullscreen)

;; Fancy Pants C-TAB and forward/back mouse buttons.
;; necessary support function for buffer burial
(defun crs-delete-these (delete-these from-this-list)
  "Delete DELETE-THESE FROM-THIS-LIST."
  (cond
   ((car delete-these)
    (if (member (car delete-these) from-this-list)
	(crs-delete-these (cdr delete-these) (delete (car delete-these)
                                                     from-this-list))
      (crs-delete-these (cdr delete-these) from-this-list)))
   (t from-this-list)))

;; this is the list of buffers I never want to see
(defvar crs-hated-buffers
  '("KILL" "*Compile-Log*" "*scratch*" "*Messages*" "*Completions*" "*tramp output*" "*tramp/plink nungu@209.40.204.161*"))

;; might as well use this for both
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

;; I'm sick of switching buffers only to find KILL right in front of me
;; Me too asshole.
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
(global-set-key [(C-S-iso-lefttab)] (lambda ()
					(interactive)
					(crs-bury-buffer -1)))

(global-set-key [(mouse-9)] 'crs-bury-buffer)
(global-set-key [(mouse-8)] (lambda ()
			      (interactive)
			      (crs-bury-buffer -1)))

;; Steve yegge
(global-set-key [f5] 'call-last-kbd-macro)
;; ;; and his Javascript mode
(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;; Color theme 
(add-to-list 'load-path "~/.emacs.d/plugins/color-theme")
(require 'color-theme)
(load "~/.emacs.d/plugins/color-theme-gnome-3-adwaita/color-theme-gnome-3-adwaita.el")
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (color-theme-gnome-3-adwaita)
     ))
(require 'linum)
(setq linum-format
      (lambda (line) 
	(propertize (format
		     (let ((w (length (number-to-string
				       (count-lines (point-min) (point-max))))))
		       (concat "%" (number-to-string w) "d ")) line) 'face 'linum)))
(global-linum-mode)
(require 'linum-off)

(add-to-list 'load-path "~/.emacs.d/plugins/magit")
(require 'magit)
(global-set-key (kbd "C-x C-g")     'magit-status)

;; Haskell mode
(load "~/.emacs.d/plugins/haskell-mode/haskell-site-file")
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(add-hook 'haskell-mode-hook 'font-lock-mode)
;; find a good monospace unicode font first
;;(setq haskell-font-lock-symbols t)

(add-to-list 'load-path "~/.emacs.d/plugins/rainbow")
(require 'rainbow-mode)
;; Load rainbow-mode when css files are opened
(add-hook 'css-mode-hook 'rainbow-mode)

;; Display in modeline time
(setq display-time-day-and-date t
      display-time-24hr-format t)
(display-time)

;; google-maps
(add-to-list 'load-path "~/.emacs.d/plugins/google-maps")
(require 'google-maps)

;; glsl mode
(autoload 'glsl-mode "glsl-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.vert\\'" . glsl-mode))
(add-to-list 'auto-mode-alist '("\\.frag\\'" . glsl-mode))


;; transparency works on linux for me now but use this less now
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
