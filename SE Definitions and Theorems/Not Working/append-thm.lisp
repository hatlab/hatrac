(in-package "ACL2")
(include-book "doublecheck" :dir :teachpacks)

(defproperty append-is-associative :repeat 100
  (xs :value (random-list-of (random-symbol))
   ys :value (random-list-of (random-symbol))
   zs :value (random-list-of (random-symbol)))
  (equal (append xs (append ys zs))
         (append (append xs ys) zs)))