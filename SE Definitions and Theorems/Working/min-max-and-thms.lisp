(include-book "doublecheck" :dir :teachpacks)
(include-book "rand" :dir :teachpacks)
;;;;;;;;;;;;All proven - ARS 04/18/12;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun maximum (xs)
  (if (consp (cdr xs))
      (let ((max (maximum (cdr xs))))
        (if (> (car xs) max)
            (car xs)
            max))
      (car xs)))

(defun min-pair (mp1 mp2)
  (if (< (car mp1) (car mp2))
      mp1
      mp2))

(defun minimum-pair (mps)
  (if (consp (cdr mps))
      (min-pair (car mps) (minimum-pair (cdr mps)))
      (car mps)))

(defun measure-pairp (mp?)
  (and (= (len mp?) 2) (rationalp (car mp?))))

(defun measure-pair-listp (mps?)
  (or (null mps?)
      (and (measure-pairp (car mps?))
           (measure-pair-listp (cdr mps?)))))

(defun mp-member (mp mps)
  (if (consp mps)
      (or (and (equal (car mp) (caar mps))
               (equal (cadr mp) (cadar mps)))
          (mp-member mp (cdr mps)))
      nil))

(defproperty maximum-delivers-rational
  (xs :value (random-list-of (random-rational))
      :where (and (rational-listp xs) (consp xs)))
  (rationalp (maximum xs)))

(defproperty maximum-is-in-list
  (xs :value (random-list-of (random-rational))
      :where (and (rational-listp xs) (consp xs)))
  (member-equal (maximum xs) xs))

(defproperty maximum-is-maximum
  (size :value (1+ (random-data-size))
     xs :value (random-list-of (random-rational) :size size)
      n :value (random-between 0 (1- (len xs)))  
      x :value (nth n xs) 
        :where (and (rational-listp xs) (consp xs) (member-equal x xs)))
  (>= (maximum xs) x))

(defrandom random-measure-pair ()
  (cons (random-rational) (list (random-symbol))))

(defproperty minimum-pair-delivers-measure-pair
  (mps :value (random-list-of (random-measure-pair))
       :where (and (measure-pair-listp mps) (consp mps)))
  (measure-pairp (minimum-pair mps)))

(defproperty minimum-pair-delivers-member-of-argument
  (mps :value (random-list-of (random-measure-pair))
       :where (and (measure-pair-listp mps) (consp mps)))
  (mp-member (minimum-pair mps) mps))

(defproperty minimum-pair-is-minimum
  (size :value (1+ (random-data-size))
    mps :value (random-list-of (random-measure-pair) :size size)
      n :value (random-between 0 (1- (len mps)))  
     mp :value (nth n mps) 
        :where (and (measure-pair-listp mps) (consp mps) (mp-member mp mps)))
  (>= (car mp) (car (minimum-pair mps))))