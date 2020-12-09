;;; Package --- Summary
;; Elisp utils and extra code to make things easy
;; Thomas Helmkay

;;; Commentary:
;; Custom code

;; useful for flattening text in scratch reduces text to one line

;;; Code:

(defun make-csv ()
  "make a csv of a bunch of lines"
  (interactive)
  (save-restriction
    (narrow-to-region (point) (mark))
    (goto-char (point-min))
    (while (search-forward "\n" nil t) (replace-match "," nil t))))

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


;; ASCII function utils for finding non ascii characters in a large block of
;; text or file

(defun find-first-non-ascii-char ()
  "Find the first non-ascii character from point onwards."
  (interactive)
  (let (point)
    (save-excursion
      (setq point
            (catch 'non-ascii
              (while (not (eobp))
                (or (eq (char-charset (following-char))
                        'ascii)
                    (throw 'non-ascii (point)))
                (forward-char 1)))))
    (if point
        (goto-char point)
      (message "No non-ascii characters."))))

(defun find-next-unsafe-char (&optional coding-system)
  "Find the next character in the buffer that cannot be encoded by
coding-system. If coding-system is unspecified, default to the coding
system that would be used to save this buffer. With prefix argument,
prompt the user for a coding system."
  (interactive "Zcoding-system: ")
  (if (stringp coding-system) (setq coding-system (intern coding-system)))
  (if coding-system nil
    (setq coding-system
          (or save-buffer-coding-system buffer-file-coding-system)))
  (let ((found nil) (char nil) (csets nil) (safe nil))
    (setq safe (coding-system-get coding-system 'safe-chars))
    ;; some systems merely specify the charsets as ones they can encode:
    (setq csets (coding-system-get coding-system 'safe-charsets))
    (save-excursion
      ;;(message "zoom to <")
      (let ((end  (point-max))
            (here (point    ))
            (char  nil))
        (while (and (< here end) (not found))
          (setq char (char-after here))
          (if (or (eq safe t)
                  (< char ?\177)
                  (and safe  (aref safe char))
                  (and csets (memq (char-charset char) csets)))
              nil ;; safe char, noop
            (setq found (cons here char)))
          (setq here (1+ here))) ))
    (and found (goto-char (1+ (car found))))
    found))

(defun find-unsafe-char-delete ()
  "Find the next unsafe character for the buffer encoding and delete it, generally this is for
   removing non ascii characters from a large file"
  (interactive)
  (save-excursion
    (let ((counter 0) )
      (while (find-next-unsafe-char)
        (backward-kill-word 1)
        (setq counter (+ counter 1)))
      (message "Deleted %d" counter)
      ))
  )



;; TODO move keybindings to init.el or modes.el this file is for util functions
;; only not configurations

;; bind to f8
(global-set-key [f8] 'remove-newlines-in-region)

(provide 'utils)
;;; utils.el ends here
