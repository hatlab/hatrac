;;;All proven - ARS 4/18/12;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(in-package "ACL2")
(include-book "doublecheck" :dir :teachpacks)
(include-book "permutations-defs")

(defproperty insert-everywhere-delivers-permutations
  (xs :value (random-list-of (random-integer))
    x :value (random-integer)
      :where (true-listp xs))
  (permutation-listp (cons x xs) (insert-everywhere x xs)))
