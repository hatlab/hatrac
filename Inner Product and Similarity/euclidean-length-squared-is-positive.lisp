;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(in-package "ACL2")
(include-book "inner-product-and-similarity-defs")
(include-book "doublecheck" :dir :teachpacks)

(defproperty euclidean-length-squared-is-positive
  (xs :value (random-list-of (random-integer))
      :where (and (rational-listp xs) (consp xs)))
  (>= (inner-product xs xs) 0))
