(include-book "doublecheck" :dir :teachpacks)
(include-book "arithmetic-3/top" :dir :system)
(include-book "arithmetic-3/floor-mod/floor-mod" :dir :system)

;; Midterm 2 F10

(defun add (n m)
  (if (zp n)
      m
      (add (- n 1) (+ m 1))))

(defproperty add=+
  (n :where (natp n) :value (random-natural)
   m :where (natp m) :value (random-natural))
  (= (add n m) (+ n m)))

(defun mul (n m)
  (if (zp n)
      0
      (add m (mul (- n 1) m))))

(defproperty mul=*
  (n :where (natp n) :value (random-between 0 50)
   m :where (natp m) :value (random-between 0 50))
  (= (mul n m) (* n m)))

(defun drop-last (xs)
  (declare (xargs :guard (true-listp xs)))
  (if (endp (rest xs))
      nil
      (cons (first xs) (drop-last (rest xs)))))

(defproperty drop-last-type
  (xs :where (or (consp xs) (endp xs))
      :value (random-list-of (random-atom)))
  (true-listp (drop-last xs)))

(defun middle (xs)
  (if (endp (rest xs))
      (first xs)
      (middle (drop-last (rest xs)))))

;(defproperty m-selects-middle-of-odd-list
;  (xs :where (and (oddp (len xs)))
;      :value (random-list-of (random-integer)))
;  (= (middle xs) (nth (floor (len xs) 2) xs)))

;; Final F10

(defun rep (n x)
  (if (zp n)
      ()
      (cons x (rep (- n 1) x))))

(defproperty rep-len
  (n :value (random-data-size)
   x :value (random-atom))
  (= (len (rep n x)) (nfix n)))

(defproperty append-xs-nil
  (xs :where (true-listp xs)
      :value (random-list-of (random-atom)))
  (equal (append xs nil) xs))

(defun num (xs)
  (if (endp xs)
      0
      (+ (first xs) (* 2 (num (rest xs))))))

(defproperty terminal-0-doesnt-affect-value
  (xs :value (random-list-of (random-between 0 1)))
  (= (num (append xs (list 0))) (num xs)))

(defproperty terminal-zeros-dont-affect-value
  (xs :value (random-list-of (random-between 0 1))
   n  :value (random-data-size))
  (= (num (append xs (rep n 0))) (num xs)))

(defun bits (n)
  (if (zp n)
      ()
      (cons (mod n 2) (bits (floor n 2)))))

(defun rac (xs)
  (if (endp (rest xs))
      (first xs)
      (rac (rest xs))))

(defproperty most-significant-bit-is-1
  (n :where (natp (- n 1))
     :value (random-natural))
  (= (rac (bits n)) 1))

;; Final S10

(defun replace-with-ones (xs)
  (if (endp xs)
      ()
      (cons 1 (replace-with-ones (rest xs)))))

(defun sum (xs)
  (if (endp xs)
      0
      (+ (first xs) (sum (rest xs)))))

(defproperty sum-replace-with-ones=len
  (xs :value (random-list-of (random-atom)))
  (= (sum (replace-with-ones xs)) (len xs)))

(defun down-from (n)
  (if (zp n)
      ()
      (cons n (down-from (- n 1)))))

(defproperty sum-of-first-n-naturals
  (n :where (natp n)
     :value (random-data-size))
  (= (* 2 (sum (down-from n))) (* n (+ n 1))))

(defun decrement (xs)
  (cond ((endp xs) nil)
        ((= (first xs) 1) (cons 0 (rest xs)))
        ((= (first xs) 0) (cons 1 (decrement (rest xs))))))

(defun sub (xs ys)
  (declare (xargs :measure (+ (len xs) (len ys))))
  (if (endp ys)
      xs
      (let ((xy (list (first xs) (first ys))))
        (cond ((equal xy '(0 0))
               (cons 0 (sub (rest xs) (rest ys))))
              ((equal xy '(1 1))
               (cons 0 (sub (rest xs) (rest ys))))
              ((equal xy '(1 0))
               (cons 1 (sub (rest xs) (rest ys))))
              ((equal xy '(0 1))
               (cons 1 (sub (decrement (rest xs)) (rest ys))))))))

(defproperty sub-subtracts-n-from-2n
  (n :where (natp n)
     :value (random-natural))
  (= (num (sub (bits (* 2 n)) (bits n))) n))

;; Midterm 2 Fall 09

(defun release (xs)
  (declare (xargs :guard (= (len xs) 1)))
  (first xs))

(defproperty release-type
  (xs :where (= (len xs) 1)
      :value (list (random-atom)))
  (equal (release xs) (first xs)))

(defun s (xs)
  (declare (xargs :measure (len xs)))
  (if (endp (rest xs))
      nil
      (s (cons (+ (* 2 (first xs)) (second xs)) (rest (rest xs))))))

;; Final Fall 09

(defun log-2 (n)
  (if (zp (- n 1))
      0
      (+ 1 (log-2 (floor n 2)))))

;(defproperty log-2-reverses-expt-2
;  (n :where (natp n)
;     :value (random-natural))
;  (= (log-2 (expt 2 n)) n))

;(defproperty log-2-preserves-order
;  (n :where (natp (- n 1))
;     :value (random-natural)
;   m :where (and (natp m) (>= m n))
;     :value (+ (random-natural) n))
;  (>= (log-2 m) (log-2 n)))

;(defun pow (xs ys)
;  (if (endp ys)
;      (list 1)
;      (if (= (first ys) 0)
;          (pow (mul-num xs xs) (rest ys))
;          (mul-num xs (pow (mul-num xs xs) (rest ys))))))
;
;(defproperty pow-works
;  (xs :value (random-list-of (random-between 0 1))
;   ys :value (random-list-of (random-between 0 1)))
;  (= (num (pow xs ys)) (expt (num xs) (num ys))))

;; Midterm 2 Spring 09

(defun left (x y)
  (declare (ignore y)) x)

(defun zip-with-left (xs ys)
  (if (or (endp xs) (endp ys))
      ()
      (cons (left (first xs) (first ys))
            (zip-with-left (rest xs) (rest ys)))))

(defproperty zip-with-left=xs
  (xs :where (true-listp xs)
      :value (random-list-of (random-atom))
   ys :where (and (true-listp ys)
                  (= (len xs) (len ys)))
      :value (random-list-of (random-atom)))
  (equal (zip-with-left xs ys) xs))

(defproperty sum-rep=*
  (n :where (natp n) :value (random-natural)
   r :value (random-rational))
  (= (sum (rep n r)) (* n r)))

(defun foldl+ (z xs)
  (if (endp xs)
      z
      (foldl+ (+ z (first xs)) (rest xs))))

(defun foldr+ (z xs)
  (if (endp xs)
      z
      (+ z (foldr+ z (rest xs)))))

;(defproperty foldl+-foldr+-equiv
;  (xs :value (random-list-of (random-number))
;   z  :value (random-number))
;  (= (foldl+ z xs) (foldr+ z xs)))

;; Final S09

(defun snoc (xs x)
  (if (endp xs)
      (list x)
      (cons (first xs) (snoc (rest xs) x))))

(defproperty snoc-rac-identity
  (xs :value (random-list-of (random-atom))
   x  :value (random-atom))
  (equal (rac (snoc xs x)) x))

(defun between (m n)
  (declare (xargs :measure (nfix n)))
  (if (or (zp (+ n (- m))) (not (natp m)) (not (natp n)))
      nil
      (cons n (between m (- n 1)))))

(defproperty between-length
  (m :where (natp m)
     :value (random-natural)
   n :where (natp n)
     :value (random-natural))
  (= (len (between m (+ m n))) n)
  :hints (("Goal" :induct (rep n 0))))

(defun downp (xs)
  (if (endp (rest (rest xs)))
      t
      (and (= (first xs) (+ (second xs) 1))
           (downp (rest xs)))))

;(defproperty between-descending
;  (m :where (natp m)
;     :value (random-natural)
;   n :where (natp n)
;     :value (random-natural))
;  (downp (between m (+ m n)))
;  :hints (("Goal" :induct (rep n 0))))

(defproperty sub-n-n=0
  (n :value (random-natural))
  (= (num (sub (bits n) (bits n))) 0))

;(defproperty sub-n-1-decrements
;  (n :where (and (natp n) (>= n 1))
;     :value (random-natural))
;  (= (num (sub (bits n) '(1))) (- n 1)))

;; Mid2 Fall 08



()

















