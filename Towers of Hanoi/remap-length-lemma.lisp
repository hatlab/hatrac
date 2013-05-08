;(include-book "doublecheck" :dir :teachpacks)
(in-package "ACL2")
(include-book "arithmetic-3/top" :dir :system)
(include-book "append")
(include-book "towers-of-hanoi-defs")

(defrandom random-solution (n)
  (if (zp n)
      nil
      (cons (cons (random-data-size) (nth (random-between 0 2) *LABELS*))
            (random-solution (1- n)))))

(defproperty remap-length-lemma
  (sol  :value (random-solution (random-data-size))
   newa :value (random-char)
   newb :value (random-char)
   newc :value (random-char)   
        :where (solutionp sol))
  (equal (length sol) (length (remap sol newa newb newc))))