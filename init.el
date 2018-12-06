;; This is my emacs init file 
;; By Thomas Helmkay
;; C-M x to evaluate forms inside emacs
;; previous dead version was the .emacs file which is no longer used
;; configure package managment
(require 'package)
(dolist (source '(("melpa" . "http://melpa.milkbox.net/packages/")
                  ("marmalade" . "http://marmalade-repo.org/packages/")))
  (add-to-list 'package-archives source))
(package-initialize)

;;packages to install if not installed
(defvar my-packages '(starter-kit-lisp
		      js2-mode
		      ;; scala-mode2
		      ensime
		      web-mode
		      clojure-mode
		      cider
		      jedi
		      rainbow-delimiters
                      f;; no idea what this is
                      color-theme-solarized
                      auto-complete
                      auto-complete-clang
                      cmake-mode
                      markdown-mode
                      rust-mode
                      haskell-mode
                      lua-mode
                      tidy
                      ansible
                      flycheck
                      flycheck-rust
                      tide
                      company
                      monokai-theme
                      dockerfile-mode
		      ))

;; refresh package contents
(when (not package-archive-contents)
  (package-refresh-contents))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))


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
    (lsp-rust lsp-mode web-mode tidy tide starter-kit-lisp rust-mode rainbow-delimiters monokai-theme markdown-mode lua-mode js2-mode jedi haskell-mode flycheck-rust ensime dockerfile-mode color-theme-solarized cmake-mode cider auto-complete-clang ansible))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
