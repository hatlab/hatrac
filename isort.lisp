(include-book "doublecheck" :dir :teachpacks)

(defun insert (x xs)
  (if (endp xs)
      (list x)
      (if (> x (first xs))
          (cons (first xs) (insert x (rest xs)))
          (cons x xs))))

(defun sortedp (xs)
  (if (consp (rest xs))
      (and (<= (first xs) (second xs)) (sortedp (rest xs)))
      t))

(defproperty insert-works
  (xs :where (sortedp xs) :value (random-list-of (random-integer))
   x  :where (integerp x) :value (random-integer))
  (sortedp (insert x xs)))

(defun isort (xs)
  (if (endp xs)
      xs
      (insert (first xs) (isort (rest xs)))))

(defproperty isort-works
  (xs :where (true-listp xs) :value (random-list-of (random-integer)))
  (sortedp (isort xs)))