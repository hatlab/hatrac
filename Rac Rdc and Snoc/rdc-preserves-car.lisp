; tests specify programmer expectations
(in-package "ACL2")
(include-book "doublecheck" :dir :teachpacks)
(include-book "rac-rdc-snoc-defs")

(defproperty rdc-preserves-car
  (xs :value (random-list-of (random-integer))
      :where (consp (cdr xs)))
  (equal (car xs) (car (rdc xs))))
