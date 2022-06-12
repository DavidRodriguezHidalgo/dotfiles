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

;; Keymaps
  (define-prefix-command 'z-map)
  (map! :leader :desc "Custom keybindings" "z" 'z-map) ;; was C-1
  (define-key z-map (kbd "f") 'format-all-buffer)

;; Org-mode stuff
(after! org-bullets
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))
;; Projectile
(setq
 projectile-project-search-path '("~/projects/")
 )

;; Ruby
(add-to-list 'auto-mode-alist
             '("\\.\\(?:cap\\|gemspec\\|irbrc\\|gemrc\\|rake\\|rb\\|ru\\|thor\\)\\'" . ruby-mode))
(add-to-list 'auto-mode-alist
             '("\\(?:Brewfile\\|Capfile\\|Gemfile\\(?:\\.[a-zA-Z0-9._-]+\\)?\\|[rR]akefile\\)\\'" . ruby-mode))

(add-hook 'ruby-mode-hook 'lsp)

;; React
(add-hook 'rjsx-mode-hook 'lsp)

;; Go
(autoload 'go-mode "go-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))
(add-hook 'go-mode-hook 'lsp)

;; Git
(setq magit-status-margin
  '(t "%Y-%m-%d %H:%M " magit-log-margin-width t 18))

  (after! git-gutter
  :init
  (global-git-gutter-mode +1))
  (global-set-key (kbd "M-g M-g") 'hydra-git-gutter/body)
