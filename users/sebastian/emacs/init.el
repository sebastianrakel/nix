;; init.el

(setq package-enable-at-startup nil)
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
	(url-retrieve-synchronously
	 "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
	 'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Install use-package
(straight-use-package 'use-package)

;; Configure use-package to use straight
(use-package straight
  :custom
  (straight-use-package-by-default t))

(use-package emacs
  :hook
  ((prog-mode . display-line-numbers-mode))
  :config
  (set-default 'truncate-lines t)
  (setopt use-short-answers t)
  (windmove-default-keybindings 'meta)
  (electric-pair-mode 1)

  ;; Backup Files
  (setq backup-directory-alist `((".*" . ,temporary-file-directory))
	auto-save-file-name-transforms `((".*" ,temporary-file-directory t))
	create-lockfiles nil)
  
  (defun own/treesit-install-langs()
    (interactive)
    (mapcar #'treesit-install-language-grammar (mapcar #'car treesit-language-source-alist)))

  (setq treesit-language-source-alist
	'((bash "https://github.com/tree-sitter/tree-sitter-bash")
	  (csharp "https://github.com/tree-sitter/tree-sitter-c-sharp")
	  (cmake "https://github.com/uyha/tree-sitter-cmake")
	  (css "https://github.com/tree-sitter/tree-sitter-css")
	  (elisp "https://github.com/Wilfred/tree-sitter-elisp")
	  (go "https://github.com/tree-sitter/tree-sitter-go" "v0.21.0")
	  (gomod "https://github.com/camdencheek/tree-sitter-go-mod")
	  (html "https://github.com/tree-sitter/tree-sitter-html")
	  (javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
	  (json "https://github.com/tree-sitter/tree-sitter-json")
	  (make "https://github.com/alemuller/tree-sitter-make")
	  (markdown "https://github.com/ikatyang/tree-sitter-markdown")
	  (python "https://github.com/tree-sitter/tree-sitter-python")
	  (toml "https://github.com/tree-sitter/tree-sitter-toml")
	  (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
	  (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")))

  (setq major-mode-remap-alist
	'((bash-mode . bash-ts-mode)
	  (csharp-mode . csharp-ts-mode)
	  (js2-mode . js-ts-mode)
	  (typescript-mode . typescript-ts-mode)
	  (json-mode . json-ts-mode)
	  (css-mode . css-ts-mode)
	  (python-mode . python-ts-mode)
	  (go-mode . go-ts-mode))))

(use-package base16-theme
  :demand
  :init
  (defun own/theme-custome-faces()
    (set-face-attribute 'org-block nil :background (face-attribute 'default :background))
    (set-face-attribute 'org-block-begin-line nil :background (face-attribute 'default :background))
    (set-face-attribute 'org-block-end-line nil :background (face-attribute 'default :background)))

  (defun own/theme-load-last-theme()
    (interactive)
    (load-theme current-theme t))

  (defun own/theme-switch-theme(theme)
    (interactive)
    (disable-theme current-theme)
    (setq current-theme theme)
    (own/theme-load-last-theme))

  (setq base16-theme-256-color-source "colors"
	base16-theme-distinct-fringe-background nil)

  ;;(add-to-list 'custom-theme-load-path "~/.base16-themes/emacs/")
  (load-file "~/.emacs.d/theme.el")

  ;; Overwriting some face attributes, cause i like it
  (with-eval-after-load 'org-faces
    (if (daemonp)
	(add-hook 'server-after-make-frame-hook #'own/theme-custome-faces)
      (own/theme-custome-faces))))

(use-package doom-modeline
  :hook
  (after-init . doom-modeline-mode)
  :custom
  (doom-modeline-height 40)
  (doom-modeline-project-detection 'truncate-with-project)
  (doom-modeline-icon t))

(use-package dashboard
  :config
  (dashboard-setup-startup-hook))

(use-package projectile
  :bind-keymap
  (("C-c p" . projectile-command-map))
  :custom
  (projectile-indexing-method 'hybrid)
  :config
  (defun own/projectile-reload-projects() (interactive) (projectile-discover-projects-in-directory "~/projects/" 4))
  (add-to-list 'projectile-globally-ignored-directories "node_modules")
  (projectile-mode +1))

(use-package vertico
  :config
  (setq vertico-count 13
	vertico-resize t
	vertico-cycle nil
	vertico-buffer-display-action '(display-buffer-reuse-window))
  (vertico-mode))

(use-package consult
  :bind
  (("C-c b" . consult-buffer)
   ("C-s" . consult-line)))

(use-package consult-eglot
  :after consult
  :bind
  (("C-c j s" . consult-eglot-symbols)))

(use-package corfu
  :custom
  (corfu-auto t)
  :config
  (setq corfu-popupinfo-delay 0.5
	corfu-popupinfo-direction "right")
  :init
  (global-corfu-mode)
  (corfu-popupinfo-mode))

(use-package marginalia
  :init
  (marginalia-mode))

(use-package orderless
  :custom
  (completion-styles '(orderless))
  (completion-category-defaults nil)
  (completion-category-overrides
   '((file (styles basic-remote
		   orderless)))))

(use-package cape
  :init
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-elisp-block)
  (add-to-list 'completion-at-point-functions #'yasnippet-capf)
  :config
  (defun own/eglot-capf ()
    (setq-local completion-at-point-functions
		(list (cape-capf-super
		       #'eglot-completion-at-point
		       #'cape-dabbrev
		       #'cape-file
		       #'yasnippet-capf))))
  (advice-add 'eglot-completion-at-point :around #'cape-wrap-buster)
  (add-hook 'eglot-managed-mode-hook #'own/eglot-capf))

(use-package yasnippet-capf
  :after cape
  :config
  (add-to-list 'completion-at-point-functions #'yasnippet-capf))

(use-package yasnippet
  :init
  (yas-global-mode 1)
  :bind
  (("S-<Tab>" . 'yas-next-field))
  :config
  (advice-add 'yas--modes-to-activate :around
	      (defun yas--get-snippet-tables@tree-sitter (orig-fn &optional mode)
		(funcall orig-fn
			 (or (car-safe (rassq (or mode major-mode) major-mode-remap-alist))
			     mode)))))

(use-package yasnippet-snippets
  :after yasnippet)

(use-package which-key
  :custom
  (which-key-idle-delay 0.3)
  :init
  (which-key-mode))

(use-package rainbow-delimiters
  :hook
  (prog-mode . rainbow-delimiters-mode))

(use-package highlight-indent-guides
  :hook
  (prog-mode . highlight-indent-guides-mode)
  :custom
  (highlight-indent-guides-method 'character)
  (highlight-indent-guides-responsive 'top))

(use-package editorconfig
  :ensure t
  :config
  (editorconfig-mode 1))

(use-package org
  :straight (:type built-in)
  :custom
  (org-agenda-files (list "~/Nextcloud/Documents/Todos/")))

(use-package org-modern
  :after org
  :hook
  (org-mode . org-modern-mode)
  :custom
  (org-hide-emphasis-markers t)
  (org-pretty-entities t)
  (org-auto-align-tags nil)
  (org-tags-column 0)
  (org-insert-heading-respect-content t))

(use-package magit)

(use-package eglot
  :straight (:type built-in)
  :bind
  (:map eglot-mode-map
	("M-<return>" . eglot-code-actions)
	("C-c l f" . eglot-format-buffer))
  :custom
  (completion-category-overrides '((eglot (styles orderless))))
  (eglot-autoshutdown t)
  :commands eglot
  :hook
  (go-ts-mode . eglot-ensure)
  (csharp-ts-mode . eglot-ensure)
  :config
  (fset #'jsonrpc--log-event #'ignore)
  (add-to-list 'eglot-server-programs
	       `(csharp-ts-mode . ("OmniSharp" "-lsp" "-stdio"))))

(use-package eglot-booster
  :straight (eglot-booster :type git :host github :repo "jdtsmith/eglot-booster")
  :after eglot
  :config
  (eglot-booster-mode))

(use-package flyspell
  :if (executable-find "ispell")
  :hook
  ((text-mode . flyspell-mode)
   (prog-mode . flyspell-prog-mode)))

;; programming modes

(use-package go-mode
  :after eglot
  :hook
  ((go-ts-mode . own/eglot-format-buffer-on-save)
   (go-ts-mode . own/eglot-organize-imports-add-hook))
  :init
  (defun own/eglot-organize-imports()
    (call-interactively 'eglot-code-action-organize-imports))
  (defun own/eglot-organize-imports-add-hook()
    (add-hook 'before-save-hook 'own/eglot-organize-imports nil t))
  (defun own/eglot-format-buffer-on-save ()
    (add-hook 'before-save-hook #'eglot-format-buffer -10 t)))

(use-package nix-mode)
(use-package markdown-mode)
(use-package puppet-mode)
(use-package dockerfile-mode)
(use-package yaml-mode)
(use-package hcl-mode)
(use-package powershell)
