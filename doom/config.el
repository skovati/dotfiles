;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "skovati"
      user-mail-address "skovati@protonmail.com")

(setq doom-theme 'doom-pine)
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 12 :weight 'medium))
(setq doom-unicode-font (font-spec :family "Noto Sans" :size 12 :weight 'medium))

(setq display-line-numbers-type 'relative)

(setq org-directory "~/dev/git/vault/")
(setq org-roam-dailies-directory "../journal/")

(setenv "TZ" "America/Los_Angeles")

(after! org-roam
  (setq org-roam-completion-everywhere t)
  (setq org-roam-dailies-capture-templates
    '(("d" "default" entry "* %<%I:%M %p>: %?"
       :if-new (file+head "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n")))))

(after! evil-escape
  (setq evil-escape-key-sequence "wq"))

(map! :leader
  (:prefix-map ("n" . "notes")
    (:prefix ("j" . "journal")
      :desc "New journal entry" "t" #'org-roam-dailies-capture-today
      :desc "Search journal entires" "s" #'org-roam-dailies-goto-date)))
