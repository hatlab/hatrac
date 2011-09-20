(include-book "doublecheck" :dir :teachpacks)

(defun maximum (xs)
  (if (endp (rest xs))
      (first xs)
      (max (first xs) (maximum (rest xs)))))

(defun in (x xs)
  (if (endp (rest xs))
      (equal x (first xs))
      (or (equal x (first xs)) (in x (rest xs)))))

(defproperty maximum->=-any-member
  (xs :where (true-listp xs) 
      :value (random-list-of (random-rational) :size (1+ (random-data-size)))
   x :where (in x xs) :value (random-element-of xs))
  (<= x (maximum xs)))

(defproperty maximum-xs-comes-from-xs
  (xs :where (true-listp xs)
      :value (random-list-of (random-rational) :size (1+ (random-data-size))))
  (in (maximum xs) xs))