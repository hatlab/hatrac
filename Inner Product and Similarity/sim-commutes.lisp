;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(in-package "ACL2")
(include-book "inner-product-and-similarity-defs")
(include-book "doublecheck" :dir :teachpacks)
(include-book "arithmetic-5/top" :dir :system)
(include-book "ip-commutes")

(defproperty sim-commutes
  (xs :value (random-list-of (random-integer))
   ys :value (random-list-of (random-integer))
      :where (and (consp xs) (consp ys)))
           (equal (sim xs ys) (sim ys xs)))

