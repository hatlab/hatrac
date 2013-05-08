;;;All proven - ARS 4/18/12;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(in-package "ACL2")
(include-book "doublecheck" :dir :teachpacks)
(include-book "permutations-defs")

(defproperty x-is-in-every-list-of-insert-everywhere
  (xs :value (random-list-of (random-integer))
    x :value (random-integer)
      :where (true-listp xs))
  (member-allp x (insert-everywhere x xs)))
