;;; config.el ---                                    -*- lexical-binding: t; -*-

(setq doom-font (font-spec :family "Jetbrains Mono" :size 17))
(setq doom-theme 'doom-tokyo-night)
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

;; Git gutter
(global-git-gutter-mode +1)

;; Ruby
(add-to-list 'auto-mode-alist
             '("\\.\\(?:cap\\|gemspec\\|irbrc\\|gemrc\\|rake\\|rb\\|ru\\|thor\\)\\'" . ruby-mode))
(add-to-list 'auto-mode-alist
             '("\\(?:Brewfile\\|Capfile\\|Gemfile\\(?:\\.[a-zA-Z0-9._-]+\\)?\\|[rR]akefile\\)\\'" . ruby-mode))

(add-hook 'ruby-mode-hook 'lsp)

;; React
(add-to-list 'auto-mode-alist '("\\.js.*$" . rjsx-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . json-mode))
(add-hook 'rjsx-mode-hook 'tide-setup)
(add-hook 'rjsx-mode-hook 'lsp)
(add-hook 'tide-mode-hook 'lsp)

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

;; Trimm name
(defun fw/s-truncate (len s &optional ellipsis)
  "Like `s-truncate' but
- return S when LEN is nil
- return empty string when len is shorter than ELLIPSIS"
  (declare (pure t) (side-effect-free t))
  (let ((ellipsis (or ellipsis "...")))
    (cond
     ((null len) s)
     ((< len (length ellipsis)) "")
     (t (s-truncate len s ellipsis)))))

(defun fw/doom-modeline-segment--buffer-info (orig-fn &rest args)
  "`doom-modeline-segment--buffer-info' but truncate for EXWM buffers."
  (fw/s-truncate
   (and (derived-mode-p 'exwm-mode)
	(max 15 (- (window-width) 45)))
   (format-mode-line (apply orig-fn args))
   "..."))
(advice-add #'doom-modeline-segment--buffer-info :around #'fw/doom-modeline-segment--buffer-info)
