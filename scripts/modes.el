;; Elisp file for configuring emacs modes and packages
;; Thomas Helmkay

;; Mode Configuration

;; js2-mode configuration for javscript
(require 'js2-mode)
;;(require 'ac-js2-mode)
(add-to-list 'auto-mode-alist (cons (rx ".js" eos) 'js2-mode))
;; auto completion for javascript
;;(add-hook 'js2-mode-hook 'ac-js2-mode)
;;(setq ac-js2-evaluate-calls t)

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

;; Python jedi hook auto completion in python
(require 'jedi)
(add-hook 'python-mode-hook 'jedi:setup)

;;flycheck config
(require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)
(add-hook 'c++-mode-hook;;combine hooks
          (lambda () (setq flycheck-clang-include-path
                      (list "/usr/include/wx-2.8/"))))
(add-hook 'c++-mode-hook
          (lambda () (setq flycheck-clang-language-standard "c++11")))

;; Auto-complete configuration
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)

(require 'auto-complete-clang)
(add-hook 'c++-mode-hook 'ac-complete-clang)

(require 'cmake-mode)

(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(require 'markdown-mode)

;; Configure markdown previewer
(custom-set-variables
 '(livedown:autostart nil) ; automatically open preview when opening markdown files 
 '(livedown:open t)        ; automatically open the browser window
 '(livedown:port 1337))    ; port for livedown server
(require 'livedown)

(provide 'modes)
;;; modes.el ends here
