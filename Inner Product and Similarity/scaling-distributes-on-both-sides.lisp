;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(in-package "ACL2")
(include-book "inner-product-and-similarity-defs")
(include-book "doublecheck" :dir :teachpacks)
(include-book "arithmetic-5/top" :dir :system)

(defproperty scaling-distributes-on-both-sides
  (xs :value (random-list-of (random-integer))
   ys :value (random-list-of (random-integer))
   s1 :value (random-integer)
   s2 :value (random-integer)
      :where (and (rational-listp xs) (rational-listp ys) (consp xs) 
                  (consp ys) (rationalp s1) (rationalp s2)))
  (equal (inner-product (scale s1 xs) (scale s2 ys))
         (* s1 s2 (inner-product xs ys))))
