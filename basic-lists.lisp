(include-book "doublecheck" :dir :teachpacks)
(include-book "arithmetic-3/top" :dir :system)
(include-book "arithmetic-3/floor-mod/floor-mod" :dir :system)

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

(defproperty length-always->=-zero
  (xs :where (true-listp xs) :value (random-list-of (random-atom)))
  (>= (length xs) 0))

(defun my-evens (xs)
  (cond ((endp xs) xs)
        ((endp (rest xs)) xs)
        (t (cons (first xs) (my-evens (rest (rest xs)))))))

;(defproperty evens-returns-list-lemma
;  (xs :where (true-listp xs) :value (random-list-of (random-atom)))
;  (true-listp (my-evens xs)))
;
;(defproperty evens-halves-length
;  (xs :where (true-listp xs) :value (random-list-of (random-atom)))
;  (= (length (my-evens xs)) (floor (1+ (length xs)) 2)))
