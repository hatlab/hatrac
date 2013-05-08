(in-package "ACL2")

; ds = list of delimiters (no constraints on what a delimiter is)
; xs = list of values (no constraints on values)
; (split-at-delimiter ds xs) = list of two elements
;   1 longest prefix of xs containing no elements from ds
;   2 rest of xs
(defun split-at-delimiter (ds xs)
  (if (or (endp xs) (member-equal (car xs) ds))
      (list nil xs)
      (let* ((cdr-split (split-at-delimiter ds (cdr xs))))
        (list (cons (car xs) (car cdr-split))
              (cadr cdr-split)))))

; ps = list of signals to pass by (no constraints on signals)
; xs = list of signals (no constraints on signals)
; (span ps xs) = list of two elements
;  1 longest prefix of xs containing only signals from ps
;  2 rest of xs
(defun span (ps xs)
  (if (or (endp xs) (not (member-equal (car xs) ps)))
      (list nil xs)
      (let* ((cdr-span (span ps (cdr xs))))
        (list (cons (car xs) (car cdr-span))
              (cadr cdr-span)))))

; ps = list of values (no constraints on values)
; xs = list of values (no constraints on values)
; (splitoff-prefix ps xs) = list of three elements
;  1 longest prefix of ps that is also a prefix of xs
;  2 rest of ps
;  3 rest of xs beyond prefix that matches element 1
(defun splitoff-prefix (ps xs)
  (if (or (endp ps)
          (endp xs)
          (not (equal (car xs) (car ps))))
      (list nil ps xs)
      (let* ((3way (splitoff-prefix (cdr ps) (cdr xs))))
        (list (cons (car ps) (car 3way))
              (cadr 3way)
              (caddr 3way)))))

; tok = token (list of values, no constraints on values)
; xs = list of values (no constraints on values)
; (split-on-token tok xs) = list of three elements
;  1 prefix of xs: portion before 1st contiguous sublist matching tok
;                  (or xs, if there is no match for tok in xs)
;  2 tok if tok matches a contiguous sublist of xs, otherwise nil
;  3 suffix of xs: portion after 1st contiguous sublist matching tok
;                  (or nil, if there is no match for tok in xs)
(defun split-on-token (tok xs)
  (if (endp xs)
      (list nil nil nil)
      (let* ((3way (splitoff-prefix tok xs)))
        (if (endp (cadr 3way))
            (list nil tok (caddr 3way))
            (let* ((cdr-split (split-on-token tok (cdr xs))))
              (list (cons (car xs) (car cdr-split))
                    (cadr cdr-split)
                    (caddr cdr-split)))))))
