;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "skovati"
      user-mail-address "skovati@protonmail.com")

(setq doom-theme 'doom-pine)
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 12 :weight 'medium))
(setq doom-unicode-font (font-spec :family "Noto Sans" :size 12 :weight 'medium))

(setq display-line-numbers-type 'relative)

(setq org-directory "~/dev/git/vault/")
(setq org-roam-dailies-directory "journal/");

(after! evil-escape
  (setq evil-escape-key-sequence "wq"))

(map! :leader
  (:prefix-map ("n" . "notes")
    (:prefix ("j" . "journal")
      :desc "New daily journal entry" "t" #'org-roam-dailies-capture-today
      :desc "Search daily journal entires" "s" #'org-roam-dailies-find-date)))
