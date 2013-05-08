;;; All theorems in this file are proven - ARS 04/11/12
(in-package "ACL2")
(include-book "doublecheck" :dir :teachpacks)
(include-book "arithmetic-5/top" :dir :system)
(include-book "linear-regression-defs")

(defproperty vector*vector-works
  ( n :value (random-data-size)
   xs :value (random-list-of (random-integer) :size (1+ n))
   ys :value (random-list-of (random-integer) :size (1+ n))
    k :value (random-between 0 n)
      :where (and (consp xs) (consp ys) (<= 0 k) (>= (1- (len xs)) k) 
                  (= (len xs) (len ys))))
  (equal (nth k (vector*vector xs ys)) (* (nth k xs) (nth k ys))))
