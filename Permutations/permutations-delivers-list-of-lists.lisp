;;;All proven - ARS 4/18/12;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(in-package "ACL2")
(include-book "doublecheck" :dir :teachpacks)
(include-book "permutations-defs")

(defproperty permutations-delivers-list-of-lists
  (size :value (random-between 1 5) 
     xs :value (random-list-of (random-integer) :size size)
        :where (true-listp xs))
  (true-list-listp (permutations xs)))
