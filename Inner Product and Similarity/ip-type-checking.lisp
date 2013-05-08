;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(in-package "ACL2")
(include-book "inner-product-and-similarity-defs")
(include-book "doublecheck" :dir :teachpacks)
(include-book "arithmetic-5/top" :dir :system)

(defproperty ip-type-checking
  (xs :value (random-list-of (random-integer))
   ys :value (random-list-of (random-integer))
      :where (and (consp xs) (consp ys)))
  (rationalp (inner-product xs ys)))

