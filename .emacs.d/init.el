(defvar brody/default-font-size 140)

(setq inhibit-startup-message t)

(scroll-bar-mode -1)
(tool-bar-mode -1)
(set-fringe-mode 10)
(setq-default indent-tabs-mode nil)
(load-theme 'wombat)
(menu-bar-mode -1)  
(setq-default tab-width 2)
;; automatic matching
(electric-pair-mode 1)
;; turn off line wrapping
(setq-default truncate-lines t)

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; backups to single file
(setq backup-directory-alist '(("" . "~/.emacs.d/backup")))

;; evil keybindings that need to get unbound
(with-eval-after-load 'evil-maps
  (define-key evil-normal-state-map (kbd "C-n") nil)
  (define-key evil-normal-state-map (kbd "C-p") nil))

;; WINDOW COMMANDS
;; Setup window movement commands (disable window hide functionality on mac)
;; remapping existing C-hjkl commants into M-hjkl, then turning them into window moves
(setq mac-pass-command-to-system nil)
(global-set-key (kbd "C-h") 'evil-window-left)
(global-set-key (kbd "C-S-h") 'shrink-window-horizontally)
(global-set-key (kbd "M-h") 'help-command)
(global-set-key (kbd "C-j") 'evil-window-down)
(global-set-key (kbd "C-S-j") 'enlarge-window)
(global-set-key (kbd "M-j") 'electric-newline-and-maybe-inden)
(global-set-key (kbd "C-k") 'evil-window-up)
(global-set-key (kbd "M-k") 'kill-line)
(global-set-key (kbd "C-S-k") 'shrink-window)
(global-set-key (kbd "C-l") 'evil-window-right)
(global-set-key (kbd "C-S-l") 'enlarge-window-horizontally)
(global-set-key (kbd "M-l") 'recenter-top-bottom)
(global-set-key (kbd "C-p") 'projectile-find-file)


(set-face-attribute 'default nil :font "jetbrainsmono nerd font mono" :height brody/default-font-size)
;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
 (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
   (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(column-number-mode)
(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)
(setq scroll-step 1 scroll-conservatively 10000 scroll-margin 8)

(setq ns-auto-hide-menu-bar t)
;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
		vterm-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))
    
;; get shell variables loading properly in emacs commented for now in case it was slowing things down
(use-package exec-path-from-shell)
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-copy-env "PRISM_NPM_TOKEN")
  (exec-path-from-shell-initialize))

;; git
(use-package magit
  :ensure t
  :commands (magit-status magit-get-current-branch)
  :custom (magit-git-executable "/usr/bin/git")
  :config
  (remove-hook 'magit-status-sections-hook 'magit-insert-tags-header)
  (remove-hook 'magit-status-sections-hook 'magit-insert-unpushed-to-pushremote)
  (remove-hook 'magit-status-sections-hook 'magit-insert-unpulled-from-pushremote)
  (remove-hook 'magit-status-sections-hook 'magit-insert-unpulled-from-upstream)
  (remove-hook 'magit-status-sections-hook 'magit-insert-unpushed-to-upstream-or-recent))

;; only refresh the status buffer if it is the active buffer
(setq magit-refresh-status-buffer nil)

;; Enable vertico
(use-package vertico
  :bind (:map vertico-map
         ("C-j" . vertico-next)
         ("C-k" . vertico-previous)
         ("C-f" . vertico-exit))
  :custom
  (vertico-cycle t)
  (vertico-count 20)
  :custom-face
  (vertico-group-title ((t (:foreground "#fca503"))))
  (vertico-group-separator ((t (:foreground "#fca503"))))
  :init
  (vertico-mode))

;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :init
  (savehist-mode))

;; Enable richer annotations using the Marginalia package
(use-package marginalia
  :after vertico
  :bind (:map minibuffer-local-map
         ("M-A" . marginalia-cycle))
  :init
  (marginalia-mode))

(defun brody/get-project-root ()
  (when (fboundp 'projectile-project-root)
    (projectile-project-root)))

(use-package consult
  :demand t
  :bind (("C-s" . consult-line)
         ("C-M-l" . consult-imenu)
         ("C-M-j" . persp-switch-to-buffer*)
         :map minibuffer-local-map
         ("C-r" . consult-history))
  :custom
  (consult-project-root-function #'brody/get-project-root)
  (completion-in-region-function #'consult-completion-in-region)
  :hook (completion-list-mode . consult-preview-at-point-mode))

(consult-customize
 consult-ripgrep consult-git-grep consult-grep consult-theme
 :preview-key (kbd "C-'"))

;; use orderless for completion style
(use-package orderless
  :ensure t
  :custom (completion-styles '(orderless))
  :init
  (setq completion-cetegory-defaults nil
	completion-category-overrides '((file (styles partial-completion)))))

;; Note: The first time you load your configuration on a new machine, you'll
;; need to run the following command interactively so that mode line icons
;; display correctly:
;;
;; M-x all-the-icons-install-fonts

(use-package all-the-icons)

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)
	   (doom-modeline-lsp t)))

(use-package doom-themes
  :init (load-theme 'doom-nord t))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package ace-window
  :bind (("M-o" . ace-window))
  :custom
  (aw-scope 'frame)
  (aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  (aw-minibuffer-flag t)
  :config
  (ace-window-display-mode 1))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 1))

(defun brody/evil-hook ()
  (dolist (mode '(custom-mode
                  eshell-mode
                  git-rebase-mode
                  term-mode))
  (add-to-list 'evil-emacs-state-modes mode)))

(use-package undo-tree
  :init
  (global-undo-tree-mode 1))

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  (setq evil-shift-width 2)
  (setq evil-respect-visual-line-mode t)
  (setq evil-undo-system 'undo-tree)
  :config
  (add-hook 'evil-mode-hook 'brody/evil-hook)
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)
  (define-key evil-motion-state-map (kbd "s-h") 'evil-window-left)
  (define-key evil-motion-state-map (kbd "s-j") 'evil-window-down)
  (define-key evil-motion-state-map (kbd "s-k") 'evil-window-up)
  (define-key evil-motion-state-map (kbd "s-l") 'evil-window-right)
   ;;Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)
  (evil-define-key 'normal magit-mode-map (kbd "SPC") nil)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))

(use-package general
  :config
  (general-evil-setup t)

  (general-create-definer brody/leader-key-def
    :keymaps '(normal visual emacs) ;;magit-status-mode-map magit-log-mode-map magit-diff-mode-map magit-staged-section-map git-rebase-mode-map)
    :prefix "SPC"
    :global-prefix "SPC"))

(brody/leader-key-def
  ;; root bindings
  "v"  '(split-window-right :which-key "vertical split")
  "h"  '(split-window-below :which-key "horizontal split")
  "o"  '(consult-ripgrep :which-key "Search Project")
  "d"  '(delete-window :which-key "kill current window")
  "D"  '((lambda () (interactive) (kill-current-buffer) (delete-window)) :which-key "kill current buffer")
  "m"  '(brody/toggle-maximize-buffer :which-key "Toggle Maximize")
  "="  '(balance-windows :which-key "equalize windows")
  ;; toggles section
  "t"  '(:ignore t :which-key "toggles")
  "tt" '(consult-theme :which-key "choose theme")
  ;; buffer section
  "b" '(:ignore t :which-key "Buffers")
  "bk"  '(kill-current-buffer :which-key "kill buffer")
  ;; git commands
  "g" '(:ignore t :which-key "Git")
  "gs" '(magit-status :which-key "magit status"))

(general-define-key
   :keymaps 'transient-base-map
   "<escape>" 'transient-quit-one)

;; workspaces using perspective
(use-package perspective
  :demand t
  :bind (("C-M-k" . persp-switch)
         ("C-M-n" . persp-next)
         ("C-x k" . persp-kill-buffer*))
  :custom
  (persp-initial-frame-name "Main")
  :config
  ;; Running `persp-mode' multiple times resets the perspective list...
  (unless (equal persp-mode t)
    (persp-mode)))

(defun brody/switch-project-action ()
  (persp-switch (projectile-project-name)))

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :demand t
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  ;; NOTE: Set this to the folder where you keep your Git repos!
  (when (file-directory-p "~/Dev")
    (setq projectile-project-search-path '("~/Dev")))
  (setq projectile-switch-project-action #'brody/switch-project-action))

;; web mode setup

(defun brody/webmode-hook ()
	"Webmode hooks."
	(setq web-mode-enable-comment-annotation t)
	(setq web-mode-markup-indent-offset 2)
	(setq web-mode-code-indent-offset 2)
	(setq web-mode-css-indent-offset 2)
	(setq web-mode-attr-indent-offset 0)
	(setq web-mode-enable-auto-indentation t)
	(setq web-mode-enable-auto-closing t)
	(setq web-mode-enable-auto-pairing t)
	(setq web-mode-enable-css-colorization t))

(use-package web-mode
	:ensure t
  :mode (("\\.js\\'" . web-mode)
         ("\\.jsx\\'" . web-mode)
         ("\\.ts\\'" . web-mode)
         ("\\.tsx\\'" . web-mode)
         ("\\.html\\'" . web-mode)
         ("\\.vue\\'" . web-mode)
				 ("\\.json\\'" . web-mode))
  :commands web-mode
	:hook (web-mode . brody/webmode-hook)
  :config
  (setq web-mode-content-types-alist
	'(("jsx" . "\\.js[x]?\\'")))
  )

;; Syntax checking with flycheck
(use-package flycheck
  :defer t
  :hook (lsp-mode . flycheck-mode))

;; company
(setq company-minimum-prefix-length 1
      company-idle-delay 0.0)

(use-package company
  :ensure t
  :config (global-company-mode t))

;; lsp-mode
(setq lsp-log-io nil) ;; Don't log everything = speed
(setq lsp-keymap-prefix "C-c l")
(setq lsp-restart 'auto-restart)
(setq lsp-diagnostics-provider :flycheck)
(setq lsp-completion-provider :capf)
(global-set-key (kbd "C-.") #'lsp-ui-peek-find-definitions)

(use-package lsp-mode
  :ensure t
  :hook (
	 (web-mode . lsp-deferred)
	 (lsp-mode . lsp-enable-which-key-integration))
  :bind (:map lsp-mode-map
              ("C-c TAB" . completion-at-point)
              ("TAB" . nil))
  :commands lsp-deferred
  :custom
  (lsp-clients-typescript-server-args '("--stdio" "--tsserver-log-file" "/tmp/stderr"))
  (lsp-headerline-breadcrumb-enable nil))

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)
  :config
  (setq lsp-ui-sideline-enable t)
  (setq lsp-ui-sideline-show-hover nil)
  (setq lsp-ui-doc-position 'bottom)
  (setq lsp-ui-sideline-enable t)
  (setq lsp-ui-sideline-show-diagnostics t)
  (setq lsp-ui-sideline-show-code-actions t)
  (setq lsp-ui-doc-enable t)

;; (use-package treemacs
;;   :ensure t
;;   :defer t
;;   :config
;;   (setq 
;;    ;; The default width and height of the icons is 22 pixels. If you are
;;    ;; using a Hi-DPI display, uncomment this to double the icon size.
;;    ;;(treemacs-resize-icons 44)
;;    treemacs--git-mode 'simple
;;    treemacs-follow-mode t
;;    treemacs-filewatch-mode t
;;    treemacs-fringe-indicator-mode 'always
;;    treemacs-hide-gitignored-files-mode nil)
;;    :bind
;;     (:map global-map
;;         ("M-0"       . treemacs-select-window)
;;         ("C-x t 1"   . treemacs-delete-other-windows)
;;         ("C-x t t"   . treemacs)
;;         ("C-x t B"   . treemacs-bookmark)
;;         ("C-x t C-t" . treemacs-find-file)
;;         ("C-x t M-t" . treemacs-find-tag)))

;; (use-package treemacs-evil
;;   :after (treemacs evil)
;;   :ensure t)

;; (use-package treemacs-projectile
;;   :after (treemacs projectile)
;;   :ensure t)

;; (use-package treemacs-magit
;;   :after (treemacs magit)
;;   :ensure t)

;; (use-package treemacs-perspective ;;treemacs-perspective if you use perspective.el vs. persp-mode
;;   :after (treemacs perspective) ;;or perspective vs. persp-mode
;;   :ensure t
;;   :config (treemacs-set-scope-type 'Perspectives))

(defun brody/toggle-maximize-buffer () "Maximize buffer"
  (interactive)
  (if (= 1 (length (window-list)))
      (jump-to-register '_) 
    (progn
      (window-configuration-to-register '_)
      (delete-other-windows))))

;; terminal mode and multi term
(use-package vterm
  :ensure t)

(use-package multi-vterm
  :ensure t)

(set-face-attribute 'fringe nil :background nil)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(undo-tree projectile unicode-fonts which-key web-mode vertico use-package typescript-mode treemacs-projectile treemacs-perspective treemacs-persp treemacs-magit treemacs-evil treemacs-all-the-icons smooth-scroll rainbow-delimiters orderless multi-vterm marginalia lsp-ui js2-mode ivy-rich helpful general flycheck exec-path-from-shell evil-collection doom-themes doom-modeline counsel-projectile company affe)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(vertico-group-separator ((t (:foreground "#fca503"))))
 '(vertico-group-title ((t (:foreground "#fca503")))))
