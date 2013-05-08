(in-package "ACL2")
(include-book "doublecheck" :dir :teachpacks)
(include-book "min-max-defs")

(defproperty minimum-is-in-list
  (xs :value (random-list-of (random-integer))
      :where (and (rational-listp xs) (consp xs)))
  (member-equal (minimum xs) xs))
