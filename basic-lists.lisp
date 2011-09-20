(include-book "doublecheck" :dir :teachpacks)

(defproperty zero-length-means-empty
  (xs :where (true-listp xs) :value (random-list-of (random-atom)))
  (equal (= 0 (len xs)) (equal xs nil)))

(defun sum (xs)
  (if (endp xs)
      0
      (+ (first xs) (sum (rest xs)))))

(defproperty sum-over-cons
  (xs :where (true-listp xs) :value (random-list-of (random-rational))
   x :where (rationalp x) :value (random-rational))
  (= (+ x (sum xs)) (sum (cons x xs))))

(defproperty append-one-value-equal-cons
  (xs :where (true-listp xs) :value (random-list-of (random-atom))
   x :where (atom x) :value (random-atom))
  (equal (cons x xs) (append (list x) xs)))

