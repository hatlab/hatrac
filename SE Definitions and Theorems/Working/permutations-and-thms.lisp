;;;;;;All proven - ARS 4/18/12;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(include-book "doublecheck" :dir :teachpacks)

(defun cons-all (x xss)
  (if (consp xss)
      (cons (cons x (car xss)) (cons-all x (cdr xss)))
      nil))

(defun insert-everywhere (x xs)
  (if (consp xs)
      (let* ((part-xss (insert-everywhere x (cdr xs)))
             (cdr-xss (cons-all (car xs) part-xss)))
        (cons (cons x xs) cdr-xss))
      (list (list x))))

(defun insert-everywhere-in-all (x xss)
  (if (consp xss)
      (cons (insert-everywhere x (car xss))
            (insert-everywhere-in-all x (cdr xss)))
      nil))

(defun concat (xss)
  (if (consp xss)
      (append (car xss) (concat (cdr xss)))
      nil))

(defun permutations (xs)
  (if (consp (cdr xs))
      (concat (insert-everywhere-in-all (car xs) (permutations (cdr xs))))
      (list xs)))

(defun permutationp (xs ys)
  (if (consp xs)
      (permutationp (cdr xs) (remove1 (car xs) ys))
      (not ys)))

(defun permutation-listp (xs xss)
  (or (endp xss)
      (and (permutationp xs (car xss))
           (permutation-listp xs (cdr xss)))))

(defun member-allp (x xss)
  (or (null xss)
      (and (member x (car xss))
           (member-allp x (cdr xss)))))

(defproperty insert-everywhere-delivers-list-of-lists
  (xs :value (random-list-of (random-symbol))
    x :value (random-symbol)
      :where (true-listp xs))
  (true-list-listp (insert-everywhere x xs)))

(defun true-list-list-listp (xsss)
    (if (atom xsss) 
        (null xsss) 
        (and (true-list-listp (car xsss))
             (true-list-list-listp (cdr xsss)))))

(defproperty insert-everywhere-in-all-delivers-list-of-list-of-lists
  (xss :value (random-list-of (random-list-of (random-symbol)))
     x :value (random-symbol)
       :where (true-list-listp xss))
  (true-list-list-listp (insert-everywhere-in-all x xss)))

(defproperty permutations-delivers-list-of-lists
  (xs :value (random-list-of (random-symbol) :size (random-between 0 5))
      :where (true-listp xs))
  (true-list-listp (permutations xs)))

(defproperty insert-everywhere-increases-length-by-1
  (xs :value (random-list-of (random-symbol))
    x :value (random-symbol)
      :where (true-listp xs))
  (= (length xs) (1- (length (insert-everywhere x xs)))))

(defproperty insert-everywhere-delivers-permutations
  (xs :value (random-list-of (random-symbol))
    x :value (random-symbol)
      :where (true-listp xs))
  (permutation-listp (cons x xs) (insert-everywhere x xs)))

(defproperty x-is-in-every-list-of-insert-everywhere
  (xs :value (random-list-of (random-symbol))
    x :value (random-symbol)
      :where (true-listp xs))
  (member-allp x (insert-everywhere x xs)))

(defproperty x-is-in-every-list-of-every-list-of-insert-everywhere-in-all
  (xss :value (random-list-of (random-list-of (random-symbol)))
     x :value (random-symbol)
   yss :value (random-element-of (insert-everywhere-in-all x xss))
       :where (and (true-list-listp xss)
                   (true-list-listp yss)
                   (member-equal yss (insert-everywhere-in-all x xss))))
  (member-allp x yss))