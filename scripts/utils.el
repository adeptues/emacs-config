;; Elisp utils and extra code to make things easy
;; Thomas Helmkay

;; Custom code

;; useful for flattening text in scratch reduces text to one line
(defun remove-newlines-in-region ()
  "Removes all newlines in the region."
  (interactive)
  (save-restriction
    (narrow-to-region (point) (mark))
    (goto-char (point-min))
    (while (search-forward "\n" nil t) (replace-match "" nil t))))

;; bind to f8
(global-set-key [f8] 'remove-newlines-in-region)

(provide 'utils)
;;; utils.el ends here

