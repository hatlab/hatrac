;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(in-package "ACL2")
(include-book "inner-product-and-similarity-defs")
(include-book "doublecheck" :dir :teachpacks)
(include-book "arithmetic-5/top" :dir :system)

(defproperty scaling-distributes-over-ip
  (xs :value (random-list-of (random-integer))
   ys :value (random-list-of (random-integer))
   s  :value (random-integer)
      :where (and (rational-listp xs) (rational-listp ys) (consp xs) 
                  (consp ys) (rationalp s)))
  (equal (inner-product (scale s xs) ys)
         (* s (inner-product xs ys))))

