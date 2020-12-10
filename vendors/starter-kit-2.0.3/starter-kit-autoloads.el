;;; starter-kit-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "starter-kit" "starter-kit.el" (0 0 0 0))
;;; Generated autoloads from starter-kit.el

(dolist (mode '(menu-bar-mode tool-bar-mode scroll-bar-mode)) (when (fboundp mode) (funcall mode -1)))

(mapc 'require '(uniquify starter-kit-defuns starter-kit-misc))

(setq esk-system-config (concat user-emacs-directory system-name ".el") esk-user-config (concat user-emacs-directory user-login-name ".el") esk-user-dir (concat user-emacs-directory user-login-name))

(add-to-list 'load-path esk-user-dir)

(setq smex-save-file (concat user-emacs-directory ".smex-items"))

(smex-initialize)

(global-set-key (kbd "M-x") 'smex)

(when (file-exists-p esk-system-config) (load esk-system-config))

(when (file-exists-p esk-user-config) (load esk-user-config))

(when (file-exists-p esk-user-dir) (mapc 'load (directory-files esk-user-dir nil "^[^#].*el$")))

;;;***

;;;### (autoloads nil "starter-kit-defuns" "starter-kit-defuns.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from starter-kit-defuns.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "starter-kit-defuns" '("vc-git-annotate-command" "esk-")))

;;;***

;;;### (autoloads nil "starter-kit-misc" "starter-kit-misc.el" (0
;;;;;;  0 0 0))
;;; Generated autoloads from starter-kit-misc.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "starter-kit-misc" '("auto-tail-revert-mode" "yes-or-no-p")))

;;;***

;;;### (autoloads nil nil ("starter-kit-pkg.el") (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; starter-kit-autoloads.el ends here
