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
		      scala-mode2
		      ensime
		      web-mode
		      clojure-mode
		      cider
		      jedi
		      rainbow-delimiters
                      f
;;                      flycheck dumped cos of homosexuality
                      color-theme-solarized
                      auto-complete
                      auto-complete-clang
                      cmake-mode
                      markdown-mode))

;; refresh package contents
(when (not package-archive-contents)
  (package-refresh-contents))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

(add-to-list 'load-path (expand-file-name "~/.emacs.d/vendors/flycheck-0.19"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/vendors/emacs-livedown"))


;; set emacs theme wombat is a dark theme
(load-theme 'solarized-dark t)

;; File loading functions

(defun load-user-files (files)
  (dolist (x files)
    (setq path (concat "~/.emacs.d/scripts/" x))
    (print path)
    (load-file path)))

;;(load-user-file "modes.el")
(load-user-files (list "utils.el"
                       "modes.el"))
