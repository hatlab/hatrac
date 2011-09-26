(include-book "doublecheck" :dir :teachpacks)

(defproperty subset-chain-rule
  (xs :where (true-listp xs) :value (random-list-of (random-integer))
   ys :where (and (true-listp xs) (subsetp xs ys)) :value (random-list-of (random-integer))
   zs :where (and (true-listp xs) (subsetp ys zs)) :value (random-list-of (random-integer)))
  (subsetp xs zs))

(defun set-eqlp (xs ys)
  (and (subsetp xs ys) (subsetp ys xs)))

;(defproperty union-commutes
;  (xs :where (true-listp xs) :value (random-list-of (random-integer))
;   ys :where (true-listp ys) :value (random-list-of (random-integer)))
;  (set-eqlp (union-equal xs ys) (union-equal ys xs)))

(defun intersect (xs ys)
  (set-difference-equal xs (set-difference-equal xs ys)))

;(defproperty intersect-works
;  (x  :where (integerp x) :value (random-integer)
;   xs :where (and (true-listp xs) (member x xs))
;      :value (cons x (random-list-of (random-integer)))
;   ys :where (and (true-listp ys) (member x ys))
;      :value (cons x (random-list-of (random-integer))))
;  (and (subsetp (intersect xs ys) xs)
;       (subsetp (intersect xs ys) ys)
;       (member x (intersect xs ys))))

;(defproperty demorgan-union
;  (xs :where (true-listp xs) :value (random-list-of (random-integer))
;   ys :where (true-listp ys) :value (random-list-of (random-integer))
;   us :where (and (true-listp us) (subsetp xs us) (subsetp ys us))
;      :value (union-equal (union-equal xs ys)
;                          (random-list-of (random-integer))))
;  (set-eqlp (set-difference-equal us
;                                  (union-equal xs ys))
;            (intersect (set-difference-equal us xs)
;                       (set-difference-equal us ys))))