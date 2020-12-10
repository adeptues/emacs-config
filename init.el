;; This is my emacs init file 
;; By Thomas Helmkay
;; C-M x to evaluate forms inside emacs
;; previous dead version was the .emacs file which is no longer used

;; TODO Sort the issues out with find-file-in-project
;; TODO enable comment wrapping via auto fil

;; fix some issues with ido-ubiquitous before we load the it from packages needs
;; to be at the top for some reason
(defvar ido-cur-item nil)
(defvar ido-default-item nil)
(defvar ido-cur-list nil)

;; configure package managment
(require 'package)
(dolist (source '(("melpa" . "http://melpa.milkbox.net/packages/")
;;                  ("marmalade" . "http://marmalade-repo.org/packages/")
		  ("melpa-stable" . "https://stable.melpa.org/packages/")
		  ))
  (add-to-list 'package-archives source))
(package-initialize)

;;packages to install if not installed
(defvar my-packages '(;;starter-kit-lisp
		      ;; js2-mode
		      smex
		      web-mode
		      clojure-mode
		      cider
		      jedi
		      rainbow-delimiters
                      f;; no idea what this is
;;                      auto-complete
;;                      auto-complete-clang
                      cmake-mode
                      markdown-mode
;;                      rust-mode
                      haskell-mode
                      lua-mode
                      ansible
                      flycheck
;;                      flycheck-rust
                      tide
                      company
                      monokai-theme;;sublime esque theme
                      dockerfile-mode
		      paredit
;;                      rustic
		      ))
;; Pinned packages, packages we want to install from a specific package archive
;; usually stable rather than the melpa snapshot which has more packages but can
;; be unstable somtimes
(setq package-pinned-packages '((flycheck . "melpa-stable")
                                (tide . "melpa-stable")))


;; support for lsp-mode when emacs > 26
(when (>= emacs-major-version 26)
  (setq my-packages (append my-packages (list 'lsp-mode 'company-lsp 'lsp-ui))))

;; refresh package contents
(when (not package-archive-contents)
  (package-refresh-contents))


;; fetch and install the packages
(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;; For adding libs that we could not fetch from melpa in the vendors directory
;;(add-to-list 'load-path (expand-file-name "~/.emacs.d/vendors/flycheck-0.19"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/vendors/emacs-livedown"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/vendors/better-defaults"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/vendors/idle-highlight"))

;; TODO the behaviour of find-file-in-project has change with emacs27 and rust
;; fd i dont like it need to fix it
;;(add-to-list 'load-path (expand-file-name "~/.emacs.d/vendors/find-file-in-project"))


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
		       "tidy.el"
                       "modes.el"
		       "dom.el"
                       "sql-utils.el"
                       "misc.el"))

;; tell custom-set-variables to put anything we configure with customize-*
;; in the custom.el file
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; No idea what this is below here its auto generated


