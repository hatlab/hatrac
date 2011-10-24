(include-book "doublecheck" :dir :teachpacks)

(defproperty subset-chain-rule
  (xs :value (random-list-of (random-natural))
   ys :where (subsetp xs ys)
      :value (random-list-of (random-natural))
   zs :where (subsetp ys zs)
      :value (random-list-of (random-natural)))
  (subsetp xs zs))

(defun set-equalp (xs ys)
  (and (subsetp xs ys) (subsetp ys xs)))

(defun my-union (xs ys)
  (if (endp xs)
      ys
      (let ((x (first xs)))
        (if (member-equal x ys)
            (my-union (rest xs) ys)
            (cons x (my-union (rest xs) ys))))))

(defproperty y-in-union-xs-ys
  (xs :value (random-list-of (random-natural))
   ys :where (consp ys)
      :value (random-list-of (random-natural)))
  (member-equal (car ys) (my-union xs ys)))

(defproperty in-over-union
  (xs :value (random-list-of (random-natural)
                             :size (+ 1 (random-data-size)))
   ys :where (consp ys)
      :value (random-list-of (random-natural))
   e  :value (random-element-of (list (random-element-of ys)
                                      (random-element-of xs)
                                      (random-natural))))
  (iff (member-equal e (my-union xs ys))
       (or (member-equal e xs) (member-equal e ys))))

(defproperty x-in-union-xs-ys
  (xs :where (consp xs)
      :value (random-list-of (random-natural))
   ys :value (random-list-of (random-natural)))
  (member (car xs) (my-union ys xs)))

(defproperty subset-rest
  (xs :value (random-list-of (random-natural))
   ys :value (random-list-of (random-natural)))
  (implies (subsetp ys (cdr xs))
           (subsetp ys xs)))

(defproperty subset-reflexive
  (xs :value (random-list-of (random-natural)))
  (subsetp xs xs))

(defproperty subset-one-step
  (xs :value (random-list-of (random-natural))
   ys :value (random-list-of (random-natural)))
  (subsetp (my-union (rest xs) ys) (my-union ys (rest xs))))

(defproperty union-commutes-1
  (xs :where (consp xs) :value (random-list-of (random-natural))
   ys :where (member-equal (first xs) ys)
      :value (random-list-of (random-natural)))
  (subsetp (my-union (rest xs) ys)
           (my-union ys xs)))

(defproperty union-commutes-2
  (xs :where (consp xs) :value (random-list-of (random-natural))
   ys :where (not (member-equal (first xs) ys))
      :value (random-list-of (random-natural)))
  (subsetp (my-union (rest xs) ys)
           (my-union ys xs)))

(defproperty union-commutes
  (xs :value (random-list-of (random-natural))
   ys :value (random-list-of (random-natural)))
  (set-equalp (my-union xs ys) (my-union ys xs)))

(defun intersect (xs ys)
  (set-difference-equal xs (set-difference-equal xs ys)))

(defproperty intersect-works
  (x  :where (integerp x) :value (random-natural)
   xs :where (and (true-listp xs) (member x xs))
      :value (cons x (random-list-of (random-natural)))
   ys :where (and (true-listp ys) (member x ys))
      :value (cons x (random-list-of (random-natural))))
  (and (subsetp (intersect xs ys) xs)
       (subsetp (intersect xs ys) ys)
       (member x (intersect xs ys))))

(defproperty demorgan-union
  (xs :where (true-listp xs) :value (random-list-of (random-natural))
   ys :where (true-listp ys) :value (random-list-of (random-natural))
   us :where (and (true-listp us) (subsetp xs us) (subsetp ys us))
      :value (union-equal (union-equal xs ys)
                          (random-list-of (random-natural))))
  (set-equalp (set-difference-equal us
                                  (union-equal xs ys))
            (intersect (set-difference-equal us xs)
                       (set-difference-equal us ys))))
