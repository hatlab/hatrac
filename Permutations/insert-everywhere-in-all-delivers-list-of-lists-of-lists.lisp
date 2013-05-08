;;;;;;All proven - ARS 4/18/12;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(in-package "ACL2")
(include-book "doublecheck" :dir :teachpacks)
(include-book "permutations-defs")

(defproperty insert-everywhere-in-all-delivers-list-of-lists-of-lists
  (xss :value (random-list-of (random-list-of (random-integer)))
     x :value (random-integer)
       :where (true-list-listp xss))
  (true-list-list-listp (insert-everywhere-in-all x xss)))
