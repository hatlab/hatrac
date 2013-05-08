; tests specify programmer expectations
(in-package "ACL2")
(include-book "doublecheck" :dir :teachpacks)
(include-book "rac-rdc-snoc-defs")

(defproperty rdc/snoc-identity
  (x  :value (random-integer)
   xs :value (random-list-of (random-integer)))
  (equal (rdc (snoc x xs))
         xs))
