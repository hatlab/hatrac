(include-book "inner-product-and-similarity")
(include-book "doublecheck" :dir :teachpacks)
(include-book "arithmetic-5/top" :dir :system)

(defproperty ip-inverse-existence-lemma
  (xs :value (random-list-of (random-rational))
   ys :value (random-list-of (random-rational))
      :where (acl2-numberp (inner-product xs ys)))
  (acl2-numberp (inner-product ys xs)))

(defproperty ip-commutes
  (xs :value (random-list-of (random-rational))
   ys :value (random-list-of (random-rational))
      :where (and (consp xs) (consp ys)))
  (equal (inner-product xs ys) (inner-product ys xs)))

(defproperty sim-commutes
  (xs :value (random-list-of (random-rational))
   ys :value (random-list-of (random-rational))
      :where (and (consp xs) (consp ys)))
           (equal (sim xs ys) (sim ys xs)))

(defproperty sim-existence-lemma
  (xs :value (random-list-of (random-rational))
   ys :value (random-list-of (random-rational))
      :where (and (consp xs) (consp ys) (rational-listp xs) (rational-listp ys) 
                  (not (zero-vectorp xs)) (not (zero-vectorp ys)) (equal (length xs) (length ys))))
  (acl2-numberp (sim xs ys)))

(defproperty inner-product-definition-lemma
  (xs :value (random-list-of (random-rational))
   ys :value (random-list-of (random-rational))
      :where (and (consp xs) (consp ys) (rational-listp xs) (rational-listp ys)  
                  (not (zero-vectorp xs)) (not (zero-vectorp ys)) (equal (length xs) (length ys))))
  (equal (inner-product xs ys)
         (sum-list (multiply xs ys))))

(defproperty scaling-distributes-over-ip-lemma
  (xs :value (random-list-of (random-rational))
   ys :value (random-list-of (random-rational))
   s  :value (random-integer)
      :where (and (consp xs) (consp ys) (rational-listp xs) (rational-listp ys) (not (zero-vectorp xs))
                  (not (zero-vectorp ys)) (equal (length xs) (length ys)) (acl2-numberp s)
                  (not (equal s 0))))
  (equal (inner-product (scale s xs) ys)
         (* s (inner-product xs ys))))

(defproperty scaling-preserves-sim
  (xs :value (random-list-of (random-rational))
   ys :value (random-list-of (random-rational))
   s  :value (random-integer)
      :where (and (not (zero-vectorp xs)) (not (zero-vectorp ys)) (not (equal s 0))))
        (equal (sim xs ys)
                  (sim (scale s xs) (scale s ys))))

(defproperty sim<=1-lemma
  (n  :value (random-between 1 100)
   xs :value (random-list-of (random-rational) :size n)
   ys :value (random-list-of (random-rational) :size n)
      :where (and (not (zero-vectorp xs)) (not (zero-vectorp ys)) (= (length xs) (length ys))))
  (<= (abs (sim xs ys)) 1))
  
(defproperty different-vectors-less-similar
  (xs :value (random-list-of (random-rational))
   ys :value (random-list-of (random-rational))
      :where (and (not (zero-vectorp xs)) (not (zero-vectorp ys)) (= (length xs) (length ys))))
           (>= (sim xs xs)
               (sim xs ys)))

(defproperty sim-of-equal-vectors-is-one
  (xs :value (random-list-of (random-rational))
      :where (and (not (zero-vectorp xs)) (rational-listp xs)))
  (= (sim xs xs) 1))

(defproperty different-vectors-less-similar-2
  (xs :value (random-list-of (random-rational))
      :where (and (not (zero-vectorp xs)) (rational-listp xs)))
           (< (sim (cons 1 xs) (cons 2 xs))
              (sim (cons 1 xs) (cons 1 xs))))

