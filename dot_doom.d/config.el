;;; config.el ---                                    -*- lexical-binding: t; -*-

(setq doom-font (font-spec :family "monospace" :size 14))
(setq doom-theme 'doom-gruvbox)
(setq org-directory "~/Sync/orgfiles")
(setq display-line-numbers-type t)
(package-initialize)
(setq user-full-name "David")
(setq org-directory "~/org/")

(fset 'yes-or-no-p 'y-or-n-p)
;; set default tab char's display width to 4 spaces
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq-default js-indent-level 2)
(setq-default auto-save-default t)
(setq-default delete-selection-mode 1)
(setq-default display-time-mode 1)
(show-paren-mode 1)
(setq ring-bell-function 'ignore)
(setq ns-right-alternate-modifier nil)
(set-frame-font "Iosevka" nil t)

;; Org-mode stuff
(after! org-bullets
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

;; Ruby
(add-to-list 'auto-mode-alist
             '("\\.\\(?:cap\\|gemspec\\|irbrc\\|gemrc\\|rake\\|rb\\|ru\\|thor\\)\\'" . ruby-mode))
(add-to-list 'auto-mode-alist
             '("\\(?:Brewfile\\|Capfile\\|Gemfile\\(?:\\.[a-zA-Z0-9._-]+\\)?\\|[rR]akefile\\)\\'" . ruby-mode))

(add-hook 'ruby-mode-hook 'lsp)

;; React
(add-hook 'rjsx-mode-hook 'lsp)