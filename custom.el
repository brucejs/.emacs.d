(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(backup-directory-alist '((".*" . "/tmp/")))
 '(calendar-week-start-day 1)
 '(deft-auto-save-interval 0)
 '(deft-default-extension "org" t)
 '(deft-directory (concat org-directory "/GTD"))
 '(deft-new-file-format "%Y%m%dT%H%M%SZ")
 '(deft-org-mode-title-prefix t)
 '(diary-file "~/Documents/Notes/GTD/20210304T005429Z.org")
 '(fill-column 80)
 '(global-display-line-numbers-mode t)
 '(indent-tabs-mode nil)
 '(org-agenda-files '("~/Documents/Notes/GTD"))
 '(org-agenda-include-deadlines t)
 '(org-agenda-include-diary t)
 '(org-agenda-prefix-format
   '((agenda . "  %t%-12s")
     (todo . " %i %-12:c")
     (tags . "  %t%?-12s")
     (search . " %i %-12:c")))
 '(org-archive-location (concat org-directory "/GTD/20210304T010221Z.org::"))
 '(org-capture-templates
   '(("i" "Inbox" entry
      (file org-default-notes-file)
      "* %?
  :PROPERTIES:
  :Created: %(format-time-string \"%<%Y-%m-%d %a %H:%M>\")
  :END:")))
 '(org-deadline-warning-days 0)
 '(org-default-notes-file (concat org-directory "/GTD/20210304T005926Z.org"))
 '(org-directory "~/Documents/Notes")
 '(org-hide-leading-stars t)
 '(org-log-done 'time)
 '(org-refile-allow-creating-parent-nodes 'confirm)
 '(org-refile-targets '((org-agenda-files :maxlevel . 6)))
 '(org-refile-use-outline-path 'file)
 '(org-tags-column -80)
 '(tab-width 4))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
