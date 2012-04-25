(include-book "doublecheck" :dir :teachpacks)

(defun part (x xs)
  (if (consp xs) 
      (let* ((p (part x (cdr xs)))
             (bf (car p))
             (af (cadr p)))
        (if (< (car xs) x)
            (list (cons (car xs) bf) af)
            (list bf (cons (car xs) af))))
      (list nil nil)))

(defun quicksort (xs)
  (if (consp (cdr xs))
      (let* ((x (car xs))
             (p  (part x (cdr xs)))
             (bf (quicksort (car p)))
             (af (quicksort (cadr p))))
        (append bf (list x) af))
      xs))

(defun up (xs)
  (or (endp (cdr xs))
      (and (<= (car xs) (cadr xs))
           (up (cdr xs)))))

(defun permutationp (xs ys)
  (if (consp xs)
      (permutationp (cdr xs) (remove1 (car xs) ys))
      (not ys)))

;(defproperty quicksort-preserves-elements-alt
;  (xs :value (random-list-of (random-integer))
;    x :value (random-integer) 
;      :where (and (true-listp xs) (member x xs)))
;  (member x (quicksort xs)))
;
;(defproperty quicksort-preserves-elements-alt-2
;  (xs :value (random-list-of (random-integer))
;    x :value (random-integer) 
;      :where (and (true-listp xs) (member x (quicksort xs))))
;  (member x xs))
;
;(defproperty quicksort-preserves-elements
;  (xs :value (random-list-of (random-integer))
;      :where (true-listp xs))
;  (permutationp xs (quicksort xs)))

(defproperty quicksort-works
  (xs :value (random-list-of (random-integer))
      :where (true-listp xs))
  (up (quicksort xs)))
  