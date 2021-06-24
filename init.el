;; init.el requires use-package: https://github.com/jwiegley/use-package
;;
;; Requirements
;; ----------
;; C: clangd, digestif

;; - - - - - - - - - -
;; Basic Configuration
;; - - - - - - - - - -

(setq inhibit-startup-screen t)  ;; Hide the startup screen

;; Remove the *scratch* and *messages* buffer.
;;
;; Makes *scratch* empty.
(setq initial-scratch-message "")

;; Removes *scratch* from buffer after the mode has been set.
(defun remove-scratch-buffer ()
  (if (get-buffer "*scratch*")
      (kill-buffer "*scratch*")))
(add-hook 'after-change-major-mode-hook 'remove-scratch-buffer)

;; Removes *messages* from buffer.
(setq-default message-log-max nil)
(kill-buffer "*Messages*")

;; - - - - - - - - - -
;; Packages
;; - - - - - - - - - -

;; melpa
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; undo-tree
(use-package undo-tree :ensure t)
(global-undo-tree-mode)

;; counsel (ivy, swiper, and counsel)
(use-package counsel :ensure t)
(ivy-mode 1)

(setq ivy-use-virtual-buffers t)
(setq ivy-count-format "(%d/%d) ")

(global-set-key (kbd "C-s") 'swiper-isearch)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "M-y") 'counsel-yank-pop)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "<f2> j") 'counsel-set-variable)
(global-set-key (kbd "C-x b") 'ivy-switch-buffer)
(global-set-key (kbd "C-c v") 'ivy-push-view)
(global-set-key (kbd "C-c V") 'ivy-pop-view)

(global-set-key (kbd "C-c c") 'counsel-compile)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c L") 'counsel-git-log)
(global-set-key (kbd "C-c k") 'counsel-rg)
(global-set-key (kbd "C-c m") 'counsel-linux-app)
(global-set-key (kbd "C-c n") 'counsel-fzf)
(global-set-key (kbd "C-x l") 'counsel-locate)
(global-set-key (kbd "C-c J") 'counsel-file-jump)
(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
(global-set-key (kbd "C-c w") 'counsel-wmctrl)

(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "C-c b") 'counsel-bookmark)
(global-set-key (kbd "C-c d") 'counsel-descbinds)
(global-set-key (kbd "C-c o") 'counsel-outline)
(global-set-key (kbd "C-c t") 'counsel-load-theme)
(global-set-key (kbd "C-c F") 'counsel-org-file)

;; themes
(load-theme 'misterioso t)

;; which-key
(use-package which-key :ensure t)
(which-key-mode)

;; windmove
(use-package windmove :ensure t)
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

;; dimmer
(use-package dimmer :ensure t)
(setq dimmer-fraction 0.4)
(dimmer-mode t)

;; projectile
(use-package projectile :ensure t)
(projectile-mode 1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

;; treemacs
(use-package treemacs :ensure t :config (treemacs))
(use-package treemacs-projectile :ensure t :requires (treemacs projectile))

;; magit
(use-package magit :ensure t)

;; eglot
(use-package eglot :ensure t)
(add-hook 'c-mode-hook 'eglot-ensure)

;; company
(use-package company :ensure t)
(add-hook 'after-init-hook 'global-company-mode)

;; eldoc-box
(use-package eldoc-box :ensure t)
(add-hook 'eglot--managed-mode-hook #'eldoc-box-hover-at-point-mode t)

;; yasnippet
(use-package yasnippet :ensure t :config (yas-global-mode 1))
(use-package yasnippet-snippets :ensure t :requires (yasnippet))

;; auctex
(use-package tex :ensure auctex)

;; magic-latex-buffer
(use-package magic-latex-buffer
  :ensure t
  :hook LaTeX-mode)

;; flyspell-mode
(add-hook 'LaTeX-mode-hook 'flyspell-mode)

;; pdf-tools
(use-package pdf-tools
  :ensure t
  :requires (tex)
  :config (pdf-tools-install)
  :init
  (setq TeX-view-program-selection '((output-pdf "PDF Tools")))
  (setq TeX-source-correlate-start-server t)
  (setq TeX-save-query nil)
  :hook (TeX-after-compilation-finished-hook . TeX-revert-document-buffer))
