; tests specify programmer expectations
(include-book "doublecheck" :dir :teachpacks)
(include-book "rac-rdc-snoc-defs")

;(defproperty snoc-preserves-car
;  (xs :value (random-list-of (random-symbol))
;   x  :value (random-symbol)
;      :where (consp xs))
;  (equal (car xs) (car (snoc x xs))))

(defthmd sonc-preserves-car-d
  (implies (consp xs)
           (equal (car xs) (car (snoc x xs)))))

;(defproperty cdr-preserves-rac
;  (xs :value (random-list-of (random-integer))
;      :where (consp (cdr xs))) ; more than one elem
;  (equal (rac xs) (rac (cdr xs))))

(defthmd cdr-preserves-rac-d
  (implies (consp (cdr xs))
           (equal (rac xs) (rac (cdr xs)))))

;(defproperty rdc-preserves-car
;  (xs :value (random-list-of (random-symbol))
;      :where (consp (cdr xs)))
;  (equal (car xs) (car (rdc xs))))

(defthmd rdc-preserves-car-d
  (implies (consp (cdr xs))
           (equal (car xs) (car (rdc xs)))))

;(defproperty rac/snoc-identity
;  (x  :value (random-integer)
;   xs :value (random-list-of (random-integer)))
;  (equal (rac (snoc x xs))
;         x))

(defthmd rac/snoc-identity-d
  (equal (rac (snoc x xs)) x))

;(defproperty rdc/snoc-identity
;  (x  :value (random-integer)
;   xs :value (random-list-of (random-integer)))
;  (equal (rdc (snoc x xs))
;         xs))

(defthmd rdc/snoc-identity
  (equal (rdc (snoc x xs)) xs))

;(defproperty rac/rdc/snoc-identity
;  (xs :value (random-list-of (random-integer))
;      :where (consp xs))
;  (equal (snoc (rac xs) (rdc xs))
;         xs))

(defthmd rac/rdc/snoc-identity
  (implies (consp xs)
           (equal (snoc (rac xs) (rdc xs)) xs)))

(defproperty len-is-natural-number
  (xs :value (random-list-of (random-integer)))
  (natp (len xs)))

(defproperty len-def-tst
  (xs :value (random-list-of (random-integer))
      :where (consp xs))
  (= (len xs) (1+ (len (cdr xs)))))
