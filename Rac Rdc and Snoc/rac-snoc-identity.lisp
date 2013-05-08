; tests specify programmer expectations
(in-package "ACL2")
(include-book "doublecheck" :dir :teachpacks)
(include-book "rac-rdc-snoc-defs")

(defproperty rac/snoc-identity
  (x  :value (random-integer)
   xs :value (random-list-of (random-integer)))
  (equal (rac (snoc x xs))
         x))
