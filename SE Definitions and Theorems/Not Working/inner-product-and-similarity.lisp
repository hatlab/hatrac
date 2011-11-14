(in-package "ACL2")

(defun inner-product (xs ys)
  (if (and (consp xs) (consp ys)
           (rationalp (car xs)) (rationalp (car ys)))
      (+ (* (car xs) (car ys))
         (inner-product (cdr xs) (cdr ys)))
      0))

;(defun inner-product (xs ys) ; inner product, nil if bad data
;  (cond ((and (consp xs)
;              (consp ys)
;              (legit (car xs)) ; ensure in-range measurements
;              (legit (car ys)))    (+ (* (car xs) (car ys))
;                                      (inner-product (cdr xs) (cdr ys))))
;        ((or (endp xs) (endp ys)) 0)
;        (t nil)))

;(defun abs (val)
 ; (if (< val 0)
  ;    (- val)
   ;   val))

(defun sim (xs ys) ; "signed" square of cos of angle between xs & ys
  (let* ((ip  (inner-product xs ys))
         (xs2 (inner-product xs xs))
         (ys2 (inner-product ys ys)))
    (if (and (/= xs2 0) (/= ys2 0))
        (/ (* ip (abs ip)) (* xs2 ys2))
        0)))

(defun scale (s xs) ; scale components by factor s
  (if (consp xs)
      (cons (* s (car xs))
            (scale s (cdr xs)))
      nil))

(defun multiply (xs ys)
  (if (and (consp xs) (consp ys))
      (cons (* (car xs) (car ys)) (multiply (cdr xs) (cdr ys)))
      nil))
      
(defun sum-list (xs)
  (if (consp xs)
      (+ (car xs) (sum-list (cdr xs)))
      0))

(defun zero-vectorp (xs)
  (if (consp xs)
      (and (equal (car xs) 0) (zero-vectorp (cdr xs)))
      t))