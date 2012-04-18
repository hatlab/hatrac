(include-book "doublecheck" :dir :teachpacks)
(include-book "arithmetic-5/top" :dir :system)

(defun cons-all (x xss)
  (if (consp xss)
      (cons (cons x (car xss)) (cons-all x (cdr xss)))
      nil))

(defun sublists (xs)
  (if (consp xs)
      (let ((sub (sublists (cdr xs))))
        (append (cons-all (car xs) sub) sub))
      (list nil)))

(defun sublistp (ys xs)
  (if (consp ys)
      (if (consp xs)
          (if (equal (car xs) (car ys))
              (sublistp (cdr ys) (cdr xs))
              (sublistp ys (cdr xs)))
          nil)
      t))

(defun sublist-listp (xs yss)
  (or (endp yss)
      (and (sublistp (car yss) xs) 
           (sublist-listp xs (cdr yss)))))
          
(defproperty sublist-delivers-list-of-sublists
  (xs :value (random-list-of (random-symbol))
      :where (true-listp xs))
  (sublist-listp xs (sublists xs)))

