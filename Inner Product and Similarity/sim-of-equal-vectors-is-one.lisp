;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(in-package "ACL2")
(include-book "inner-product-and-similarity-defs")
(include-book "doublecheck" :dir :teachpacks)
(include-book "arithmetic-5/top" :dir :system)

(defproperty sim-of-equal-vectors-is-one
  (xs :value (random-list-of (random-integer))
      :where (rational-listp xs))
  (= (sim xs xs) 1))

