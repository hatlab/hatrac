;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(include-book "inner-product-and-similarity")
(include-book "doublecheck" :dir :teachpacks)

(defthm x-squared-is-non-neg
  (implies (rationalp x)
      (>= (* x x) 0)))

(defproperty euclidean-length-is-positive
  (xs :value (random-list-of (random-rational))
      :where (and (rational-listp xs) (consp xs)))
  (>= (inner-product xs xs) 0))

(include-book "arithmetic-5/top" :dir :system)

(defproperty ip-type-checking
  (xs :value (random-list-of (random-rational))
   ys :value (random-list-of (random-rational))
      :where (and (consp xs) (consp ys)))
  (rationalp (inner-product xs ys)))

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
      :where (and (consp xs) (consp ys)))
  (rationalp (sim xs ys)))

;(defproperty inner-product-definition-lemma
;  (xs :value (random-list-of (random-rational))
;   ys :value (random-list-of (random-rational))
;      :where (and (rational-listp xs) (rational-listp ys)))
;  (equal (inner-product xs ys)
;         (sum-list (multiply xs ys))))

;(defthm ip-is-number
;  (implies (and (rational-listp xs)
;                (rational-listp ys))
;           (rationalp (inner-product xs ys))))
(defthm scaling-base-case
  (equal (inner-product (scale s nil) nil)
         0))
(defthm scaling-inductive-case
  (implies (and (rationalp s)
                (rational-listp xs)
                (rational-listp ys)
                (consp xs)
                (consp ys)
                (equal (inner-product (scale s (cdr xs)) (cdr ys))
                       (* s (inner-product (cdr xs) (cdr ys)))))
           (equal (inner-product (scale s xs) ys)
                  (* s (inner-product xs ys)))))

(defproperty scaling-distributes-over-ip-lemma
  (xs :value (random-list-of (random-rational))
   ys :value (random-list-of (random-rational))
   s  :value (random-integer)
      :where (and (rational-listp xs) (rational-listp ys) (consp xs) 
                  (consp ys) (rationalp s)))
  (equal (inner-product (scale s xs) ys)
         (* s (inner-product xs ys))))

(defproperty pos-times-pos-is-pos
  (x :value (random-rational)
   y :value (random-rational)
     :where (and (posp x) (posp y)))
  (< 0 (* x y)))

(defproperty neg-times-neg-is-pos
  (x :value (random-rational)
   y :value (random-rational)
     :where (and (< x 0) (< y 0) (rationalp x) (rationalp y)))
  (< 0 (* x y)))

;(defproperty x-squared-is-non-negative-lemma
;  (x :value (random-rational)
;     :where (rationalp x))
;  (<= 0 (* x x)))

;(defproperty length-squared-is->=-zero-lemma
;  (xs :value (random-list-of (random-rational))
;      :where (and (consp xs) (rational-listp xs)))
;  (>= (inner-product xs xs) 0))

(defproperty scaling-distributes-on-both-sides-lemma
  (xs :value (random-list-of (random-rational))
   ys :value (random-list-of (random-rational))
   s1 :value (random-integer)
   s2 :value (random-integer)
      :where (and (rational-listp xs) (rational-listp ys) (consp xs) 
                  (consp ys) (rationalp s1) (rationalp s2)))
  (equal (inner-product (scale s1 xs) (scale s2 ys))
         (* s1 s2 (inner-product xs ys))))

(defproperty scaling-by-0-makes-zero-vector-lemma
  (xs :value (random-list-of (random-rational)))
  (zero-vectorp (scale 0 xs)))
  
(defproperty positive-scaling-preserves-sim
  (xs :value (random-list-of (random-rational))
   ys :value (random-list-of (random-rational))
   s  :value (random-integer)
      :where (and (rational-listp xs) (rational-listp ys) (consp xs) 
                  (consp ys) (rationalp s) (< 0 s)))
        (equal (sim xs ys)
                  (sim (scale s xs) ys)))

(defproperty negative-scaling-preserves-sim
  (xs :value (random-list-of (random-rational))
   ys :value (random-list-of (random-rational))
   s  :value (random-integer)
      :where (and (rational-listp xs) (rational-listp ys) (consp xs) 
                  (consp ys) (rationalp s) (> 0 s)))
        (equal (sim xs ys)
                  (sim (scale s xs) ys)))

(defproperty scaling-both-preserves-sim
  (xs :value (random-list-of (random-rational))
   ys :value (random-list-of (random-rational))
   s  :value (random-integer)
      :where (and (rational-listp xs) (rational-listp ys) (consp xs) 
                  (consp ys) (rationalp s) (not (equal s 0))))
        (equal (sim xs ys)
                  (sim (scale s xs) (scale s ys)))
  :hints (("Goal" :use (positive-scaling-preserves-sim 
                        negative-scaling-preserves-sim))))

(defproperty sim-of-equal-vectors-is-one
  (xs :value (random-list-of (random-rational))
      :where (rational-listp xs))
  (= (sim xs xs) 1))

;(defproperty sim<=1-lemma
;  (n  :value (random-between 1 100)
;   xs :value (random-list-of (random-rational) :size n)
;   ys :value (random-list-of (random-rational) :size n)
;      :where (and (not (zero-vectorp xs)) (not (zero-vectorp ys)) (= (length xs) (length ys))))
;  (<= (abs (sim xs ys)) 1))
  
(defproperty different-vectors-less-similar
  (xs :value (random-list-of (random-rational))
   ys :value (random-list-of (random-rational))
      :where (and (not (zero-vectorp xs)) (not (zero-vectorp ys)) (= (length xs) (length ys))))
           (>= (sim xs xs)
               (sim xs ys)))


(defproperty different-vectors-less-similar-2
  (xs :value (random-list-of (random-rational))
      :where (and (not (zero-vectorp xs)) (rational-listp xs)))
           (< (sim (cons 1 xs) (cons 2 xs))
              (sim (cons 1 xs) (cons 1 xs))))

