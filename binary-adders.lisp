(in-package "ACL2")

(include-book "doublecheck" :dir :teachpacks)

(defun num (x) ; number denoted by binary numeral x
  (if (consp x)
      (if (= (first x) 1)
          (+ 1 (* 2 (num (rest x))))
          (* 2 (num (rest x))))
      0))

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

(defun bit-listp (xs)
  (or (endp xs)
      (and (bitp (first xs))
           (bit-listp (rest xs)))))

(defrandom random-bit ()
  (random-between 0 1))

(defun full-adder (c-in x y)
  (let* ((h1 (half-adder x y))
         (s1 (first h1))
         (c1 (second h1))
         (h2 (half-adder s1 c-in))
         (s  (first h2))
         (c2 (second h2))
         (c  (or-gate c1 c2)))
    (list s c)))

(defun adder2 (c0 x y)
  (let* ((x0 (first x))
         (x1 (second x))
         (y0 (first y))
         (y1 (second y))
         (f0 (full-adder c0 x0 y0))
         (s0 (first f0))
         (c1 (second f0))
         (f1 (full-adder c1 x1 y1))
         (s1 (first f1))
         (c2 (second f1)))
    (list (list s0 s1) c2)))

(defproperty adder2-ok
  (c0 :value (random-bit)
   x0 :value (random-bit)
   x1 :value (random-bit)
   y0 :value (random-bit)
   y1 :value (random-bit))
  (let* ((a (adder2 c0 (list x0 x1) (list y0 y1)))
         (s (first a)) (c (second a)))
    (= (num (append s (list c)))
            (+ (num (list c0)) (num (list x0 x1)) 
               (num (list y0 y1))))))

(defun adder (c0 x y)
  (if (and (consp x) (consp y))
      (let* ((x0 (first x)) (xs (rest x)) 
             (y0 (first y)) (ys (rest y))
             (a0 (full-adder c0 x0 y0))
             (s0 (first a0)) (c1 (second a0))
             (a  (adder c1 xs ys)) 
             (ss (first a)) (c (second a)))
        (list (cons s0 ss) c)) ; add1
      (list nil c0)))          ; add0

(defproperty adder-ok
  (c0 :value (random-bit)
   x  :value (random-list-of (random-bit))
   y  :value (random-list-of (random-bit)))
  (implies (= (len x) (len y))
           (let* ((a (adder c0 x y))
                  (s (first a)) (c (second a)))
             (= (num (append s (list c)))
                    (+ (num (list c0)) (num x) (num y))))))