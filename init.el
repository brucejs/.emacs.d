(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; color theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/bundle/emacs-color-theme-solarized")
(setq frame-background-mode 'dark)
(load-theme 'solarized t)
(enable-theme 'solarized)

(defun brucejs/toggle-color-theme ()
    "Toggle Solarized Dark/Solarized Light"
    (interactive)
    (if (eq frame-background-mode 'dark)
          (setq frame-background-mode 'light)
      (setq frame-background-mode  'dark))
    (load-theme 'solarized t)
    (enable-theme 'solarized)
    (mapc 'frame-set-background-mode (frame-list)))

(global-set-key [f5] 'brucejs/toggle-color-theme)
