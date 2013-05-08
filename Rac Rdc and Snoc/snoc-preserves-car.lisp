; tests specify programmer expectations
(in-package "ACL2")
(include-book "doublecheck" :dir :teachpacks)
(include-book "rac-rdc-snoc-defs")

(defproperty snoc-preserves-car
  (xs :value (random-list-of (random-integer))
   x  :value (random-integer)
      :where (consp xs))
  (equal (car xs) (car (snoc x xs))))
