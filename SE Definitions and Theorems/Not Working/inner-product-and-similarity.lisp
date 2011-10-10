(in-package "ACL2")

(defun legit (x) ; x in {-100, -99, ... 100} - {0}
  (and (integerp x) (/= x 0) (<= (abs x) 100)))
(defun ip (xs ys) ; inner product, nil if bad data
  (cond ((and (consp xs)
              (consp ys)
              (legit (car xs)) ; ensure in-range measurements
              (legit (car ys)))    (+ (* (car xs) (car ys))
                                      (ip (cdr xs) (cdr ys))))
        ((and (endp xs) (endp ys)) 0) ; ensure vectors have same len
        (T                         nil)))
(defun inner-product (xs ys) ; nil if no angle or out-of-range meas
  (and (consp (cdr xs))      ; ensure vector len is two or more
       (ip xs ys)))
(defun sim (xs ys) ; "signed" square of cos of angle between xs & ys
  (let* ((ip (inner-product xs ys)))
    (and ip        ; ensure xs & ys are measurement vectors
         (/ (if (< ip 0)
                (- (* ip ip)) ; negate square if cos is negative
                (* ip ip))
            (* (inner-product xs xs) ; Euclidean lengths squared
               (inner-product ys ys))))))

(defun scale (s xs) ; scale components by factor s
  (if (endp xs)
      nil
      (cons (* s (car xs))
            (scale s (cdr xs)))))