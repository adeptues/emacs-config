;;; Some misc config for emacs that does not fall under modes or init.el

(when window-system
  (setq frame-title-format '(buffer-file-name "%f" ("%b")))
  (tooltip-mode -1)
  (mouse-wheel-mode t)
  (blink-cursor-mode -1))

(defalias 'yes-or-no-p 'y-or-n-p)
(add-hook 'text-mode-hook 'turn-on-auto-fill)
(add-hook 'text-mode-hook 'turn-on-flyspell)

(setq inhibit-startup-message t
      uniquify-buffer-name-style 'forward)

(defun esk-local-comment-auto-fill ()
  (set (make-local-variable 'comment-auto-fill-only-comments) t)
  (auto-fill-mode t))

;; prog mode adds to all programming modes
(add-hook 'prog-mode-hook 'esk-local-comment-auto-fill)

(provide 'misc)
