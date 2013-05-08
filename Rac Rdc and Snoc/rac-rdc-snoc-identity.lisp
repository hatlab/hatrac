; tests specify programmer expectations
(in-package "ACL2")
(include-book "doublecheck" :dir :teachpacks)
(include-book "rac-rdc-snoc-defs")

(defproperty rac/rdc/snoc-identity
  (xs :value (random-list-of (random-integer))
      :where (consp xs))
  (equal (snoc (rac xs) (rdc xs))
         xs))
