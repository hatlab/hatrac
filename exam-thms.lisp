(include-book "doublecheck" :dir :teachpacks)
(include-book "arithmetic-3/top" :dir :system)
(include-book "arithmetic-3/floor-mod/floor-mod" :dir :system)


(defun bitp (x) (or (= x 0) (= x 1)))

(defun bit-listp (xs)
  (or (endp xs)
      (and (bitp (first xs)) (bit-listp (rest xs)))))

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
      nil
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

(defproperty bits-returns-bitlist
  (n :value (random-natural))
  (bit-listp (bits n)))

(defun binary-zerop (xs)
  (or (endp xs)
      (and (= 0 (first xs))
           (binary-zerop (rest xs)))))

(defproperty decrement-works
  (xs :where (and (bit-listp xs) (not (binary-zerop xs)))
      :value (random-list-of (random-between 0 1)))
  (= (+ 1 (num (decrement xs))) (num xs)))

(defproperty sub-n-1-decrements-lemma
  (xs :where (and (bit-listp xs) (not (binary-zerop xs)))
      :value (random-list-of (random-between 0 1)))
  (= (num (sub xs '(1))) (- (num xs) 1)))

(defproperty bits->0-returns-nonzero-bitlist
  (n :where (and (natp n) (> n 0))
     :value (random-natural))
  (not (binary-zerop (bits n))))

(defproperty sub-n-1-decrements
  (n :where (and (natp n) (>= n 1))
     :value (random-natural))
  (= (num (sub (bits n) '(1))) (- n 1)))

;; Mid2 Fall 08

(defun cons-left (x xs ys)
  (mv (cons x xs) ys))

(defun split-at (n xs)
  (cond ((endp xs) (mv nil nil))
        ((zp n) (mv nil xs))
        (t (mv-let (left right) (split-at (- n 1) (rest xs))
                   (cons-left (first xs) left right)))))

(defproperty split-at-len-xs
  (xs :where (true-listp xs)
      :value (random-list-of (random-natural))
   ys :where (true-listp ys)
      :value (random-list-of (random-natural)))
  (equal (split-at (len xs) (append xs ys)) (mv xs ys)))

(defun prefix-match (xs ys)
  (cond ((endp xs) (mv nil nil ys))
        ((endp ys) (mv xs nil nil))
        ((/= (first xs) (first ys)) (mv nil xs ys))
        (t (mv-let (one two three)
                   (prefix-match (rest xs) (rest ys))
                   (mv (cons (first xs) one) two three)))))

(defproperty prefix-match-prefixed-list
  (xs :where (true-listp xs)
      :value (random-list-of (random-natural))
   ys :where (true-listp ys)
      :value (random-list-of (random-natural)))
  (equal (prefix-match xs (append xs ys))
         (mv xs nil ys)))

;; Final Fall 08

(defun dup (x) (list x x))

(defun map-dup (xs)
  (if (endp xs)
      ()
      (cons (dup (first xs)) (map-dup (rest xs)))))

(defun concat (xss)
  (if (endp xss)
      ()
      (append (first xss) (concat (rest xss)))))

(defproperty map-dup-doubles-length-concat
  (xs :value (random-list-of (random-natural)))
  (= (len (concat (map-dup xs))) (* 2 (len xs))))

(defun increment (xs)
  (if (endp xs)
      (list 1)
      (if (= (first xs) 0)
          (cons 1 (rest xs))
          (cons 0 (increment (rest xs))))))

(defproperty increment-works-lemma
  (xs :where (bit-listp xs)
      :value (random-list-of (random-between 0 1)))
  (= (num (increment xs)) (+ 1 (num xs))))

(defproperty increment-works
  (n :where (natp n) :value (random-natural))
  (= (num (increment (bits n))) (+ n 1)))

;; (sum xs) defined previously

(defun nats-up-to (n)
  (if (zp n)
      nil
      (cons n (nats-up-to (- n 1)))))

(defproperty sum-of-nats
  (n :where (natp n) :value (random-natural))
  (= (sum (nats-up-to n))
     (* n (+ n 1) 1/2)))

;; Mid2 Spring 08

(defproperty nats-up-to-length
  (n :where (natp n) :value (random-natural))
  (= (len (nats-up-to n))
     n))

(defun double (x) (* 2 x))

(defun double-and-cons (x xs)
  (cons (double x) xs))

(defun map-double (xs)
  (if (endp xs)
      nil
      (cons (double (first xs))
            (map-double (rest xs)))))

(defun foldr-double-and-cons (xs)
  (if (endp xs)
      nil
      (double-and-cons (first xs)
                       (foldr-double-and-cons (rest xs)))))

(defproperty map-double=foldr-double-and-cons
  (xs :value (random-list-of (random-integer)))
  (equal (map-double xs)
         (foldr-double-and-cons xs)))

;; Final Spring 08

;; (all covered elsewhere)

;; Mid2 Fall 07

(defun rdc (xs)
  (if (endp (rest xs))
      nil
      (cons (first xs) (rdc (rest xs)))))

(defproperty rdc-reduces-len-by-1
  (xs :where (and (true-listp xs) (consp xs))
      :value (random-list-of (random-atom)))
  (= (len (rdc xs)) (- (len xs) 1)))

(defun bubble-step (xs)
  (if (endp (rest xs))
      xs
      (if (< (first xs) (second xs))
          (cons (first xs)
                (bubble-step (rest xs)))
          (cons (second xs)
                (bubble-step (cons (first xs)
                                   (rest (rest xs))))))))

;; rac defined previously

(defun bubble-sort (xs)
  (if (endp xs)
      xs
      (let ((bubbled (bubble-step xs)))
        (append (bubble-sort (rdc bubbled))
                (list (rac bubbled))))))

(defproperty bubble-step-preserves-length
  (xs :where (true-listp xs)
      :value (random-list-of (random-integer)))
  (= (len (bubble-step xs))
     (len xs)))

;(defproperty bubble-sort-preserves-length
;  (xs :where (and (true-listp xs) (integer-listp xs))
;      :value (random-list-of (random-integer)))
;  (= (len (bubble-sort xs))
;     (len xs)))

(defun orderedp (xs)
  (or (not (consp (rest xs))) ; (len xs) < 2
      (and (<= (first xs) (second xs))
           (orderedp (rest xs)))))

;; Stated theorem (not proven)
;(defproperty bubble-sort-sorts
;  (xs :where (true-listp xs)
;      :value (random-list-of (random-integer)))
;  (orderedp (bubble-sort xs)))

;; Final Fall 07

(defun div (num denom)
  (if (or (zp denom)
          (zp num)
          (< num denom))
      0
      (+ (div (- num denom) denom) 1)))

(defproperty div-is-positive
  (n :value (random-natural)
   b :value (random-natural))
  (>= (div n b) 0))

(defun remainder (num denom)
  (- num (* denom (div num denom))))

;(defproperty rem-between-0-and-denom
;  (n :value (random-natural)
;   b :value (random-natural))
;  (and (>= (remainder n b) 0)
;       (< (remainder n b) b)))

;; Others proved elsewhere

;; Mid2 Spring 07

(defun drop-first (n xs)
  (if (or (zp n) (endp xs))
      xs
      (drop-first (- n 1) (rest xs))))

(defproperty drop-first-over-append
  (xs :value (random-list-of (random-atom))
   ys :value (random-list-of (random-atom)))
  (equal (drop-first (len xs) (append xs ys))
         ys))

(defun take-first (n xs)
  (if (or (zp n) (endp xs))
      nil
      (cons (first xs)
            (take-first (- n 1) (rest xs)))))

(defproperty take-first-over-append
  (xs :where (true-listp xs)
      :value (random-list-of (random-atom))
   ys :value (random-list-of (random-atom)))
  (equal (take-first (len xs) (append xs ys))
         xs))

;; snoc defined previously

(defun rev (xs)
  (if (endp xs)
      xs
      (snoc (rev (rest xs)) (first xs))))

(defproperty rev-length
  (xs :value (random-list-of (random-atom)))
  (= (len (rev xs)) (len xs)))

;; Final Spring 07

(defun russian-peasant-mul (n x)
  (cond ((zp n) 0)
        ((oddp n) (+ x (russian-peasant-mul (/ (- n 1) 2)
                                            (+ x x))))
        ((evenp n) (russian-peasant-mul (/ n 2)
                                        (+ x x)))))

(defproperty russian-peasant-mul=n*x
  (n :where (natp n) :value (random-natural)
   x :where (rationalp x) :value (random-rational))
  (= (russian-peasant-mul n x) (* n x)))

(defun insert (x ys)
  (cond ((endp ys) (list x))
        ((<= x (first ys)) (cons x ys))
        (t (cons (first ys) (insert x (rest ys))))))

(defproperty insert-len
  (x :where (rationalp x) :value (random-rational)
   ys :value (random-list-of (random-rational)))
  (= (len (insert x ys)) (+ 1 (len ys))))

;; (orderedp (insert-sort xs)) proved in sorting.lisp

;; Mid2 Fall 06

(defun mem (e xs)
  (if (endp xs)
      nil
      (or (equal e (first xs))
          (mem e (rest xs)))))

(defproperty mem-rep
  (x :value (random-atom)
   e :value (random-element-of (list (random-atom) x))
   n :value (random-natural))
  (implies (mem e (rep n x)) (equal e x))
  :rule-classes nil)

;; Final F06 (MISSING)

;; Mid2 S06

(defun chop (n z xs)
  (cond ((zp n) nil)
        ((endp xs) (cons z (chop (- n 1) z xs)))
        (t (cons (first xs) (chop (- n 1) z (rest xs))))))

(defproperty chop-len
  (n :where (natp n) :value (random-natural)
   z :value (random-atom)
   xs :value (random-list-of (random-atom)))
  (= (len (chop n z xs)) n))

;; Final S06

;; rac defined earlier

(defun append-reverse (xs ys)
  (if (endp xs)
      ys
      (append-reverse (rest xs) (cons (first xs) ys))))

(defproperty append-reverse-first-element
  (xs :value (random-list-of (random-atom))
      :where (consp xs)
   ys :value (random-list-of (random-atom)))
  (equal (car (append-reverse xs ys))
         (rac xs)))

(defproperty append-reverse-works
  (xs :value (random-list-of (random-atom))
   ys :value (random-list-of (random-atom)))
  (equal (append-reverse xs ys)
         (append (rev xs) ys)))

(defun size (tree)
  (if (endp tree)
      0
      (+ (size (third tree))
         1
         (size (fourth tree)))))

(defun flatten (tree)
  (if (endp tree)
      nil
      (append (flatten (third tree))
              (list (first tree))
              (flatten (fourth tree)))))

(defrandom random-tree-size (size)
  (cond ((zp size) nil)
        ((random-boolean) nil)
        (t (list (random-rational)
              (random-atom)
              (random-tree-size (- size 1))
              (random-tree-size (- size 1))))))

(defrandom random-tree ()
  (random-tree-size (random-data-size)))

(defthm flatten-lemma
   (true-listp (flatten tree)))

(defthm flatten-lemma2
   (= (len (append xs (list x) ys))
      (+ (len xs) (len ys) 1)))

;(defthm flatten-lemma3
;   (implies (consp tree)
;            (= (len (flatten tree))
;               (+ 1 (len (flatten (third tree)))
;                    (len (flatten (fourth tree)))))))

(defproperty flatten-has-size-elems
  (tree :value (random-tree))
  (= (len (flatten tree))
     (size tree)))

(defun del (e xs)
  (cond ((endp xs) nil)
        ((equal (first xs) e) (del e (rest xs)))
        (t (cons (first xs) (del e (rest xs))))))

(defun in (e xs)
  (if (endp xs)
      nil
      (or (equal (first xs) e)
          (in e (rest xs)))))

(defproperty del-works
  (xs :value (random-list-of (random-natural))
   e :value (random-natural))
  (not (in e (del e xs))))

;; Spring 05

;; Mid2

(defproperty double-distributes-over-sum
  (xs :value (random-list-of (random-rational)))
  (= (sum (map-double xs))
     (double (sum xs))))

;(defproperty maximum-binary-numeral
;  (n :value (random-natural)
;     :where (natp n))
;  (> (expt 2 (len (bits n))) n))

;; Final

(defun foldr-cons (x ys)
  (if (endp ys)
      x
      (cons (first ys) (foldr-cons x (rest ys)))))

(defproperty append-using-foldr-cons
  (xs :value (random-list-of (random-atom))
   ys :value (random-list-of (random-atom)))
  (equal (foldr-cons ys xs)
         (append xs ys)))

(defproperty insert-type
  (x :value (random-rational)
   xs :value (random-list-of (random-rational)))
  (implies (true-listp xs)
           (true-listp (insert x xs))))

(defproperty first-insert-<=-inserted-elem
  (x :value (random-rational)
   xs :value (random-list-of (random-rational)))
  (<= (first (insert x xs))
      x))

(defproperty insert-increments-length
  (x :value (random-rational)
   xs :value (random-list-of (random-rational)))
  (= (len (insert x xs))
     (+ 1 (len xs))))

(defun flatten-tail (tree xs)
  (if (endp tree)
      xs
      (flatten-tail (third tree)
                    (cons (first tree)
                          (flatten-tail (fourth tree) xs)))))

(defproperty flatten-tail-length
  (tree :value (random-tree)
   xs :value (random-list-of (random-atom)))
  (= (len (flatten-tail tree xs))
     (+ (size tree) (len xs))))

;; Fall 04

;; Mid2

(defun replace-with (xs c)
  (if (endp xs)
      nil
      (cons c (replace-with (rest xs) c))))

(defproperty len-same-as-sum-replace-with-1
  (xs :value (random-list-of (random-atom)))
  (= (sum (replace-with xs 1))
     (len xs)))

(defun inc (k)
  (+ k 1))

(defproperty inc-type
  (k :value (random-rational))
  (implies (rationalp k)
           (rationalp (inc k))))

;; Final

(defun sumr (z xs)
  (if (endp xs)
      z
      (sumr (+ z (first xs)) (rest xs))))

(defproperty sumr-type
  (z :value (random-rational)
   xs :value (random-list-of (random-rational)))
  (implies (and (rationalp z)
                (rational-listp xs))
           (rationalp (sumr z xs))))

(defun ps-+ (z xs)
  (if (endp xs)
      (list z)
      (cons z (ps-+ (+ z (first xs)) (rest xs)))))

(defproperty ps-len
  (z :value (random-rational)
   xs :value (random-list-of (random-rational)))
  (= (len (ps-+ z xs))
     (+ 1 (len xs))))

;(defproperty rac-ps-+-=-sum
;  (xs :value (random-list-of (random-rational))
;      :where (rational-listp xs))
;  (= (rac (ps-+ 0 xs))
;     (sumr 0 xs)))

(defun key-in-tree (e tree)
  (if (endp tree)
      nil
      (or (equal e (first tree))
          (key-in-tree e (third tree))
          (key-in-tree e (fourth tree)))))

(defproperty in-tree-implies-in-flatten-tree
  (tree :value (random-tree)
   e :value (random-natural))
  (implies (key-in-tree e tree)
           (member e (flatten tree))))

;; Fall 03

;; Mid2

(defun double-second (x y)
  (declare (ignore x))
  (* 2 y))

(defun foldr-d (k xs)
  (if (endp xs)
      k
      (double-second (first xs)
                     (foldr-d k (rest xs)))))

(defproperty foldr-d=expt-2
  (xs :value (random-list-of (random-rational)))
  (= (foldr-d 1 xs)
     (expt 2 (len xs))))

(defun map-sqr (xs)
  (if (endp xs)
      nil
      (cons (* (first xs) (first xs))
            (map-sqr (rest xs)))))

(defun zip-with-* (xs ys)
  (if (or (endp xs) (endp ys))
      nil
      (cons (* (first xs) (first ys))
            (zip-with-* (rest xs) (rest ys)))))

(defproperty map-sqr=zip-with-*
  (xs :value (random-list-of (random-natural)))
  (equal (map-sqr xs)
         (zip-with-* xs xs)))

;; Final

(defun add-back (xs ys)
  (if (endp xs)
      ys
      (add-back (rest xs)
                (cons (first xs) ys))))

(defproperty add-back-len-additive
  (xs :value (random-list-of (random-natural))
   ys :value (random-list-of (random-natural)))
  (= (len (add-back xs ys))
     (+ (len xs) (len ys))))

(defproperty first-add-back-nil-ys-is-y
  (ys :value (random-list-of (random-natural)))
  (equal (first (add-back nil ys))
         (first ys)))

(defproperty first-add-back-xs-ys-is-rac-xs
  (xs :value (random-list-of (random-natural))
   ys :value (random-list-of (random-natural)))
  (implies (consp xs)
           (equal (first (add-back xs ys))
                  (rac xs))))

; Node format: (cons left right) or just a character
(defun decode (tree bs)
  (cond ((atom tree) tree)
        ((endp bs) nil)
        ((first bs) (decode (car tree) (rest bs)))
        (t (decode (cdr tree) (rest bs)))))

(defun code-tree-has (tree letter)
  (if (atom tree)
      (eql tree letter)
      (or (code-tree-has (car tree) letter)
          (code-tree-has (cdr tree) letter))))

(defrandom random-code-tree ()
  (cons #\a #\b))

;(defproperty code-tree-has->path-exists
;  (tree :value (random-code-tree)
;   letter :value (random-char)
;   bs :value (random-list-of (random-boolean)))
;  (implies (code-tree-has tree letter)
;           (eql (decode tree bs)
;                letter)))

;; Spring 03

(defun map-len (xs)
  (if (endp xs)
      nil
      (cons (len (first xs))
            (map-len (rest xs)))))

(defproperty map-len-simple
  (a :value (random-atom))
  (equal (map-len (list nil (cons a nil) nil))
         (list 0 (+ 1 0) 0)))

(defproperty rac-=-nth-len
  (xs :value (random-list-of (random-atom)
                             :size (1+ (random-data-size))))
  (equal (nth (1- (len xs)) xs)
         (rac xs)))

(defproperty take-first-len
  (xs :value (random-list-of (random-atom))
   n :value (random-data-size)
     :where (natp n))
  (<= (len (take-first n xs))
      n))

(defproperty rev-member
  (xs :value (random-list-of (random-rational))
   e :value (random-rational))
  (iff (member e (rev xs))
       (member e xs)))

(defun throdds (xs)
  (cond ((endp xs) nil)
        ((endp (rest xs)) nil)
        ((endp (rest (rest xs))) nil)
        (t (cons (third xs)
                 (throdds (rest (rest (rest xs))))))))

;(defproperty len-throdds
;  (xs :value (random-list-of (random-atom)
;                             :size (* 3 (random-data-size))))
;  (implies (= (mod (len xs) 3) 0)
;           (= (len (throdds xs))
;              (floor (len xs) 3))))

(defun sum-tree (tree)
  (if (endp tree)
      0
      (+ (sum-tree (third tree))
         (first tree)
         (sum-tree (fourth tree)))))

(defrandom random-rational-tree-size (size)
  (cond ((zp size) nil)
        ((random-boolean) nil)
        (t (list (random-rational)
              (random-rational)
              (random-rational-tree-size (- size 1))
              (random-rational-tree-size (- size 1))))))

(defrandom random-rational-tree ()
  (random-rational-tree-size (random-data-size)))

(defproperty sum-tree=sum-flatten-tree
  (tree :value (random-rational-tree))
  (= (sum-tree tree)
     (sum (flatten tree))))

;; Fall 02

;; Mid2

(defun foldr- (z xs)
  (if (endp xs)
      z
      (- (first xs) (foldr- z (rest xs)))))

(defproperty foldr-minus-test
  (x :value (random-rational)
   y :value (random-rational)
   z :value (random-rational))
  (= (foldr- 0 (list x y z))
     (+ (- x y) z)))

(defun filter-with (bs xs)
  (if (or (endp bs) (endp xs))
      nil
      (if (first bs)
          (cons (first xs) (filter-with (rest bs) (rest xs)))
          (filter-with (rest bs) (rest xs)))))

(defproperty filter-with-type
  (bs :value (random-list-of (random-boolean))
   xs :value (random-list-of (random-atom)))
  (true-listp (filter-with bs xs)))

(defun cc (xs)
  (if (endp xs)
      nil
      (cons (first xs)
            (cons (first xs)
                  (cc (rest xs))))))

(defproperty cc-len
  (xs :value (random-list-of (random-atom)))
  (= (len (cc xs))
     (* 2 (len xs))))

(defproperty drop-first-len
  (xs :value (random-list-of (random-atom))
   n :value (random-natural)
     :where (natp n))
  (>= (len (drop-first n xs))
      (- (len xs) n)))

;; Final

(defun swap-first-two (xs)
  (if (endp (rest xs))
      xs
      (cons (second xs)
            (cons (first xs)
                  (rest (rest xs))))))

(defproperty swap-first-two-reverses-itself
  (xs :value (random-list-of (random-atom)
                             :size (+ 2 (random-data-size))))
  (equal (swap-first-two (swap-first-two xs))
         xs))

(defrandom random-ordered-list-size (size prev)
  (if (zp size)
      0
      (let ((next (+ prev (random-data-size))))
        (cons next
              (random-ordered-list-size (- size 1) next)))))

(defrandom random-ordered-list ()
  (random-ordered-list-size (random-data-size) 0))

(defun big-max (xs)
  (if (endp (rest xs))
      (first xs)
      (max (first xs)
           (big-max (rest xs)))))

(defun big-min (xs)
  (if (endp (rest xs))
      (first xs)
      (min (first xs)
           (big-min (rest xs)))))

(defproperty ordered-lists-append
  (xs :value (random-ordered-list)
      :where (orderedp xs)
   ys :value (random-ordered-list)
      :where (orderedp ys))
  (implies (< (big-max xs) (big-min ys))
           (orderedp (append xs ys))))

(defun min-key (tree)
  (if (endp tree)
    tree
    (min (first tree)
         (min 
           (if (endp (third tree))
             (first tree)
             (min-key (third tree)))
           (if (endp (fourth tree))
             (first tree)
             (min-key (fourth tree)))))))

(defun max-key (tree)
  (if (endp tree)
    tree
    (max (first tree)
         (max
           (if (endp (third tree))
             (first tree)
             (max-key (third tree)))
           (if (endp (fourth tree))
             (first tree)
             (max-key (fourth tree)))))))

(defun searchablep (tree)
  (or (endp tree)
      (and (or (endp (fourth tree))
               (< (first tree) (min-key (fourth tree))))
           (or (endp (third tree))
               (> (first tree) (max-key (third tree))))
           (searchablep (third tree))
           (searchablep (fourth tree)))))

(defun keys (tree)
  (if (endp tree)
      nil
      (append (keys (third tree))
              (first tree)
              (keys (fourth tree)))))

;(defthm searchable-implies-keys-ordered
;  (implies (searchablep tree)
;           (orderedp (keys tree))))

;; Fall 01

;; no new theorems

;; Fall 00

;; no new theorems



















