(include-book "doublecheck" :dir :teachpacks)
(include-book "arithmetic-3/top" :dir :system)

(defun sum (xs)
  (if (endp xs)
      0
      (+ (first xs) (sum (rest xs)))))

(defun sumr (s xs)
  (if (endp xs)
      s
      (sumr (+ s (first xs)) (rest xs))))

(defproperty sumr-equals-sum
  (xs :where (rational-listp xs) :value (random-list-of (random-rational))
   s :where (rationalp s) :value (random-rational))
  (equal (sumr s xs) (+ s (sum xs))))