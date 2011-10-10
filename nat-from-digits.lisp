(include-book "doublecheck" :dir :teachpacks)
(include-book "arithmetic-3/top" :dir :system)
(include-book "arithmetic-3/floor-mod/floor-mod" :dir :system)

; from exponentiation.lisp
(defun pow (b n)
  (if (zp n)
      1
      (* b (pow b (1- n)))))

(defun nat-from-digits-r (b ds n)
  (if (consp ds)
   (+ (* (pow b n) (first ds))
      (nat-from-digits-r b (rest ds) (1+ n)))
   0))

(defun nat-from-digits (b ds)
  (nat-from-digits-r b ds 0))

(defun horners-rule (b ds)
  (if (consp ds)
      (+ (first ds) (* b (horners-rule b (rest ds))))
      0))

(defun valid-digitsp (b ds)
  (or (endp ds)
      (let ((d (first ds)))
        (and (integerp d) (>= d 0) (< d b) 
             (valid-digitsp b (rest ds))))))

;(defproperty horners-rule-works
;  (b :where (not (zp b))
;     :value (random-natural)
;   ds :where (valid-digitsp b ds)
;      :value (random-list-of (random-between 0 (1- b))))
;  (= (nat-from-digits b ds)
;     (horners-rule b ds)))

(defun num (ds) (horners-rule 2 ds))

(defun bits (n)
  (if (and (integerp n) (> n 0))
      (cons (mod n 2)
            (bits (floor n 2)))
      nil))

(defproperty num-inverts-bits
  (n :where (natp n) :value (random-natural))
  (= (num (bits n)) n))

(defun all-bitsp (ds)
  (if (endp ds)
      t
      (and (or (= (first ds) 0)
               (= (first ds) 1))
           (all-bitsp (rest ds)))))

(defproperty bits-reutrns-all-bits
  (n :where (natp n) :value (random-natural))
  (all-bitsp (bits n)))

;(defproperty len-bits<=
;  (w :where (and (integerp w) (> w 0)) :value (random-data-size)
;   n :where (and (< n (pow 2 w))
;                 (natp n))
;     :value (random-natural))
;  (<= (len (bits n)) w))
;
;(defproperty len-bits
;  (w :where (natp w) :value (+ 1 (random-data-size))
;   n :where (and (<= (pow 2 (- w 1)) n)
;                 (< n (pow 2 w))
;                 (natp n))
;     :value (random-natural))
;  (= (len (bits n)) w))

(defun fin (xs)
  (if (endp (rest xs))
      (first xs)
      (fin (rest xs))))

(defproperty higest-bit-is-1
  (n :where (and (natp n) (> n 0)) :value (+ 1 (random-natural)))
  (= (fin (bits n)) 1))

;; honors s 11 > Lecture 20 > Slide 2
;; pad
;; len-pad-equals-w
;; prefix
;; mod