;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(in-package "ACL2")
(include-book "inner-product-and-similarity-defs")
(include-book "scaling-distributes-on-both-sides")
(include-book "scaling-distributes-over-ip")
;(include-book "doublecheck" :dir :teachpacks)
;(include-book "arithmetic-5/top" :dir :system)

(defproperty positive-scaling-preserves-sim
  (xs :value (random-list-of (random-rational))
   ys :value (random-list-of (random-rational))
   s  :value (random-integer)
      :where (and (rational-listp xs) (rational-listp ys) (consp xs) 
                  (consp ys) (rationalp s) (< 0 s)))
        (equal (sim xs ys)
                  (sim (scale s xs) ys)))


