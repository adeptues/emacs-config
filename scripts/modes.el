;; Elisp file for configuring emacs modes and packages
;; Thomas Helmkay

;; Mode Configuration

(require 'smex)
;; For some reason the starter kit stoped setting up smex for M-x auto
;; comlete
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; js2-mode configuration for javscript
;;(require 'js2-mode)
;;(require 'ac-js2-mode)
;;(add-to-list 'auto-mode-alist (cons (rx ".js" eos) 'js2-mode))
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
(add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)
;;(add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)

;; Python mode configuration
;; The following packages should be installed via pip for this to work best
;; jedi,pyls,rope autopep8,pyflakes
;; modes required for python configuration
(require 'jedi)
(require 'lsp-mode)
;; jedi provides auto completion in python
(add-hook 'python-mode-hook 'jedi:setup)
(when (>= emacs-major-version 26)
  (add-hook 'python-mode-hook #'lsp))

;; end python configuration

;;flycheck config
(require 'flycheck)
;;(add-hook 'after-init-hook #'global-flycheck-mode)

;; (add-hook 'c++-mode-hook ;;combine hooks
;;           (lambda () (setq flycheck-clang-include-path
;;                       (list "/usr/include/wx-2.8/"))))
;; (add-hook 'c++-mode-hook
;;           (lambda () (setq flycheck-clang-language-standard "c++11")))

;; ;; Auto-complete configuration
;; (require 'auto-complete)
;; (require 'auto-complete-config)
;; (ac-config-default)
;; ;;TODO replace auto-complete with company mode and company-quickhelp
;; (require 'auto-complete-clang)
;; (add-hook 'c++-mode-hook 'ac-complete-clang)

;; (require 'cmake-mode)

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
;;TODO remove live down as its not really needed nor useful and does to much for
;;normal dev like spinning up  aserver 
(require 'livedown)

;; Language server protocol config for languages that support it not all
;; languages need lsp-mode as some have better bespoke tooling. lsp-mnode is for
;; when theres existing tooling for other ides that support lsp protocol for
;; better integration
;;(require 'lsp-mode)


;; Rust mode settings
;; (require 'rust-mode)
;; (autoload 'rust-mode "rust-mode" nil t)
;; (add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))
;; Rustic is a fork of rust mode with enhanced dev env features only
;; that is required
;;(require 'rustic)
;;(add-hook 'rustic-hook (lambda () (local-set-key (kbd "M-Enter"))))
;;(use-package rustic)
;; End rust config


;; Haskell mode config
(require 'haskell-mode)
;; lua config
(require 'lua-mode)

;; HTML Tidy config
;;TODO this needs reconfiguring and support adding for custom html tags ala webcomponents
(autoload 'tidy-buffer "tidy" "Run Tidy HTML parser on current buffer" t)
(autoload 'tidy-parse-config-file "tidy" "Parse the `tidy-config-file'" t)
(autoload 'tidy-save-settings "tidy" "Save settings to `tidy-config-file'" t)
(autoload 'tidy-build-menu  "tidy" "Install an options menu for HTML Tidy." t)

;; Sets up tidy for html mode with a hook
(defun my-html-mode-hook () "Customize my html-mode."
  (tidy-build-menu html-mode-map)
  (local-set-key [(control c) (control c)] 'tidy-buffer)
  (setq sgml-validate-command "tidy"))
(require 'tidy)

(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
(require 'ansible)
(add-hook 'yaml-mode-hook '(lambda () (ansible 1)))

;; Rust config
;;(add-hook 'flycheck-mode-hook #'flycheck-rust-setup)

;;Sets the auto line wrap distance
(setq-default fill-column 80)

;; Tide typescript configuration
(require 'tide)
(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)

(add-hook 'typescript-mode-hook #'setup-tide-mode)
;; Set keybind M - Enter to tide-fix command
(add-hook 'typescript-mode-hook
          (lambda ()
            (local-set-key (kbd "M-RET") `tide-fix)))
;; Set keybind CTRL-. to find next reference
(add-hook 'typescript-mode-hook
          (lambda ()
            (local-set-key (kbd "C-.") `tide-references)))
;; End typescript dev config

;; add typescript tsx formatting to webmode using tide
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "tsx" (file-name-extension buffer-file-name))
              (setup-tide-mode))))
;; enable typescript-tslint checker
(flycheck-add-mode 'typescript-tslint 'web-mode)

;; Configure find-file-in-project which is included by starterkitlisp package
(setq ffip-use-rust-fd t)
(global-set-key (kbd "C-x C-S-F") 'find-file-in-project)


(provide 'modes)
;;; modes.el ends here
