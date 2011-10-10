(include-book "inner-product-and-similarity")
(include-book "doublecheck" :dir :teachpacks)

(defproperty sim-commutes
  (xs :value (random-list-of (random-integer))
   ys :value (random-list-of (random-integer)))
           (equal (sim xs ys) (sim ys xs)))

(defproperty scaling-preserves-sim
  (n  :value (random-natural)
   xs :value (random-list-of (random-between -100 100) :size n)
   ys :value (random-list-of (random-between -100 100) :size n)
   s  :value (random-integer)
   sxs :value (scale s xs)
   sys :value (scale s ys)
       :where (and (sim xs ys)
                   (sim sxs sys)))
        (equal (sim xs ys)
                  (sim sxs sys)))

(defproperty different-vectors-less-similar
  (n  :value (random-natural)
   xs :value (random-list-of (random-between -100 100) :size n)
   ys :value (random-list-of (random-between -100 100) :size n)
      :where (sim xs ys))
           (>= (sim xs xs)
               (sim xs ys)))

(defproperty different-vectors-less-similar-2
  (xs :value (random-list-of (random-between -100 100))
      :where (sim xs xs))         ; xs is legit
           (< (sim (cons 1 xs) (cons 2 xs))
              (sim (cons 1 xs) (cons 1 xs))))