(include-book "doublecheck" :dir :teachpacks)
(include-book "arithmetic-5/top" :dir :system)

(defun mux (xs ys)
  (cond ((endp xs) ys)
        ((endp ys) xs)
        (t (append (list (car xs) (car ys))
                   (mux (cdr xs) (cdr ys))))))

(defproperty mux-works
  (n  :value (1+ (random-data-size))
   xs :value (random-list-of (random-atom) :size n)
   ys :value (random-list-of (random-atom) :size n)
   xk :value (random-between 0 (1- n))
   yk :value (random-between 0 (1- n)))
  (and (equal (nth (* xk 2) (mux xs ys))
              (nth xk xs))
       (equal (nth (1+ (* yk 2)) (mux xs ys))
              (nth yk ys))))