(in-package "ACL2")

(defun inner-product (xs ys)
  (if (consp xs) 
      (if (consp ys)
          (if (and (acl2-numberp (car xs)) (acl2-numberp (car ys)))
              (let* ((ip (inner-product (cdr xs) (cdr ys))))
                (if (acl2-numberp ip)
                    (+ (* (car xs) (car ys)) ip)
                    nil))
              nil)
          nil)
      (if (consp ys)
          nil
          0)))

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
    (if (acl2-numberp ip)        ; ensure xs & ys are measurement vectors
        (/ (* ip (abs ip))
           (* (inner-product xs xs) ; Euclidean lengths squared
              (inner-product ys ys)))
        nil)))

(defun scale (s xs) ; scale components by factor s
  (if (endp xs)
      nil
      (cons (* s (car xs))
            (scale s (cdr xs)))))

(defun multiply (xs ys)
  (if (or (endp xs) (endp ys))
      nil
      (cons (* (car xs) (car ys)) (multiply (cdr xs) (cdr ys)))))
      
(defun sum-list (xs)
  (if (endp xs)
      0
      (+ (car xs) (sum-list (cdr xs)))))

(defun zero-vectorp (xs)
  (if (endp xs)
      (endp xs)
      (and (equal (car xs) 0) (zero-vectorp (cdr xs)))))