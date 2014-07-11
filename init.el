;; This is my emacs init file 
;; By Thomas Helmkay
;; C-M x to evaluate forms inside emacs
;; previous dead version was the .emacs file which is no longer used
;; configure package managment
(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/")
	     '("melpa" . "http://melpa.milkbox.net/packages/") )
(package-initialize)

;;packages to install if not installed
(defvar my-packages '(starter-kit-lisp))
;; refresh package contents
(when (not package-archive-contents)
  (package-refresh-contents))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))
