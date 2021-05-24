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

;; when running on Ubuntu WSL 2, open urls in MS Edge InPrivate browsing mode
(when (getenv "WSLENV")
  (setq browse-url-browser-function #'browse-url-generic
        browse-url-generic-args     '("/c" "start" "msedge" "-inprivate")
        browse-url-generic-program  "/mnt/c/Windows/System32/cmd.exe"))

;; org-mode
(require 'org-habit)

(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c l") 'org-store-link)

;; deft
(add-to-list 'load-path "~/.emacs.d/bundle/deft")
(require 'deft)
(global-set-key [f8] 'deft)

(defun brucejs/change-deft-directory ()
    "Interactively change deft-directory & refresh."
    (interactive)
    (setq deft-directory
        (concat org-directory "/"
            (completing-read "Choose directory: "
                (directory-files org-directory nil directory-files-no-dot-files-regexp))))
    (message (concat "deft-directory set to " deft-directory))
    (deft-refresh))

(global-set-key [f7] 'brucejs/change-deft-directory)

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
      "\n#+FILETAGS: \n\n* "
      (deft-whole-filter-regexp))
     nil file nil)))

;; override deft-unused-slug function from deft.el so new filenames are created
;; using utc timestamp
(defun deft-unused-slug ()
  "Return an unused filename slug (short name) in `deft-directory'."
  (let* ((slug (format-time-string deft-new-file-format nil t))
         (fmt (concat slug "_%d"))
         (counter 1)
         (file (deft-absolute-filename slug)))
    (while (or (file-exists-p file) (get-file-buffer file))
      (setq counter (1+ counter))
      (setq slug (format fmt counter))
      (setq file (deft-absolute-filename slug)))
    slug))
