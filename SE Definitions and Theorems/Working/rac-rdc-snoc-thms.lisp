; tests specify programmer expectations
(include-book "doublecheck" :dir :teachpacks)
(include-book "rac-rdc-snoc-defs")

(defproperty rac-tst
  (xs :value (random-list-of (random-integer))
      :where (consp (cdr xs))) ; more than one elem
  (equal (rac xs) (rac (cdr xs))))
(defproperty rdc-tst
  (xs :value (random-list-of (random-integer))
      :where (consp (cdr xs))) ; more than one elem
  (equal (rdc xs) (cons (car xs) (rdc (cdr xs)))))
(defproperty snoc-tst
  (x  :value (random-integer)
   xs :value (random-list-of (random-integer))
      :where (consp xs))  ; xs not empty
  (equal (snoc x xs)
         (cons (car xs) (snoc x (cdr xs)))))
(defproperty rac/snoc-identity
  (x  :value (random-integer)
   xs :value (random-list-of (random-integer)))
  (equal (rac (snoc x xs))
         x))
(defproperty rdc/snoc-identity
  (x  :value (random-integer)
   xs :value (random-list-of (random-integer)))
  (equal (rdc (snoc x xs))
         xs))
(defproperty rac/rdc/snoc-identity
  (xs :value (random-list-of (random-integer))
      :where (consp xs))
  (equal (snoc (rac xs) (rdc xs))
         xs))
(defproperty len-is-natural-number
  (xs :value (random-list-of (random-integer)))
  (natp (len xs)))
(defproperty len-def-tst
  (xs :value (random-list-of (random-integer))
      :where (consp xs))
  (= (len xs) (+ 1 (len (cdr xs)))))
