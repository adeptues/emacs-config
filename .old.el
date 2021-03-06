;; This is my emacs config file
;; By Thomas Helmkay
;; C-M x to evaluate forms inside emacs
;; configure package archives for package management
(require 'package)
(add-to-list 'package-archives
;;             '("marmalade" . "http://marmalade-repo.org/packages/")
	     '("melpa" . "http://melpa.milkbox.net/packages/") )
(package-initialize)

;;packages to install if not installed
(defvar my-packages '(starter-kit-lisp
		      js2-mode
                      auto-complete
                      ac-js2
		      scala-mode2
		      sr-speedbar ;;file browser sidebar
		      ensime
		      web-mode
		      clojure-mode
		      cider
		      jedi
		      rainbow-delimiters
                      flycheck
                      auto-complete-clang))

;;only connects to melp once per boot, so as to avoid bad networks and
;;hanging when emacs starts up
;;TODO crude elisp tidy up
(when (not (file-exists-p "/tmp/melpaupdate"))
  (package-refresh-contents))
(when (not (file-exists-p "/tmp/melpaupdate"))
  (write-region "" nil "/tmp/melpaupdate"))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))
;; Emacs config section

;; set emacs theme wombat is a dark theme
(load-theme 'solarized-dark t)

;; set cursor color color for wombat theme compatbility
;;(set-cursor-color "#e0ffff")

;; Mode configuration

;;auto complete configuration THIS IS A FUCKING MESS
(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(require 'auto-complete)
(add-to-list 'ac-modes 'c++-mode)
(require auto-complete-clang)

;; js2-mode configuration for javscript
(require 'js2-mode)
(add-to-list 'auto-mode-alist (cons (rx ".js" eos) 'js2-mode))
;; auto completion for javascript
(add-hook 'js2-mode-hook 'ac-js2-mode)
(setq ac-js2-evaluate-calls t)

;;speedbar configfor sr-speedbar
 (require 'sr-speedbar)
 (global-set-key (kbd "s-s") 'sr-speedbar-toggle)

;; Web-mode configuration
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[gj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.scala.html\\'" . web-mode))

;;force engine associations for web mode non default
(setq web-mode-engines-alist
      '(("razor"    . "\\.scala.html\\'"))
)

;; Rainbow-delimiters config
(require 'rainbow-delimiters)
(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)

;; mail configuration settings for rmail
(require 'rmail)
 (setenv "mail.hssnet.com" "pop3server")
 (setq rmail-primary-inbox-list '("po:thomas.helmkay")
       rmail-pop-password-required t)

;; Python jedi hook auto completion in python
(require 'jedi)
(add-hook 'python-mode-hook 'jedi:setup)

;;flycheck config
(add-hook 'after-init-hook #'global-flycheck-mode)

;;random autogenshit
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" "1e7e097ec8cb1f8c3a912d7e1e0331caeed49fef6cff220be63bd2a6ba4cc365" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
