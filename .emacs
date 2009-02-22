(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(fancy-splash-image nil)
 '(inhibit-splash-screen t)
 '(menu-bar-mode nil)
 '(python-python-command "c:\\PYTHON25\\python")
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
(require 'color-theme)
(color-theme-initialize)
(color-theme-charcoal-black)
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
      '("KILL" "*Compile-Log*" "*scratch*" "*Messages*" "*Completions*" "*tramp output*" "*tramp/scp nungu@209.40.204.161*"))

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
    (global-set-key [(control meta tab)] (lambda ()
                                           (interactive)
                                           (crs-bury-buffer -1)))



;;tramp stuff
(require 'tramp)
(setq tramp-auto-save-directory "c:\\tmp")
(setq tramp-default-method "plink")

(set-default-font "-outline-Consolas-normal-r-normal-normal-*-*-96-96-c-*-iso8859-13")
