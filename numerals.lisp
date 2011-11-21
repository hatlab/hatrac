(in-package "ACL2")

(include-book "doublecheck" :dir :teachpacks)

(include-book "append")

(include-book "arithmetic-3/top" :dir :system)
(include-book "arithmetic-3/floor-mod/floor-mod" :dir :system)

(defun nat-from-digits-r (b ds n)
  (if (consp ds)
   (+ (* (expt b n) (first ds))
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
;  (b :where (and (>= b 2) (integerp b))
;     :value (random-natural)
;   ds :where (valid-digitsp b ds)
;      :value (random-list-of (random-between 0 (1- b))))
;  (= (nat-from-digits b ds)
;     (horners-rule b ds)))

(defun num (x) ; number denoted by binary numeral x
  (if (consp x)
      (if (= (first x) 1)
          (+ 1 (* 2 (num (rest x))))
          (* 2 (num (rest x))))
      0))
(defproperty num-times-2-preserves-positive
  (bs :value (random-list-of (random-between 0 1)))
  (implies (> (num (cons 0 bs)) 0) (> (num bs) 0)))

(defun d (bs)
  (cond ((endp bs)
         nil)
        ((= (first bs) 0)
         (cons 1 (d (rest bs))))
        (t
         (cons 0 (rest bs)))))

(defun bitp (b)
  (or (= b 0) (= b 1)))

(defun bit-listp (xs)
  (or (endp xs)
      (and (bitp (first xs))
           (bit-listp (rest xs)))))

(defproperty d-decrements-value-of-bs
  (bs :where (and (bit-listp bs) (> (num bs) 0))
      :value (random-list-of (random-between 0 1)))
  (= (num (d bs)) (- (num bs) 1)))

(defun s (bs n)
  (if (zp n)
      bs
      (s (cons 0 bs) (- n 1))))

(defproperty up-shift-x-n=2^n*x
  (bs :value (random-list-of (random-between 0 1))
   n  :where (natp n) :value (random-natural))
  (= (num (s bs n)) (* (expt 2 (nfix n)) (num bs))))

(defun bits (n)
  (if (and (integerp n) (> n 0))
      (cons (mod n 2)
            (bits (floor n 2)))
      nil))

(defproperty bits-ok
  (n :value (random-natural)
     :where (natp n))
  (= (num (bits n)) n))

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

;; Takes too long
;(defproperty len-bits-n+m>=len-bits-n
;  (n :where (natp n) :value (random-natural)
;   m :where (natp m) :value (random-natural))
;  (>= (len (bits (+ n m))) (len (bits n))))
;
;(defproperty len-bits<=
;  (w :where (and (integerp w) (> w 0)) :value (random-data-size)
;   n :where (and (< n (expt 2 w))
;                 (natp n))
;     :value (random-natural))
;  (<= (len (bits n)) w))
;
;(defproperty len-bits
;  (w :where (natp w) :value (+ 1 (random-data-size))
;   n :where (and (<= (expt 2 (- w 1)) n)
;                 (< n (expt 2 w))
;                 (natp n))
;     :value (random-natural))
;  (= (len (bits n)) w))

(defun fin (xs)
  (if (endp (rest xs))
      (first xs)
      (fin (rest xs))))

(defproperty hi-1
  (n :where (and (natp n) (> n 0))
     :value (+ 1 (random-natural)))
  (= (fin (bits n)) 1))

(defun rep (n x)
  (if (and (integerp n) (> n 0))
      (cons x (rep (- n 1) x))
      nil))

(defproperty len-rep
  (n :where (natp n) :value (random-data-size))
  (= (len (rep n 'x)) n))
      
(defun pad (n d ds)
  (let ((p (- n (len ds))))
    (if (>= p 0)
        (append ds (rep p d))
        (prefix n ds))))

(defproperty len-pad-n=n-left-lemma
  (xs :value (random-list-of (random-atom))
   n :where (and (>= n (len xs)) (integerp n)) :value (random-natural))
  (= (len (append xs (rep (+ n (- (len xs))) 0))) n))

(defproperty len-pad-n=n-right-lemma
  (xs :value (random-list-of (random-atom))
   n :where (and (>= n 0) (< n (len xs)) (integerp n)) :value (random-data-size))
  (= (len (pad n 0 xs)) n))

(defproperty len-pad
  (n :where (and (>= n 0) (integerp n)) :value (random-natural)
   xs :value (random-list-of (random-atom)))
  (= (len (pad n 0 xs)) n))

(defun twos (w n)
  (if (>= n 0)
      (pad w 0 (bits n))
      (bits (+ n (expt 2 w)))))

(defun in-I+ (n w)
  (and (< n (expt 2 w)) (>= n 0)))

(defun in-I- (n w)
  (and (>= n (- (expt 2 w))) (< n 0)))

(defun in-I (n w)
  (and (< n (expt 2 w))
       (>= n (- (expt 2 w)))))

(defun nats-to-zero (w)
  (if (zp w)
    0
    (nats-to-zero (- w 1))))

(defun log-2 (n)
  (if (zp n)
      0
      (+ 1 (log-2 (floor n 2)))))

(defproperty bits-len
  (n :where (natp n) :value (random-natural))
  (= (len (bits n)) (log-2 n)))

(defproperty log-2-inverts-expt-2
  (n :where (natp n)
     :value (random-natural))
  (= (- (log-2 (expt 2 n)) 1) n)
  :hints (("Goal" :induct (nats-to-zero n))))

(defproperty mod-pfx-0
  (w :where (natp w) :value (random-data-size))
  (= (num (prefix w (bits 0))) (mod 0 (expt 2 w))))

(defproperty mod-pfx->0
  (w :where (natp w) :value (random-data-size)
   n :where (and (natp n) (> n 0)) :value (random-data-size))
  (= (num (prefix w (bits 0))) (mod 0 (expt 2 w))))

;(defproperty mod-pfx
;  (w :where (natp w) :value (random-data-size)
;   n :where (natp n) :value (random-data-size))
;  (= (num (prefix w (bits n))) (mod n (expt 2 w)))
;  :hints (("Goal" :induct (nats-to-zero w))))
  

;(defproperty bounded-log-2
;  (w :where (and (natp w) (> w 0))
;     :value (+ (random-data-size) 1)
;   n :where (and (natp n)
;                 (<= (expt 2 (- w 1)) n)
;                 (< n (expt 2 w)))
;     :value (random-natural))
;  (= (log-2 n) w)
;    :hints (("Goal" :induct (nats-to-zero w))))
;
;(defproperty len-bits
;  (w :where (and (natp w) (> w 0))
;     :value (random-data-size)
;   n :where (and (natp n) (<= (expt 2 (- w 1)) n) (< n (expt 2 w)))
;     :value (mod (random-natural) (expt 2 w)))
;  (= (len (bits n)) w)
;  :hints (("Goal" :induct (nats-to-zero w))))



;(defproperty 2s-ok-1
;  (w :where (natp w) :value (random-data-size)
;   n :where (and (integerp n) (in-I+ n w))
;     :value (mod (random-natural) (expt 2 w)))
;  (= (num (twos w n)) n))

;(defproperty 2s-ok-2
;  (w :where (natp w) :value (random-data-size)
;   n :where (and (integerp n) (in-I- n w))
;     :value (- (random-natural)))
;  (= (num (twos w n)) (+ (expt 2 w) n)))

;(defproperty 2s--n
;  (w :where (natp w) :value (random-natural)
;   n :where (and (integerp n) (in-I+ n w)) :value (random-data-size))
;  (= (mod (+ (num (twos w n)) (num (twos w (- n)))) (expt 2 w)) 0))

;(defproperty 2s-arith
;  (w :where (natp w) :value (random-data-size)
;   n :where (and (integerp n) (in-I n w)) :value (random-integer)
;   m :where (and (integerp m) (in-I m w)) :value (random-integer))
;  (= (mod (+ (num (twos w n)) (num (twos w m))) (expt 2 w))
;     (mod (+ n m) (expt 2 w))))

;; Probably depends on len-pad-n=n
;(defproperty len-2s
;  (w :where (natp w) :value (random-data-size)
;   n :where (and (integerp n) (in-I n w)) :value (random-integer))
;  (= (len (twos w n)) w))

;(defproperty sign-bit
;  (w :where (natp w) :value (random-data-size)
;   n :where (and (integerp n) (in-I- n w)) :value (random-integer))
;  (= (fin (twos w n)) 1))

;(defun invert-bits (ds)
;  (if (endp ds)
;      ds
;      (cons (- 1 (car ds)) (invert-bits (cdr ds)))))

;(defproperty 2s-trick
;  (w :where (natp w) :value (random-data-size)
;   n :where (and (integerp n) (in-I+ n (- w 1))) :value (random-integer))
;  (let ((ds (twos w n)))
;    (equal (twos w (- n)) (twos w (+ 1 (num (invert-bits ds)))))))