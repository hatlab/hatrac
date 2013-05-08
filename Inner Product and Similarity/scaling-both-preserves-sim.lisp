;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(in-package "ACL2")
(include-book "inner-product-and-similarity-defs")
(include-book "positive-scaling-preserves-sim")
(include-book "negative-scaling-preserves-sim")
;(include-book "doublecheck" :dir :teachpacks)
;(include-book "arithmetic-5/top" :dir :system)

(defproperty scaling-both-preserves-sim
  (xs :value (random-list-of (random-rational))
   ys :value (random-list-of (random-rational))
   s  :value (random-integer)
      :where (and (rational-listp xs) (rational-listp ys) (consp xs) 
                  (consp ys) (rationalp s) (not (equal s 0))))
        (equal (sim xs ys)
                  (sim (scale s xs) (scale s ys)))
  :hints (("Goal" :use (positive-scaling-preserves-sim 
                        negative-scaling-preserves-sim))))


