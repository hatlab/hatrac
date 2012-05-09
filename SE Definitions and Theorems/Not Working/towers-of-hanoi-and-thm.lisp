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

(defconst *LABELS* '(#\a #\b #\c))

(defun solutionp (sol)
  (or (null sol)
      (and (natp (caar sol)) (member-equal (cdar sol) *LABELS*)
           (solutionp (cdr sol)))))

(defrandom random-solution (n)
  (if (zp n)
      nil
      (cons (cons (random-data-size) (nth (random-between 0 2) *LABELS*))
            (random-solution (1- n)))))

(defproperty powers-of-two-identity
  (n :value (random-between 0 40)
     :where (integerp n))
  (equal (+ (expt 2 n) (expt 2 n)) (expt 2 (1+ n))))

(defproperty remap-length-lemma
  (sol  :value (random-solution (random-data-size))
   newa :value (random-char)
   newb :value (random-char)
   newc :value (random-char)   
        :where (solutionp sol))
  (equal (length sol) (length (remap sol newa newb newc))))

(defproperty solutions-are-true-lists
  (sol :value (random-solution (random-data-size))
       :where (solutionp sol))
  (true-listp sol))

(defproperty length-append-lemma
  (xs :value (random-list-of (random-symbol))
   ys :value (random-list-of (random-symbol))
      :where (and (true-listp xs) (true-listp ys)))
  (equal (+ (length xs) (length ys))
         (length (append xs ys))))

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
  