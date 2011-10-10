(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(browse-url-browser-function (quote browse-url-generic))
 '(browse-url-generic-program "google-chrome")
 '(canlock-password "92547bba86cedd258579715cc85c0f82f9ac86fc")
 '(custom-enabled-themes (quote (adwaita)))
 '(custom-safe-themes (quote ("3f4566357d3870449e6ce7ce1ab14396b8e8dea7" "8c8ac677232963d18fb03d6f460b69b00eba0aba" "fe87b8fc50359500ce1b48d7dd0959b731b78b75" "adb2f6353aeab26d970bf9ca3db14fb1e50c94a5" "6abbb4ad3c7ef31460e527da543803bfecc8b818" "61a9c54df9a7abd811529573c259b4a589f04208" default)))
 '(display-time-default-load-average nil)
 '(display-time-mode t)
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
 '(default ((t (:stipple nil :background "#EDEDED" :foreground "#000000" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 98 :width normal :foundry "unknown" :family "DejaVu Sans Mono"))))
 '(mode-line ((t (:background "white" :foreground "black" :box nil)))))

(add-to-list 'load-path "~/.emacs.d/plugins/")
;; Don't type yes or no, type y or n
(fset 'yes-or-no-p 'y-or-n-p)
(setq visible-bell t)
(prefer-coding-system 'utf-8)

(define-key global-map "\C-cc" 'comment-or-uncomment-region)

(setq sentence-end-double-space nil) ;period single space ends sentence

(global-set-key [f12] 'gnus)

(defun switch-to-minibuffer-window ()
  "switch to minibuffer window (if active)"
  (interactive)
  (when (active-minibuffer-window)
    (select-window (active-minibuffer-window))))
(global-set-key (kbd "<f8>") 'switch-to-minibuffer-window)

(require 'smooth-scrolling)
(smooth-scroll-lines-from-window-bottom)

(require 'yasnippet-bundle)

;; org mode stuff
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(setq org-agenda-files (list "~/org/work.org"
                             "~/org/home.org"
			     "~/org/school.org"))

;; nice calendar
(add-to-list 'load-path "~/.emacs.d/plugins/emacs-calfw/")
(require 'calfw-org)
(define-key global-map [f9] 'cfw:open-org-calendar)
;; Unicode characters
(setq cfw:fchar-junction ?╋
      cfw:fchar-vertical-line ?┃
      cfw:fchar-horizontal-line ?━
      cfw:fchar-left-junction ?┣
      cfw:fchar-right-junction ?┫
      cfw:fchar-top-junction ?┯
      cfw:fchar-top-left-corner ?┏
      cfw:fchar-top-right-corner ?┓)


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

;; keybindings for buffer cycling
(global-set-key [(control tab)] 'bs-cycle-previous)
(global-set-key [(C-S-iso-lefttab)] 'bs-cycle-next)

(global-set-key [(mouse-9)] 'bs-cycle-previous)
(global-set-key [(mouse-8)] 'bs-cycle-next)

;; Steve yegge
(global-set-key [f5] 'call-last-kbd-macro)
;; ;; and his Javascript mode
;; (autoload 'js2-mode "js2" nil t)
;; (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

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
(setq haskell-font-lock-symbols t)

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
