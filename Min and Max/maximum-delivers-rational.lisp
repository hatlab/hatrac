(in-package "ACL2")
(include-book "doublecheck" :dir :teachpacks)
(include-book "min-max-defs")

(defproperty maximum-delivers-rational
  (xs :value (random-list-of (random-integer))
      :where (and (rational-listp xs) (consp xs)))
  (rationalp (maximum xs)))
