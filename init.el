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
                      monokai-theme;;sublime esque theme
                      dockerfile-mode
		      lsp-mode;;provides language server protocol
		      company-lsp
		      lsp-ui
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
 '(compilation-message-face (quote default))
 '(custom-safe-themes
   (quote
    ("12b204c8fcce23885ce58e1031a137c5a14461c6c7e1db81998222f8908006af" default)))
 '(fci-rule-color "#3C3D37")
 '(highlight-changes-colors (quote ("#FD5FF0" "#AE81FF")))
 '(highlight-tail-colors
   (quote
    (("#3C3D37" . 0)
     ("#679A01" . 20)
     ("#4BBEAE" . 30)
     ("#1DB4D0" . 50)
     ("#9A8F21" . 60)
     ("#A75B00" . 70)
     ("#F309DF" . 85)
     ("#3C3D37" . 100))))
 '(livedown:autostart nil)
 '(livedown:open t)
 '(livedown:port 1337)
 '(magit-diff-use-overlays nil)
 '(package-selected-packages
   (quote
    (lsp-rust lsp-mode web-mode tidy tide starter-kit-lisp rust-mode rainbow-delimiters monokai-theme markdown-mode lua-mode js2-mode jedi haskell-mode flycheck-rust ensime dockerfile-mode color-theme-solarized cmake-mode cider auto-complete-clang ansible)))
 '(pos-tip-background-color "#FFFACE")
 '(pos-tip-foreground-color "#272822")
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#F92672")
     (40 . "#CF4F1F")
     (60 . "#C26C0F")
     (80 . "#E6DB74")
     (100 . "#AB8C00")
     (120 . "#A18F00")
     (140 . "#989200")
     (160 . "#8E9500")
     (180 . "#A6E22E")
     (200 . "#729A1E")
     (220 . "#609C3C")
     (240 . "#4E9D5B")
     (260 . "#3C9F79")
     (280 . "#A1EFE4")
     (300 . "#299BA6")
     (320 . "#2896B5")
     (340 . "#2790C3")
     (360 . "#66D9EF"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (unspecified "#272822" "#3C3D37" "#F70057" "#F92672" "#86C30D" "#A6E22E" "#BEB244" "#E6DB74" "#40CAE4" "#66D9EF" "#FB35EA" "#FD5FF0" "#74DBCD" "#A1EFE4" "#F8F8F2" "#F8F8F0")))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
