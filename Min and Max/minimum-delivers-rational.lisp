(in-package "ACL2")
(include-book "doublecheck" :dir :teachpacks)
(include-book "min-max-defs")

(defproperty minimum-delivers-rational
  (xs :value (random-list-of (random-integer))
      :where (and (rational-listp xs) (consp xs)))
  (rationalp (minimum xs)))
