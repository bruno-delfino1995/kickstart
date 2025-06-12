(defconst user/font-family "Monaspace Argon" "Monospaced font for programmers")
(defconst user/font-size-default 160 "Bigger font = Less eye straining")
(defconst user/projects-dirs '("~/Projects/" "~/Playground/") "Where do you store your projects?")

(setq-default
 visible-bell t                ; Use visible bell instead of audible
 inhibit-startup-message t     ; Show scratch buffer instead of home page
 initial-scratch-message ""    ; Empty the initial *scratch* buffer
 x-select-enable-clipboard t   ; Merge Emacs and System clipboard
 indent-tabs-mode nil)         ; Disable inserting tabs to optimize for minimal characters

(global-hl-line-mode 1)  ; Hightlight current line
(column-number-mode 1)   ; Show current column in modeline
(scroll-bar-mode -1)     ; Disable visible scrollbar
(tool-bar-mode -1)       ; Disable the toolbar
(tooltip-mode -1)        ; Disable tooltips
(set-fringe-mode 10)     ; Give some breathing room
(menu-bar-mode -1)       ; Disable the menu bar

(global-set-key (kbd "<escape>") 'keyboard-escape-quit) ; Make ESC quit prompts

(setq-default
 confirm-kill-emacs 'y-or-n-p)  ; Confirm before exiting Emacs

(fset 'yes-or-no-p 'y-or-n-p)  ; Replace yes/no prompts with the shorter y/n

;; Separate auto generated ~custom-set-variables~ in another file
(setq-default custom-file (expand-file-name ".custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

(defun user/display-startup-time ()
  (message "Loaded in %s."
           (format "%.2f seconds"
                   (float-time
                    (time-subtract after-init-time before-init-time)))
           ))

(add-hook 'emacs-startup-hook #'user/display-startup-time)

;; The default is 800 kilobytes.  Measured in bytes.
(setq gc-cons-threshold (* 50 1000 1000))

;; Initialize package sources
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

;; Download package archive if it isn't ready
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Initialize use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

;; Configure use-package to always download packages before executing them
(setq use-package-always-ensure t)

;; What's more helpful than a smarter help?
(use-package helpful
  :after counsel
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

(set-face-attribute 'default nil :font user/font-family :height user/font-size-default)

(use-package base16-theme
  :ensure t
  :config (load-theme 'base16-unikitty-light t))

(use-package general)

(general-create-definer control-plane
  :prefix "SPC"
  :global-prefix "C-SPC")

(use-package hydra)

;; Keybindings menu for choosing what to execute
(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config (setq which-key-idle-delay 0.3))

;; What about some proper keybindings?
(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  :config
  (evil-mode 1)
  ;; Use visual line motions even outside of visual-line-mode buffers
  (general-def 'motion "j" 'evil-next-visual-line)
  (general-def 'motion "k" 'evil-previous-visual-line)
  (general-def 'motion "C-h" 'evil-window-left)
  (general-def 'motion "C-j" 'evil-window-down)
  (general-def 'motion "C-k" 'evil-window-up)
  (general-def 'motion "C-l" 'evil-window-right))

;; Corrupt everything with your evilness
(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

;; Completion engine
(use-package ivy
  :diminish
  :bind
  ("C-s" . swiper)
  (:map ivy-minibuffer-map
        ("TAB" . ivy-alt-done)
        ("C-l" . ivy-alt-done)
        ("C-j" . ivy-next-line)
        ("C-k" . ivy-previous-line))
  (:map ivy-switch-buffer-map
        ("C-k" . ivy-previous-line)
        ("C-l" . ivy-done)
        ("C-d" . ivy-switch-buffer-kill))
  (:map ivy-reverse-i-search-map
        ("C-k" . ivy-previous-line)
        ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

;; More information when completing
(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

;; Emacs commands but with an Ivy coat
(use-package counsel
  :after ivy
  :bind
  ("M-x" . counsel-M-x)
  ("C-x b" . counsel-ibuffer)
  ("C-x C-f" . counsel-find-file)
  (:map minibuffer-local-map
        ("C-r" . 'counsel-minibuffer-history)))

(use-package treesit-auto
  :config
  (setq treesit-auto-install 'prompt)
  (global-treesit-auto-mode))

(use-package elixir-ts-mode)

(use-package markdown-mode)

;; What're you working on?
(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode 1)
  :custom ((projectile-completion-system 'ivy))
  :init
  (setq projectile-project-search-path user/projects-dirs)
  (setq projectile-auto-cleanup-known-projects t)
  (setq projectile-switch-project-action #'projectile-dired)
  :general
  (control-plane 'normal
    "p p" 'projectile-switch-project
    "p f" 'projectile-find-file))

(use-package counsel-projectile
  :after (counsel projectile)
  :config (counsel-projectile-mode 1))

;; Commit a hunks easily, and push them to GitHub!
(use-package magit
  :general
  (control-plane 'normal 'override
    "g g" 'magit-status)
  :init
  (setq forge-add-default-bindings nil))

(use-package forge
  :after magit)

;; Program without downloading an IDE for each language
(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (lsp-enable-which-key-integration t))

(use-package lsp-ivy)

;; Companion to give you completion suggestions
(use-package company
  :after lsp-mode
  :hook (lsp-mode . company-mode)
  :bind
  (:map company-active-map
        ("<tab>" . company-complete-selection))
  (:map lsp-mode-map
        ("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))

(use-package company-box
  :hook (company-mode . company-box-mode))

;; Let's get our shit together
(use-package org
  :config
  (setq org-ellipsis " ▾"))

;; Show alternating bullets instead of boring asterisks
(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

;; We've got live the life
(setq org-confirm-babel-evaluate nil)

;; Make GC pauses faster by decreasing the threshold (200 kilobytes).
(setq gc-cons-threshold (* 2 1000 1000))
