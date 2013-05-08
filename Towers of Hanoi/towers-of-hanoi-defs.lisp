;(include-book "doublecheck" :dir :teachpacks)
(in-package "ACL2")
(include-book "arithmetic-3/top" :dir :system)
(include-book "append")

(defun remap (solution newa newb newc)
  (if (consp solution)
      (case (cdar solution)
        (#\a (cons (cons (caar solution) newa) 
                   (remap (cdr solution) newa newb newc)))
        (#\b (cons (cons (caar solution) newb) 
                   (remap (cdr solution) newa newb newc)))
        (#\c (cons (cons (caar solution) newc) 
                   (remap (cdr solution) newa newb newc))))
      nil))
        
(defun towers-of-hanoi (n)
  (if (zp n)
      nil
      (let ((towers (towers-of-hanoi (1- n))))
        (append (remap towers #\a #\c #\b)
                (append (list (cons n #\c))
                        (remap towers #\b #\a #\c))))))

(defconst *LABELS* '(#\a #\b #\c))

(defun solutionp (sol)
  (or (null sol)
      (and (natp (caar sol)) (member-equal (cdar sol) *LABELS*)
           (solutionp (cdr sol)))))

