(include-book "doublecheck" :dir :teachpacks)

(defun maximum (xs)
  (if (endp (rest xs))
      (first xs)
      (max (first xs) (maximum (rest xs)))))

(defproperty maximum->=-any-member
  (xs :where (true-listp xs) 
      :value (random-list-of (random-rational) :size (1+ (random-data-size)))
   x :where (member-equal x xs) :value (random-element-of xs))
  (<= x (maximum xs)))

(defproperty maximum-xs-comes-from-xs
  (xs :where (and (true-listp xs) (consp xs))
      :value (random-list-of (random-rational) :size (1+ (random-data-size))))
  (member-equal (maximum xs) xs))
