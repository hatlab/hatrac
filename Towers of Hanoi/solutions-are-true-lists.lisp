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

(defproperty solutions-are-true-lists
  (sol :value (random-solution (random-data-size))
       :where (solutionp sol))
  (true-listp sol))