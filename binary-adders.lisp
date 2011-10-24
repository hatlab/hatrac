(in-package "ACL2")

(include-book "doublecheck" :dir :teachpacks)

(include-book "numerals")

(defun or-gate (x y)
  (if (or (= x 1) (= y 1)) 1 0))

(defun and-gate (x y)
  (if (and (= x 1) (= y 1)) 1 0))

(defun xor-gate (x y)
  (if (and (= x 1) (= y 1))
      0
      (or-gate x y)))

(defun half-adder (x y)
  (list (xor-gate x y) (and-gate x y)))

(defun bitp (b)
  (or (= b 0) (= b 1)))

(defrandom random-bit ()
  (random-between 0 1))

(defproperty half-adder-works
  (x :where (bitp x) :value (random-bit)
   y :where (bitp y) :value (random-bit))
  (= (num (half-adder x y)) (+ x y)))

(defun full-adder (c-in x y)
  (let* ((h1 (half-adder x y))
         (s1 (first h1))
         (c1 (second h1))
         (h2 (half-adder s1 c-in))
         (s (first h2))
         (c2 (second h2))
         (c (or-gate c1 c2)))
    (list s c)))

(defproperty full-adder-works
  (x :where (bitp x) :value (random-bit)
   y :where (bitp y) :value (random-bit)
   c-in :where (bitp c-in) :value (random-bit))
  (= (num (full-adder x y c-in)) (+ x y c-in)))

(defun adder2 (c0 x y)
  (let* ((x0 (first x)) (x1 (second x))
        (y0 (first y)) (y1 (second y))
        (f0 (full-adder c0 x0 y0))
        (s0 (first f0)) (c1 (second f0))
        (f1 (full-adder c1 x1 y1))
        (s1 (first f1)) (c2 (second f1)))
  (list (list s0 s1) c2)))

(defproperty adder2-ok
  (c0 :where (bitp c0) :value (random-bit)
   x0 :where (bitp x0) :value (random-bit)
   x1 :where (bitp x1) :value (random-bit)
   y0 :where (bitp y0) :value (random-bit)
   y1 :where (bitp y1) :value (random-bit))
  (let* ((a (adder2 c0 (list x0 x1) (list y0 y1))) 
         (s (first a)) (c (second a)))
    (= (num (append s (list c)))
       (+ c0 (num (list x0 x1)) (num (list y0 y1))))))

(defun adder (c0 x y)
  (if (consp x)
      (let* ((x0 (first x)) (xs (rest x)) (y0 (first y)) (ys (rest y))
            (a0 (full-adder c0 x0 y0)) (s0 (first a0)) (c1 (second a0))
            (a (adder c1 xs ys)) (ss (first a)) (c (second a)))
        (list (cons s0 ss) c)) ; {add1}
      (list nil c0)))          ; {add0}

(defun bit-listp (xs)
  (or (endp xs)
      (and (bitp (first xs))
           (bit-listp (rest xs)))))

(defproperty adder-ok
  (c0 :where (bitp c0) :value (random-bit)
   x  :where (bit-listp x)
      :value (random-list-of (random-bit))
   y  :where (and (bit-listp y) (= (len x) (len y)))
      :value (random-list-of (random-bit)))
  (let* ((a (adder c0 x y))
         (s (first a))
         (c (second a)))
    (= (num (append s (list c)))
       (+ c0 (num x) (num y)))))

;;; Bignum adder

(defun add-1 (x)
  (if (consp x)
      (if (= (first x) 1)
          (cons 0 (add-1 (rest x)))
          (cons 1 (rest x)))
      (list 1)))

(defun add-c (c x)
  (if (= c 1)
      (add-1 x)
      x))

(defun add (c0 x y)
  (if (and (consp x) (consp y))
      (let* ((x0 (first x))
             (y0 (first y))
             (a (full-adder c0 x0 y0))
             (s0 (first a))
             (c1 (second a)))
        (cons s0 (add c1 (rest x) (rest y)))) ; addxy
    (if (consp x)
        (add-c c0 x)	; addx0
        (add-c c0 y))))	; add0y

(defun my1 (x y)
  (if (consp x)
      (let* ((m (my1 (rest x) y)))
        (if (= (first x) 1)
            (cons (first y) (add 0 (rest y) m)) ; mul1xy
            (cons 0 m)))                        ; mul0xy
      nil))                                     ; mul0y

(defun mul (x y)
  (if (consp y)
      (my1 x y)
      nil))  ; mulx0

(defproperty add-ok
  (c :where (bitp c) :value (random-bit)
   x :where (bit-listp x) :value (random-list-of (random-bit))
   y :where (bit-listp y) :value (random-list-of (random-bit)))
  (= (num (add c x y))
     (+ (num (list c)) (num x) (num y))))

;(defproperty mul-ok
;  (x :where (bit-listp x) :value (random-list-of (random-bit))
;   y :where (bit-listp y) :value (random-list-of (random-bit)))
;  (= (num (mul x y))
;     (* (num x) (num y))))