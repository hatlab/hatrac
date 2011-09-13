(include-book "doublecheck" :dir :teachpacks)

;;; TODO: import this from dmx.lisp?
(defun dmx (xs)
  (cond ((and (consp xs) (consp (rest xs)))
         (let* ((yszs (dmx (rest (rest xs))))
                (ys (first yszs))
                (zs (second yszs)))
           (list (cons (first xs) ys) (cons (second xs) zs))))
        ((consp xs)
         (list (list (first xs)) nil))
        (t (list nil nil))))

(defun merge-lists (xs ys)
  (declare (xargs :measure (+ (len xs) (len ys))))
  (cond ((and (consp xs) (consp ys))
         (if (< (first xs) (first ys))
             (cons (first xs) (merge-lists (rest xs) ys))
             (cons (first ys) (merge-lists xs (rest ys)))))
        ((consp xs)
         xs)
        (t
         ys)))

(defun msort (xs)
  (if (consp (rest xs))
      (let* ((yszs (dmx xs))
             (ys (first yszs))
             (zs (second yszs)))
        (merge-lists (msort ys) (msort zs)))
      xs))

(defun partition (xs pivot)
  (if (consp xs)
      (let* ((x (first xs))
             (yszs (partition (rest xs) pivot))
             (ys (first yszs))
             (zs (second yszs)))
        (if (< x pivot)
            (list (cons x ys) zs)
            (list ys (cons x zs))))
      '(nil nil)))

(defun qsort (xs)
  (if (consp xs)
      (let* ((x (first xs))
             (yszs (partition (rest xs) x))
             (ys (first yszs))
             (zs (second yszs)))
        (append (qsort ys) (list x) (qsort zs)))
      nil))

(defun sortedp (xs)
  (if (consp (rest xs))
      (and (<= (first xs) (second xs)) (sortedp (rest xs)))
      t))

(defproperty msort-works
  (xs :where (true-listp xs) :value (random-list-of (random-rational)))
  (sortedp (msort xs)))

(defproperty qsort-works
  (xs :where (true-listp xs) :value (random-list-of (random-rational)))
  (sortedp (qsort xs)))

(defproperty msort-equals-qsort
  (xs :where (true-listp xs) :value (random-list-of (random-rational)))
  (equal (msort xs) (qsort xs)))