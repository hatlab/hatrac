(include-book "inner-product-and-similarity")
(include-book "doublecheck" :dir :teachpacks)

(defproperty ip-existence-lemma
  (xs :value (random-list-of (random-rational))
   ys :value (random-list-of (random-rational))
      :where (inner-product xs ys))
  (inner-product ys xs))
;
;(defproperty sim-commutes
;  (xs :value (random-list-of (random-rational))
;   ys :value (random-list-of (random-rational))
;      :where (and (consp xs) (consp ys)))
;           (equal (sim xs ys) (sim ys xs)))

;(defproperty scaling-preserves-sim
;  (xs :value (random-list-of (random-rational))
;   ys :value (random-list-of (random-rational))
;   s  :value (random-integer)
;      :where (and (consp xs) (consp ys)))
;        (equal (sim xs ys)
;                  (sim (scale s xs) (scale s ys))))
;
;(defproperty different-vectors-less-similar
;  (xs :value (random-list-of (random-rational))
;   ys :value (random-list-of (random-rational))
;      :where (and (consp xs) (consp ys)))
;           (>= (sim xs xs)
;               (sim xs ys)))

;(defproperty different-vectors-less-similar-2
;  (xs :value (random-list-of (random-rational))
;      :where (consp xs))
;           (< (sim (cons 1 xs) (cons 2 xs))
;              (sim (cons 1 xs) (cons 1 xs))))

