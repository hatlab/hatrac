;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(in-package "ACL2")
(include-book "inner-product-and-similarity-defs")
(include-book "doublecheck" :dir :teachpacks)
(include-book "arithmetic-5/top" :dir :system)

(defproperty neg-times-neg-is-pos
  (x :value (random-rational)
   y :value (random-rational)
     :where (and (< x 0) (< y 0) (rationalp x) (rationalp y)))
  (< 0 (* x y)))
