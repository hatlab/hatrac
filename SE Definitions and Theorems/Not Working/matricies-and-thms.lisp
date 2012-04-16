(include-book "doublecheck" :dir :teachpacks)

;(defun n-column-matrix? (m n)
;  (or (endp m)
;      (and (true-listp (car m))
;           (= (len (car m)) n)
;           (n-column-matrix? (cdr m) n))))
;
;(defun matrix? (m)
;  (n-column-matrix? m (len (car m))))

(defun matrix? (m)
  (and (true-listp m)
       (true-listp (car m))
       (or (not (consp (cdr m)))
           (and (equal (len (car m))
                       (len (cadr m)))
                (matrix? (cdr m))))))

(defun num-rows (m)
  (len m))

(defun num-cols (m)
  (len (car m)))

(defun append-to-matrix (xs m)
  (if (consp xs)
      (cons (cons (car xs) (car m))
            (append-to-matrix (cdr xs) (cdr m)))
      nil))

(defun transpose (m)
  (if (consp m)
      (append-to-matrix (car m) (transpose (cdr m)))
      nil))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun transpose (m)
  (if (consp m)
      (if (consp (car m))
          (cons (cons (caar m) )
          (transpose (cdr m)))
      nil))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun blank-matrix (m n)
  (if (zp m)
      nil
      (cons (make-list n)
            (blank-matrix (1- m) n))))

(defrandom random-matrix (m n)
  (if (or (zp m) (zp n)) ;needed to admit (can't ignore n)
      nil
      (cons (random-list-of (random-rational) :size n)
            (random-matrix (1- m) n))))

(defproperty transpose-delivers-matrix
  (m :value (random-matrix (1+ (random-data-size)) 
                           (1+ (random-data-size)))
     :where (matrix? m))
  (matrix? (transpose m)))

(defproperty transpose-num-cols-is-original-num-rows
  (m :value (random-matrix (1+ (random-data-size)) 
                           (1+ (random-data-size)))
     :where (matrix? m))
  (equal (num-rows m) (num-cols (transpose m))))

(defproperty transpose-num-rows-is-original-num-cols
  (m :value (random-matrix (1+ (random-data-size)) 
                           (1+ (random-data-size)))
     :where (matrix? m))
  (equal (num-cols m) (num-rows (transpose m))))