;(include-book "doublecheck" :dir :teachpacks)
(include-book "arithmetic-3/top" :dir :system)
(include-book "../../append")

(defun remap (solution newa newb newc)
  (if (consp solution)
      (case (cdar solution)
        (#\a (cons (cons (caar solution) newa) 
                   (remap (cdr solution) newa newb newc)))
        (#\b (cons (cons (caar solution) newb) 
                   (remap (cdr solution) newa newb newc)))
        (#\c (cons (cons (caar solution) newc) 
                   (remap (cdr solution) newa newb newc))))
      nil))
        
(defun towers-of-hanoi (n)
  (if (zp n)
      nil
      (let ((towers (towers-of-hanoi (1- n))))
        (append (remap towers #\a #\c #\b)
                (append (list (cons n #\c))
                        (remap towers #\b #\a #\c))))))

(defproperty powers-of-two-identity
  (n :value (random-between 0 40)
     :where (integerp n))
  (equal (+ (expt 2 n) (expt 2 n)) (expt 2 (1+ n))))

(defproperty towers-of-hanoi-size-prp-base
  ()
  (equal (1- (expt 2 1)) (length (towers-of-hanoi 1))))
(defproperty towers-of-hanoi-size-prp-inductive
  (n :value (random-between 1 15)
     :where (and (integerp n) (>= n 1)))
  (implies (equal (1- (expt 2 n)) (length (towers-of-hanoi n)))
           (equal (1- (expt 2 (1+ n))) 
                  (length (towers-of-hanoi (1+ n))))))
  

(defproperty towers-of-hanoi-size-prp
  (n :value (random-between 1 15)
     :where (and (natp n) (>= n 1)))
  (equal (1- (expt 2 n)) (length (towers-of-hanoi n))))
  