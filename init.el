;; This is my emacs init file 
;; By Thomas Helmkay
;; C-M x to evaluate forms inside emacs
;; previous dead version was the .emacs file which is no longer used
;; configure package managment
(require 'package)
(dolist (source '(("melpa" . "http://melpa.milkbox.net/packages/")
;;		  ("melpa-stable" . "https://stable.melpa.org/packages/")
                  ("marmalade" . "http://marmalade-repo.org/packages/")
		  ))
  (add-to-list 'package-archives source))
(package-initialize)

;;packages to install if not installed
(defvar my-packages '(starter-kit-lisp
;;		      js2-mode
		      ;; scala-mode2
		      ensime
		      web-mode
		      clojure-mode
		      cider
		      jedi
		      rainbow-delimiters
                      f;; no idea what this is
                      color-theme-solarized
;;                      auto-complete
;;                      auto-complete-clang
                      cmake-mode
                      markdown-mode
                      rust-mode
                      haskell-mode
                      lua-mode
                      tidy
                      ansible
                      flycheck
;;                      flycheck-rust
                      tide
                      company
                      monokai-theme;;sublime esque theme
                      dockerfile-mode
		      ;; lsp-mode;;provides language server protocol
		      ;; company-lsp
		      ;; lsp-ui
		      ))

;; support for lsp-mode when emacs > 26
(when (>= emacs-major-version 26)
  (setq my-packages (append my-packages (list 'lsp-mode 'company-lsp 'lsp-ui))))

;; refresh package contents
(when (not package-archive-contents)
  (package-refresh-contents))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;; For adding libs that we could not fetch from melpa in the vendors directory
;;(add-to-list 'load-path (expand-file-name "~/.emacs.d/vendors/flycheck-0.19"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/vendors/emacs-livedown"))


;; set emacs theme wombat is a dark theme Doesnt work on aquamacs osx
;;(load-theme 'solarized-dark t)
(load-theme 'monokai t)

;; File loading function
(defun load-user-files (files)
  (dolist (x files)
    (setq path (concat "~/.emacs.d/scripts/" x))
    (print path)
    (load-file path)))

;;Load our modes.el and any custom elsip code we have written, these file should
;;be in the scripts directory
(load-user-files (list "yaml-mode.el"
                       "utils.el"
                       "modes.el"
		       "dom.el"))

;; fix some shit errors with ido mode seems to be included by default
(if (not (boundp 'ido-cur-item))
    (setq-default ido-cur-item 123))

(if (not (boundp 'ido-default-item))
    (setq-default ido-default-item 123))

(if (not (boundp 'ido-cur-list))
    (setq-default ido-cur-list 123))



;; No idea what this is below here its auto generated


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(livedown:autostart nil)
 '(livedown:open t)
 '(livedown:port 1337)
 '(package-selected-packages
   (quote
    (lsp-ui company-lsp lsp-mode dockerfile-mode monokai-theme tide flycheck ansible tidy lua-mode haskell-mode rust-mode markdown-mode cmake-mode color-theme-solarized f rainbow-delimiters jedi cider clojure-mode web-mode ensime starter-kit-lisp))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
