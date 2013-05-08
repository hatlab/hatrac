(in-package "ACL2")
(include-book "doublecheck" :dir :teachpacks)
(include-book "min-max-defs")

(defproperty maximum-is-in-list
  (xs :value (random-list-of (random-integer))
      :where (and (rational-listp xs) (consp xs)))
  (member-equal (maximum xs) xs))
