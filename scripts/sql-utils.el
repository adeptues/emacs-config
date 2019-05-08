;; Get the list of permissions that begin with ROLE_ from the class string
;; Get the list of permissions that begin with ROLE_ from the class string

;; Usefull for debugging pretty prints objects debug function
(defun pprint (form &optional output-stream)
  (princ (with-temp-buffer
           (cl-prettyprint form)
           (buffer-string))
         output-stream))
;; Parses a string for the right hand side of a static assignment in java and
;; extrracts anthing with ROLE_ on the right hand side on an = in a new line
(defun sql-utils-parse-permissions (input-str)
  (let* ((new-lines (mapcar 'sql-utils-clean-up (split-string input-str "\n")))
         (splited (mapcan '(lambda (x) (split-string x "=")) new-lines)))
    (remove-if-not '(lambda (x) (string-prefix-p "'ROLE_" x)) splited)
    ))

(defun sql-utils-convert (prefix input-str)
  (let* (
         (permissions (sql-utils-parse-permissions input-str))
         (data (mapcar '(lambda (x) (cons (setq count (1+ count)) x)) permissions ))
         (prefixes (make-list (length data) prefix)))
    (mapcar* #'concat prefixes (sql-utils-normalise data) )

    ))
;; Cleans up a string removes the ; and replaces double quotes with single
;; quotes
(defun sql-utils-clean-up (x)
  (when x
    (replace-regexp-in-string  "\"" "'" (replace-regexp-in-string ";" "" x))  ))

;; Recursive keep function to 
(defun sql-utils-normalise (items)
  "Normalise a list of items that are dotted pairs into a string such as (1 . ROLE_PEM)
 into (1,'role_pem')"
  (let ((head (car items)))
    (if (not items)
        nil
      (cons (sql-utils-pooface head) (sql-utils-normalise (cdr items)))
      ))
  )
;;TODO rename this, converts a dotted pair into a string
(defun sql-utils-pooface (head)
  (concat (concat "(" (number-to-string (car head))) (concat "," (concat (cdr head) ");\n"))))

;; Our primary entry function for generating sql from a class, reads all the
;; nessecary user input
(defun sql-utils-generate-region ()
  (interactive)
  (save-restriction)
  (setq count (string-to-number (read-string "Counter: ") 10));; this is used in a later function as a buffer local var
  (if (use-region-p)
      (let ((regionp (buffer-substring-no-properties (point) (mark)))
            (prefix (read-string "SQL Prefix:")))
        (when prefix
          (switch-to-buffer (make-temp-name "SQLDUMP"))
          (dolist (elem (sql-utils-convert prefix regionp))
            (insert  elem))
          )))
)


(global-set-key [f9] 'sql-utils-generate-region)
