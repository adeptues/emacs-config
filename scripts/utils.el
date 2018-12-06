;;; Package --- Summary
;; Elisp utils and extra code to make things easy
;; Thomas Helmkay

;;; Commentary:
;; Custom code

;; useful for flattening text in scratch reduces text to one line

;;; Code:
(defun remove-newlines-in-region ()
  "Remove all newlines in the region."
  (interactive)
  (save-restriction
    (narrow-to-region (point) (mark))
    (goto-char (point-min))
    (while (search-forward "\n" nil t) (replace-match "" nil t))))

;; Xml parsing functions
(defun has-attr (key node)
  "KEY: attribute key, NODE: xml node.
Check if a NODE has an attr defined by KEY for use with nodes produced by libxml."
  (if (seq-filter (lambda (attr) (string= (car attr) key)) (nth 1 node))
      t
    nil)
  )

(defun parse-attrs (attrs)
  "Recursiveley parse the list of ATTRS and drop th:text attribute."
  (cond
   ;;first do agin test stop condition
   ((not attrs) nil)

   ;; second test if not th:text define what you want to keep
   ((not (string= (car (car attrs)) "th:text"))
    (cons (car attrs) (parse-attrs (cdr attrs))))

   ;;3rd conditon continue anyway
   (t (parse-attrs (cdr attrs)))
   )
  )

(defun bf-pretty-print-xml-region (begin end)
  "Pretty format XML markup in region. You need to have nxml-mode
http://www.emacswiki.org/cgi-bin/wiki/NxmlMode installed to do
this. The function inserts linebreaks to separate tags that have
nothing but whitespace between them. It then indents the markup
by using nxml's indentation rules."
  (interactive "r")
  (save-excursion
    (nxml-mode)
    (goto-char begin)
    (while (search-forward-regexp "\>[ \\t]*\<" nil t) 
      (backward-char) (insert "\n") (setq end (1+ end)))
    (indent-region begin end))
  (message "Ah, much better!"))

;; TODO move keybindings to init.el or modes.el this file is for util functions
;; only not configurations

;; bind to f8
(global-set-key [f8] 'remove-newlines-in-region)

(provide 'utils)
;;; utils.el ends here
