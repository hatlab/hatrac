; tests specify programmer expectations
(include-book "doublecheck" :dir :teachpacks)
(include-book "split-blocks-concat-defs")
(defproperty split-len-tst
  (n  :value (random-natural)
   m  :value (random-natural)
   xs :value (random-list-of (random-integer) :size (+ n m))
      :where (and (natp n) (>= (len xs) n)))
  (= (len (car (split n xs))) n))
(defproperty split-len<-tst
  (n  :value (random-natural)
   m  :value (random-between 1 (1- n))
   xs :value (random-list-of (random-integer) :size (- n m))
      :where (and (natp n) (< (len xs) n)))
  (= (len (car (split n xs))) (len xs)))
(defproperty split-inv-tst
  (n  :value (random-natural)
   xs :value (random-list-of (random-integer))
      :where (natp n))
  (equal (append (car (split n xs))
                 (cadr (split n xs)))
         xs))
(defproperty concat-additive-len-tst
  (xss :value (random-list-of (random-list-of (random-symbol))))
  (= (len (concat xss)) (total-len xss)))
(defproperty concat-conservation-tst :repeat 100
  (x   :value (random-symbol)
   xss :value (random-list-of (random-list-of (random-symbol))))
  (iff (member-one+ x xss) (member-equal x (concat xss))))

;Still not working - ARS 9/19/11
(defproperty blocks-inv-tst
  (n  :value (random-data-size)
      :where (posp n)
   xs :value (random-list-of (random-symbol)))
  (equal (concat (blocks n xs)) xs)
  :hints (("Goal" :use concat-conservation-tst)))

;New Properties: - ARS 03/12/12
(defproperty firstN-preserves-elements
  (n  :value (random-natural)
      :where (posp n)
   xs :value (random-list-of (random-symbol))
   k  :value (random-between 0 (1- n))
      :where (and (>= k 0) (<= k (1- n))))
  (equal (nth k xs) (nth k (firstN n xs))))

(defproperty second-element-of-split-is-shorter
  (n  :value (random-natural)
      :where (posp n)
   xs :value (random-list-of (random-symbol))
      :where (consp xs))
  (> (length xs) (length (cadr (split n xs)))))

(defproperty second-element-of-split-is-nthcdr
  (n  :value (random-natural)
      :where (posp n)
   xs :value (random-list-of (random-symbol))
      :where (consp xs))
  (equal (nthcdr n xs) (cadr (split n xs))))