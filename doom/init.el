;;; init.el -*- lexical-binding: t; -*-

(doom!
  :input

  :completion
  company
  vertico

  :ui
  doom
  doom-dashboard
  doom-quit
  (emoji +unicode +github)
  hl-todo
  indent-guides
  modeline
  ophints
  (popup +defaults)
  unicode
  (vc-gutter +pretty)
  vi-tilde-fringe
  workspaces
  zen

  :editor
  (evil +everywhere)
  file-templates
  fold
  snippets

  :emacs
  dired
  electric
  ibuffer
  undo
  vc

  :term
  vterm

  :checkers
  syntax
  (spell +flyspell)
  grammar

  :tools
  direnv
  docker
  editorconfig
  (eval +overlay)
  lookup
  (lsp +peek)
  (magit +forge)
  pdf
  terraform
  tree-sitter

  :os
  (:if IS-MAC macos)

  :lang
  emacs-lisp
  (go +lsp)
  (graphql +lsp)
  json
  (java +lsp)
  (javascript +lsp)
  latex
  lua
  markdown
  nix
  (org +roam2 +pretty +pandoc)
  python
  (rust +lsp)
  sh
  web
  yaml

  :email

  :app

  :config
  (default +bindings +smartparens))
