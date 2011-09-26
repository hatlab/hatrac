; Definitions specify axiomatic properties
(in-package "ACL2") ; form importable "book"
(defun rac (xs)
  (if (consp (cdr xs)) ; more than one elem?
      (rac (cdr xs))   ; yes, more than one
      (car xs)))       ; no, one or fewer
(defun rdc (xs)
  (if (consp (cdr xs))               ; more than one elem?
      (cons (car xs) (rdc (cdr xs))) ; yes, more than one
      (cdr xs)))                     ; no, one or fewer
(defun snoc (x xs)
  (if (consp xs)                 ; xs not empty?
      (cons (car xs)             ; yes, not empty
            (snoc x (cdr xs)))
      (cons x xs)))              ; no, it's empty
