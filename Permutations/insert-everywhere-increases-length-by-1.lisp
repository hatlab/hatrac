;;;;;;All proven - ARS 4/18/12;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(in-package "ACL2")
(include-book "doublecheck" :dir :teachpacks)
(include-book "permutations-defs")

(defproperty insert-everywhere-increases-length-by-1
  (xs :value (random-list-of (random-integer))
    x :value (random-integer)
      :where (true-listp xs))
  (= (length xs) (1- (length (insert-everywhere x xs)))))
