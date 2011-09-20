(include-book "doublecheck" :dir :teachpacks)

;(defthmd and-commutes
;  (implies (and (booleanp x) (booleanp y))
;           (equal (and x y) (and y x))))

;(defproperty and-commutes
;  (x :where (booleanp x) :value (random-boolean)
;   y :where (booleanp y) :value (random-boolean))
;  (equal (and x y) (and y x)))

(defproperty and-demorgan
  (x :where (booleanp x) :value (random-boolean)
   y :where (booleanp y) :value (random-boolean))
  (equal (not (and x y))
         (or (not x) (not y))))

;(defproperty and-absorption
;  (x :where (booleanp x) :value (random-boolean)
;   y :where (booleanp y) :value (random-boolean))
;  (equal (and (or x y) y) y))

(defproperty or-implication
  (x :where (booleanp x) :value (random-boolean)
   y :where (booleanp y) :value (random-boolean)
   z :where (booleanp x) :value (random-boolean))
  (equal (implies (or x y) z) (and (implies x z) (implies y z))))

;(defproperty true-incognito
;  (x :where (booleanp x) :value (random-boolean)
;   y :where (booleanp y) :value (random-boolean))
;  (implies x (implies (not x) y)))

(defproperty implication
  (x :where (booleanp x) :value (random-boolean)
   y :where (booleanp y) :value (random-boolean))
  (equal (implies x y) (or (not x) y)))

;(defproperty absurdidity
;  (x :where (booleanp x) :value (random-boolean)
;   y :where (booleanp y) :value (random-boolean))
;  (equal (and (implies x y) (implies x (not y))) (not x)))

