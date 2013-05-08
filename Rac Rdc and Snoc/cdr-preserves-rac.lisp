; tests specify programmer expectations
(in-package "ACL2")
(include-book "doublecheck" :dir :teachpacks)
(include-book "rac-rdc-snoc-defs")

(defproperty cdr-preserves-rac
  (xs :value (random-list-of (random-integer))
      :where (consp (cdr xs))) ; more than one elem
  (equal (rac xs) (rac (cdr xs))))
