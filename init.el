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

;; org-mode
(require 'org-habit)

(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c l") 'org-store-link)

;; deft
(add-to-list 'load-path "~/.emacs.d/bundle/deft")
(require 'deft)
(global-set-key [f8] 'deft)

(defun brucejs/clip-buffer-name ()
    "Add the name of the current buffer to the killring."
    (interactive)
    (kill-new (buffer-name))
    (message (concat "\"" (buffer-name) "\" clipped!")))

(global-set-key [f6] 'brucejs/clip-buffer-name)

;; override deft-auto-populate-title-maybe function so that #+TITLE: and
;; #+FILETAGS: frontmatter are inserted automatically
(defun deft-auto-populate-title-maybe (file)
  "Possibly populate title line for FILE using filter string.
If the filter string is non-nil and `deft-use-filename-as-title'
is nil, then use the filter string to populate the title line in
the newly created FILE."
  (when (and deft-filter-regexp (not deft-use-filename-as-title))
    (write-region
     (concat
      (cond
       ((and (> deft-markdown-mode-title-level 0)
             (string-match "^\\(txt\\|text\\|md\\|mdown\\|markdown\\)"
                           deft-default-extension))
        (concat (make-string deft-markdown-mode-title-level ?#) " "))
       ((and deft-org-mode-title-prefix
             (string-equal deft-default-extension "org"))
        "#+TITLE: "))
      (deft-whole-filter-regexp)
      "\n#+FILETAGS: \n\n")
     nil file nil)))
