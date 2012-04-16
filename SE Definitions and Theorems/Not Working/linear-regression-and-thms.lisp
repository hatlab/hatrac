;;; All theorems in this file are proven - ARS 04/11/12
(include-book "doublecheck" :dir :teachpacks)
(include-book "arithmetic-5/top" :dir :system)

(defun avg (xs)
  (if (consp xs)
      (/ (+ (* (avg (cdr xs)) (len (cdr xs))) (car xs)) (len xs))
      0))

(defun vector+scalar (xs s)
  (if (consp xs)
      (cons (+ (car xs) s) (vector+scalar (cdr xs) s))
      nil))

(defun vector*vector (xs ys)
  (if (and (consp xs) (consp ys))
      (cons (* (car xs) (car ys)) (vector*vector (cdr xs) (cdr ys)))
      nil))

(defun sum (xs)
  (if (consp xs)
      (+ (car xs) (sum (cdr xs)))
      0))

(defproperty vector*vector-works
  ( n :value (1+ (random-data-size))
   xs :value (random-list-of (random-rational) :size n)
   ys :value (random-list-of (random-rational) :size n)
    k :value (random-between 0 (1- n))
      :where (and (consp xs) (consp ys) (<= 0 k) (>= (1- (len xs)) k) 
                  (= (len xs) (len ys))))
  (equal (nth k (vector*vector xs ys)) (* (nth k xs) (nth k ys))))

(defproperty avg-works
  (xs :value (random-list-of (random-rational))
      :where (rational-listp xs))
  (equal (avg xs) (/ (sum xs) (len xs))))