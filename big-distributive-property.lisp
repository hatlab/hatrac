(include-book "doublecheck" :dir :teachpacks)

(defun sum (xs)
  (if (endp xs)
      0
      (+ (first xs) (sum (rest xs)))))

(defun each* (xs c)
  (if (endp xs)
      xs
      (cons (* c (first xs)) (each* (rest xs) c))))

(defproperty sum-each-*-c-equals-c-*-sum
  (xs :where (true-listp xs) :value (random-list-of (random-rational))
   c :where (rationalp c) :value (random-rational))
  (= (sum (each* xs c)) (* c (sum xs))))