(defvar brody/default-font-size 140)
(defvar brody/default-variable-font-size 140)

(setq inhibit-startup-message t)

(scroll-bar-mode -1)
(tool-bar-mode -1)
(set-fringe-mode 10)
(menu-bar-mode -1)  
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)

;; Revert Dired and other buffers
(setq global-auto-revert-non-file-buffers t)
;; Revert buffers when the underlying file has changed
(global-auto-revert-mode 1)

;; automatic matching
(electric-pair-mode 1)
;; turn off line wrapping
(setq-default truncate-lines t)

;; when in special mode (i.e logging) we want to see wrapping
(add-hook 'special-mode-hook
          (lambda ()
            (setq truncate-lines nil)))

;; Make ESC quit prompts
;; (global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; backups to single file
(defvar backup-dir "~/.emacs.d/backup/")
(setq backup-directory-alist (list (cons "." backup-dir)))

;; dont let custom variabled dirty init.el
(setq custom-file (concat user-emacs-directory "/custom.el"))

;; don't create lockfiles
(setq create-lockfiles nil)

;; ignore docstring warnings in native compilation
(setq byte-compile-warnings '(not docstrings))

;; Make gc pauses faster by decreasing the threshold. recommended by LSP docs
(setq gc-cons-threshold 100000000)
;; (setq gc-cons-threshold (* 2 1000 1000))

;; set read process output max, recommended by LSP docs
(setq read-process-output-max (* 1024 1024))

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
;; Set the variable pitch face
(set-face-attribute 'variable-pitch nil :font "jetbrainsmono nerd font mono" :height brody/default-variable-font-size)

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
                eshell-mode-hook
                neotree-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))
    
;; get shell variables loading properly in emacs commented for now in case it was slowing things down
(use-package exec-path-from-shell)
(when (memq window-system '(mac ns x))
  (setenv "SHELL" "bin/zsh")
  (exec-path-from-shell-copy-env "PRISM_NPM_TOKEN")
  (exec-path-from-shell-initialize))

;; color support for term mode
(use-package eterm-256color
  :hook (term-mode . eterm-256color-mode))

;; git
(use-package magit
  :ensure t
  :commands (magit-status magit-get-current-branch)
  :custom
  (magit-git-executable "/usr/bin/git")
  (magit-save-repository-buffers nil)
  :config
  (remove-hook 'magit-status-sections-hook 'magit-insert-unpushed-to-pushremote)
  (remove-hook 'magit-status-sections-hook 'magit-insert-unpulled-from-pushremote)
  (remove-hook 'magit-status-sections-hook 'magit-insert-unpulled-from-upstream)
  (remove-hook 'magit-status-sections-hook 'magit-insert-unpushed-to-upstream-or-recent))

;; only refresh the status buffer if it is the active buffer
(setq magit-refresh-status-buffer nil)

;; blame package like vscode
(use-package blamer
  :ensure t
  :defer 20
  :custom
  (blamer-idle-time 0.3)
  (blamer-min-offset 70)
  :custom-face
  (blamer-face ((t :foreground "#7a88cf"
                    :background nil
                    :height 140
                    :italic t)))
  :config
  (global-blamer-mode 1))

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

;; Ripgrep the current word from project root
(defun consult-ripgrep-at-point ()
  (interactive)
  (consult-ripgrep (brody/get-project-root)(thing-at-point 'symbol)))

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
  :init (load-theme 'doom-monokai-classic t))

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

;; maintain visual selection when indenting text in evil
(defun brody/evil-shift-right ()
  (interactive)
  (evil-shift-right evil-visual-beginning evil-visual-end)
  (evil-normal-state)
  (evil-visual-restore))

(defun brody/evil-shift-left ()
  (interactive)
  (evil-shift-left evil-visual-beginning evil-visual-end)
  (evil-normal-state)
  (evil-visual-restore))

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  (setq evil-shift-width 2)
  ;; (setq evil-respect-visual-line-mode t)
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
  ;;(evil-global-set-key 'motion "j" 'evil-next-visual-line)
  ;;(evil-global-set-key 'motion "k" 'evil-previous-visual-line)
  (evil-define-key 'visual global-map (kbd ">") 'brody/evil-shift-right)
  (evil-define-key 'visual global-map (kbd "<") 'brody/evil-shift-left)
  (evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter-ace-window)
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

(use-package evil-commentary
  :ensure t
  :config
  (evil-commentary-mode 1))

(use-package evil-easymotion
  :ensure t
  :config
  (evilem-default-keybindings (kbd "SPC i")))

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
  "O"  '(consult-ripgrep-at-point :which-key "Search Project")
  "d"  '(delete-window :which-key "kill current window")
  "D"  '((lambda () (interactive) (kill-current-buffer) (delete-window)) :which-key "kill current buffer")
  "m"  '(brody/toggle-maximize-buffer :which-key "Toggle Maximize")
  "="  '(balance-windows :which-key "equalize windows")
  "e"  '(neotree-toggle :which-key "explorer")
  "SPC" '(execute-extended-command :which-key "execute command")
  ;; toggles section
  "t"  '(:ignore t :which-key "toggles")
  "tt" '(consult-theme :which-key "choose theme")
  "tn" '(brody/make-dean-happy :which-key "Toggle line numbers")
  ;; buffer section
  "b" '(:ignore t :which-key "Buffers")
  "bk"  '(kill-current-buffer :which-key "kill buffer")
  ;; projects and perspectives
  "f" '(:ignore t :which-key "Persp/Projects")
  "ff"  '(persp-switch :which-key "kill buffer")
  ;; debug section

  "j" '(:ignore t :which-key "Debug")
  "jk"  '(hydra-pause-resume :which-key "Toggle Menu")
  ;; git commands
  "g" '(:ignore t :which-key "Git")
  "gi" '(blamer-show-commit-info :which-key "git blame")
  "gs" '(magit-status :which-key "magit status"))

;; all below is for makin escape quit things instead of C-g
(general-define-key
   :keymaps 'transient-base-map
   "<escape>" 'transient-quit-one)

(defun brody/minibuffer-keyboard-quit ()
  "Abort recursive edit.
In Delete Selection mode, if the mark is active, just deactivate it;
then it takes a second \\[keyboard-quit] to abort the minibuffer."
  (interactive)
  (if (and delete-selection-mode transient-mark-mode mark-active)
      (setq deactivate-mark  t)
    (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
    (abort-recursive-edit)))

(general-define-key
 :keymaps '(normal visual global)
 [escape] 'keyboard-quit)

(general-define-key
 :keymaps '(minibuffer-local-map
	    minibuffer-local-ns-map
	    minibuffer-local-completion-map
	    minibuffer-local-must-match-map
	    minibuffer-local-isearch-map)
 [escape] 'brody/minibuffer-keyboard-quit)

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
      company-idle-delay 0.01
      company-tooltip-idle-delay 0.1
      company-dabbrev-downcase 0)

(use-package company
  :ensure t
  :config (global-company-mode t))

;; lsp-mode
;; make sure you use M-x lsp-install-server to install the servers that you need
(setq lsp-log-io nil) ;; Don't log everything = speed
(setq lsp-keymap-prefix "C-c l")
(setq lsp-restart 'auto-restart)
;; testing to see if plists speed things up. remove if still  slow
(setq lsp-use-plists t)
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
  :commands lsp-ui-mode
  :config
  (setq lsp-ui-sideline-enable t)
  (setq lsp-ui-sideline-show-hover nil)
  (setq lsp-ui-doc-position 'bottom)
  (setq lsp-ui-sideline-show-diagnostics t)
  (setq lsp-ui-sideline-show-code-actions t)
  (setq lsp-ui-doc-enable nil)
  ;; make sure that lsp indent uses current webmode indent attribute
  (setf (alist-get 'web-mode lsp--formatting-indent-alist) 'web-mode-code-indent-offset))

(use-package neotree
  :config
  (setq neo-smart-open t)
  (setq neo-window-position :right)
  (setq projectile-switch-project-action 'neotree-projectile-action)
  (setq neo-theme 'icons)
  (setq-default neo-show-hidden-files t)
  (setq neo-window-width 60)
  (setq neo-default-system-application "open"))

(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
                          (require 'lsp-pyright)
                          (lsp-deferred))))

(use-package dockerfile-mode)

;; forced to have treemacs on in order to have dap mode work
;; it's unusably slow in my environment so would need to fix that if want to actually use
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
;;         ("C-x t 1"   . treemacs-delete-other-windows) ;;         ("C-x t t"   . treemacs)
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

;; (use-package lsp-treemacs)


(defun brody/toggle-maximize-buffer () "Maximize buffer"
  (interactive)
  (if (= 1 (length (window-list)))
      (jump-to-register '_) 
    (progn
      (window-configuration-to-register '_)
      (delete-other-windows))))

(defun brody/make-dean-happy ()
  (interactive)
  (if (eq display-line-numbers-type 'relative)
      (menu-bar--display-line-numbers-mode-absolute)
    (menu-bar--display-line-numbers-mode-relative)))

;; terminal mode and multi term
;; (use-package vterm
;;   :ensure t)

;; (use-package multi-vterm
;;   :ensure t)

(use-package dap-mode
  :custom
  (lsp-enable-dap-auto-configure nil)
  :config
  (dap-ui-mode 1)
  (dap-tooltip-mode 1)
  (dap-ui-controls-mode 1)
  ;; open the hydra when breakpoint is hit
  (add-hook 'dap-stopped-hook (lambda (arg) (call-interactively #'dap-hydra)))
  (require 'dap-node)
  (dap-node-setup)
  (require 'dap-chrome)
  (dap-chrome-setup))

(set-face-attribute 'fringe nil :background nil)


(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown"))


;; ORG MODE SETUP
;; inspired from https://www.mtsolitary.com/20210318221148-emacs-configuration/

(defun brody/org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (visual-line-mode 1)
  (setq evil-auto-indent nil))

;; store link for inbox capture
(defun brody/org-capture-inbox ()
     (interactive)
     (call-interactively 'org-store-link)
     (org-capture nil "i"))

(define-key global-map (kbd "C-c i") 'brody/org-capture-inbox)
(define-key global-map (kbd "C-c c") 'org-capture)
(define-key global-map (kbd "C-c a") 'org-agenda)

(use-package org
  :ensure org-contrib
  :hook (org-mode . brody/org-mode-setup)
  :config
  (setq org-ellipsis " ▾"
        org-agenda-start-with-log-mode t
        org-log-done 'time
        org-log-into-drawer t
        org-hide-emphasis-markers t
        org-src-fontify-natively t
        org-fontify-quote-and-verse-blocks t
        org-src-tab-acts-natively t
        org-edit-src-content-indentation 2
        org-hide-block-startup nil
        org-src-preserve-indentation nil
        org-startup-folded 'content
        org-export-preserve-breaks t
        org-cycle-separator-lines 2)

  ;; setup my agenda files
  (setq org-agenda-files
	'("~/Dropbox/Brody/inbox.org"
	  "~/Dropbox/Brody/projects.org"
	  "~/Dropbox/Brody/calendar.org"
	  "~/Dropbox/Brody/people.org"))

  (setq org-agenda-prefix-format
       '((agenda . " %i %?-12t% s")
	 (todo   . " %i")
	 (tags   . " %i %-12:c")
	 (search . " %i %-12:c")))

  (setq org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!)")
          (sequence "BACKLOG(b)" "PLAN(p)" "READY(r)" "ACTIVE(a)" "REVIEW(v)" "WAIT(w@/!)" "HOLD(h)" "|" "COMPLETED(c)" "INCOMPLETE(i)""CANC(k@)")))

  (setq org-refile-targets '(("~/Dropbox/Brody/Notes/1_Personal/1.6_Archive.org" :maxlevel . 9)
                             (org-agenda-files :maxlevel . 9)))
  (setq org-blank-before-new-entry '((heading . t) (plain-list-item . t)))
  (setq org-refile-use-outline-path 'file)
  (setq org-outline-path-complete-in-steps nil)
  (advice-add 'org-refile :after 'org-save-all-org-buffers)
  (setq org-tag-alist
        '((:startgroup)
                                        ; Put mutually exclusive tags here
          (:endgroup)
          ("@errand" . ?E)
          ("@home" . ?H)
          ("@work" . ?W)
          ("agenda" . ?a)
          ("planning" . ?p)
          ("publish" . ?P)
          ("batch" . ?b)
          ("note" . ?n)
          ("idea" . ?i)))
  (add-hook 'org-mode-hook '(lambda () (setq fill-column 80)))
  (add-hook 'org-mode-hook 'auto-fill-mode)
  (add-hook 'org-mode-hook (lambda () (blamer-mode -1)))
  (add-hook 'org-mode-hook (lambda () (company-mode -1)))
)

;;shortcuts to store link and insert
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c C-l") 'org-insert-link)

(setq org-agenda-log-mode-items '(closed clock state))
(setq org-habit-show-all-today t)

(use-package org-gcal
  :after org
  :config
  (setq org-gcal-client-id "21698682594-j9a8dhtod9b9vtc8kce0lpkb04t86j2v.apps.googleusercontent.com"
        org-gcal-client-secret "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"
        org-gcal-file-alist '(("brodyjackson1@gmail.com" . "~/Dropbox/Brody/calendar.org") ;; main calendar
                              ("0m9vfttjqlhnj8emel2ne11pt515dro5@import.calendar.google.com" . "~/Dropbox/Brody/calendar.org") ;; work calendar
                              ("h6614ocii67jjujj5cgg9fiudc@group.calendar.google.com" . "~/Dropbox/Brody/calendar.org") ;; training schedule
                              ("dbnqsuvdeukfftc6hteqk6r2ac@group.calendar.google.com" . "~/Dropbox/Brody/calendar.org") ;; Flames games
                              ("ubuvf0t6oeicdklvf9igijl0so@group.calendar.google.com" . "~/Dropbox/Brody/calendar.org") ;; Timeboxing calendar
                              ("71u25u7hm1e22bj1ufr9q7ik54t0dv0f@import.calendar.google.com" . "~/Dropbox/Brody/calendar.org") ;; training schedule (TrainerRoad)
                              ("ov0dk4m6dedaob7oqse4nrda4s@group.calendar.google.com" . "~/Dropbox/Brody/calendar.org")) ;; Man united calendar
        org-gcal-local-timezone "America/Edmonton"
        org-gcal-remove-cancelled-events t
        org-gcal-remove-api-cancelled-events t)
  (add-hook 'org-agenda-mode-hook 'org-gcal-fetch)
  (add-hook 'org-capture-after-finalize-hook 'org-gcal-fetch))

(setq org-capture-templates
      '(("j" "Journal" entry (file+datetree+prompt "~/Dropbox/Brody/journal.org") "* Daily Review %?\n %i\n")
        ("t" "Milestone" entry (file+datetree+prompt "~/Dropbox/Brody/journal.org") "* %i\n")
        ("i" "Inbox" entry (file "~/Dropbox/Brody/inbox.org") "* TODO %?\n /Entered on/ %U")
        ("m" "Meeting" entry (file+datetree+prompt "~/Dropbox/Brody/Notes/3_Work/Enverus Meetings.org") "* %?\n %i\n")
        ("n" "Note" entry  (file+headline "~/Dropbox/Brody/inbox.org" "Notes") "* Note\n /Entered on/ %U\n %?"))
      )

(use-package evil-org
  :ensure t
  :after org
  :hook (org-mode . (lambda () evil-org-mode))
  :config
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

;;enable flyspell in text mode (Spell checking)
(add-hook 'text-mode-hook 'flyspell-mode)

(use-package org-download
  :after org
  :defer nil
  :custom
  (org-download-method 'directory)
  (org-download-image-dir "~/Dropbox/Brody/images")
  (org-download-heading-lvl nil)
  (org-download-timestamp "%Y%m%d-%H%M%S_")
  (org-image-actual-width 300)
  (org-download-screenshot-method "/usr/local/bin/pngpaste %s")
  ;; :bind
  ;; ("C-M-y" . org-download-screenshot)
  :config
  (require 'org-download))

;; Add an activated label onto a todo that gets tagged as NEXT
(defun log-todo-next-creation-date (&rest ignore)
  "Log NEXT creation time in the property drawer under the key 'ACTIVATED'"
  (when (and (string= (org-get-todo-state) "NEXT")
             (not (org-entry-get nil "ACTIVATED")))
    (org-entry-put nil "ACTIVATED" (format-time-string "[%Y-%m-%d]"))))
(add-hook 'org-after-todo-state-change-hook #'log-todo-next-creation-date)

(setq org-agenda-custom-commands
      '(("g" "Get Things Done (GTD)"
         ((agenda ""
                  ((org-agenda-skip-function
                    '(org-agenda-skip-entry-if 'deadline))
                   (org-deadline-warning-days 0)))
          (todo "NEXT"
                ((org-agenda-skip-function
                  '(org-agenda-skip-entry-if 'deadline))
                 (org-agenda-prefix-format "  %i %-12:c [%e] ")
                 (org-agenda-overriding-header "\nTasks\n")))
          (agenda nil
                  ((org-agenda-entry-types '(:deadline))
                   (org-agenda-format-date "")
                   (org-deadline-warning-days 7)
                   (org-agenda-skip-function
                    '(org-agenda-skip-entry-if 'notregexp "\\* NEXT"))
                   (org-agenda-overriding-header "\nDeadlines")))
          (tags-todo "inbox"
                     ((org-agenda-prefix-format "  %?-12t% s")
                      (org-agenda-overriding-header "\nInbox\n")))
          (tags "CLOSED>=\"<today>\""
                ((org-agenda-overriding-header "\nCompleted today\n")))))))

;; Org appearance which is taken directly from https://config.daviwil.com/emacs
(use-package org-superstar
  :after org
  :hook (org-mode . org-superstar-mode)
  :custom
  (org-superstar-remove-leading-stars t)
  (org-superstar-headline-bullets-list '("◉" "○" "●" "○" "●" "○" "●"))
  (org-superstar-item-bullet-alist '((?* . ?•)
                                        (?+ . ?➤)
                                        (?- . ?•))))
;; Increase the size of various headings
(general-with-eval-after-load 'org-faces
  (set-face-attribute 'org-document-title nil :font "Iosevka Aile" :weight 'bold :height 1.3)
  (dolist (face '((org-level-1 . 1.2)
                  (org-level-2 . 1.1)
                  (org-level-3 . 1.05)
                  (org-level-4 . 1.0)
                  (org-level-5 . 1.1)
                  (org-level-6 . 1.1)
                  (org-level-7 . 1.1)
                  (org-level-8 . 1.1)))
  (set-face-attribute (car face) nil :font "Iosevka Aile" :weight 'medium :height (cdr face))))

;; don't grey out done tasks
(custom-set-faces
 '(org-done ((t (:foreground "PaleGreen"
                 :weight normal))))
 '(org-headline-done
            ((((class color) (min-colors 16))
               (:foreground "LightSalmon" )))))


;;Setup snippets in org for structural blocks
(require 'org-tempo)
(add-to-list 'org-structure-template-alist '("sh" . "src shell"))
(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
(add-to-list 'org-structure-template-alist '("py" . "src python"))
(add-to-list 'org-structure-template-alist '("js" . "src javascript"))

;; Make sure org-indent face is available
(require 'org-indent)
;; Make sure md is within the export menu
(require 'ox-md nil t)

;; ensure we can ignore header and tagged ignore blocks
(require 'ox-extra)
(ox-extras-activate '(latex-header-blocks ignore-headlines))

;; -- latex setup --
(require 'ox-latex)
;; deleted unwanted file extensions after latexMK
(setq org-latex-logfiles-extensions
      (quote ("lof" "lot" "tex~" "aux" "idx" "log" "out" "toc" "nav" "snm" "vrb" "dvi" "fdb_latexmk" "blg" "brf" "fls" "entoc" "ps" "spl" "bbl" "xmpi" "run.xml" "bcf" "acn" "acr" "alg" "glg" "gls" "ist")))
(setq org-latex-with-hyperref nil) ;; stop org adding hypersetup{author..} to latex export
;;set no default packages
(setq org-latex-default-packages-alist nil)
(setq org-latex-packages-alist nil)
(unless (boundp 'org-latex-classes)
  (setq org-latex-classes nil))
(setq org-export-latex-listings t) 
;; function which will determine how to create latex pdf based on LATEX_CMD
(defun my-auto-tex-cmd (backend)
  (let ((texcmd)))
  ;; default command: oldstyle latex via dvi
  (setq texcmd "latexmk -pdflatex %f")        
  ;; pdflatex -> .pdf
  (if (string-match "LATEX_CMD: pdflatex" (buffer-string))
      (setq texcmd "pdflatex -interaction nonstopmode -shell-escape -f %f"))
  ;; xelatex -> .pdf
  (if (string-match "LATEX_CMD: xelatex" (buffer-string))
      (setq texcmd "xelatex -interaction nonstopmode -shell-escape -f %f"))
  ;; LaTeX compilation command
  (setq org-latex-to-pdf-process (list texcmd)))
(add-hook 'org-export-before-processing-hook 'my-auto-tex-cmd)

;; Ensure that anything that should be fixed-pitch in Org files appears that way
(set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
(set-face-attribute 'org-table nil  :inherit 'fixed-pitch)
(set-face-attribute 'org-formula nil  :inherit 'fixed-pitch)
(set-face-attribute 'org-code nil   :inherit '(shadow fixed-pitch))
(set-face-attribute 'org-indent nil :inherit '(org-hide fixed-pitch))
(set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
(set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
(set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
(set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch)

;; Get rid of the background on column views
(set-face-attribute 'org-column nil :background nil)
(set-face-attribute 'org-column-title nil :background nil)

;; Allow markup to cross multiple new lines
(setcar (nthcdr 4 org-emphasis-regexp-components) 5)
(org-set-emph-re 'org-emphasis-regexp-components org-emphasis-regexp-components)
