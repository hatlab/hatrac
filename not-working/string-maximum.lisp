(include-book "doublecheck" :dir :teachpacks)
(include-book "str/top" :dir :system)

(defun string-max (r s)
  (if (integerp (string> r s))
      r
      s))

(defun maximum (ss)
  (if (endp (rest ss))
      (first ss)
      (string-max (first ss) (maximum (rest ss)))))

(defproperty maximum-greater-than-any-member-2
  (ss :where (true-listp ss) :value (random-list-of (random-string) :size (1+ (random-data-size)))
   s :where (member-equal s ss) :value (random-element-of ss))
  (integerp (string<= s (maximum ss))))

;(defproperty maximum-greater-than-any-member
;  (n :where (natp n) :value (random-data-size)
;   ss :where (and (true-listp ss) (< (len ss) n)) :value (random-list-of (random-string) :size n)
;   k :where (and (natp k) (< k n)) :value (random-between 0 (1- n)))
;  (integerp (string<= (nth k ss) (maximum ss))))
