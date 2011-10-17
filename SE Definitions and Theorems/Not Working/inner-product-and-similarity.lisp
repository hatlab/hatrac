(in-package "ACL2")

(defun legit (x) ; x in {-100, -99, ... 100} - {0}
  (rationalp x))

(defun inner-product (xs ys)
  (if (or (endp xs) (endp ys))
      0
      (if (and (legit (car xs)) (legit (car ys)))
          (+ (* (car xs) (car ys))
             (inner-product (cdr xs) (cdr ys)))
          nil)))

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
  (let* ((ip (inner-product xs ys)))
    (if ip        ; ensure xs & ys are measurement vectors
        (/ (* ip (abs ip))
           (* (inner-product xs xs) ; Euclidean lengths squared
              (inner-product ys ys)))
        nil)))

(defun scale (s xs) ; scale components by factor s
  (if (endp xs)
      nil
      (cons (* s (car xs))
            (scale s (cdr xs)))))