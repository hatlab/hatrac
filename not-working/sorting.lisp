(include-book "doublecheck" :dir :teachpacks)

(defun dmx (xs)
  (cond ((consp (rest xs))
         (let* ((yszs (dmx (rest (rest xs))))
                (ys (first yszs))
                (zs (second yszs)))
           (list (cons (first xs) ys) (cons (second xs) zs))))
        ((consp xs)
         (list (list (first xs)) nil))
        (t (list nil nil))))

(defun merge-lists (xs ys)
  (declare (xargs :measure (+ (acl2-count xs) (acl2-count ys))))
  (cond ((and (consp xs) (consp ys))
         (if (< (first xs) (first ys))
             (cons (first xs) (merge-lists (rest xs) ys))
             (cons (first ys) (merge-lists xs (rest ys)))))
        ((consp xs)
         xs)
        (t
         ys)))

(defproperty dmx-shortens-list-left
  (xs :where (consp (rest xs))
      :value (random-list-of (random-rational)))
  (< (acl2-count (first (dmx xs))) (acl2-count xs)))

(defproperty dmx-shortens-list-right
  (xs :where (consp (rest xs))
      :value (random-list-of (random-rational)))
  (< (acl2-count (second (dmx xs))) (acl2-count xs)))

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

(defproperty partition-preserves-elements
  (xs :value (random-list-of (random-rational)
                             :size (1+ (random-data-size)))
   xi :where (member-equal xi xs)
      :value (random-element-of xs))
  (let* ((x (first xs))
         (yszs (partition (rest xs) x))
         (ys (first yszs))
         (zs (second yszs)))
  (member-equal x (append ys (list x) zs))))

;(defproperty qsort-preserves-elements
;  (xs :value (random-list-of (random-rational)
;                             :size (1+ (random-data-size)))
;   x :where (member-equal x xs)
;     :value (random-element-of xs))
;  (member-equal x (qsort xs)))
;
;(defproperty qsort-conserves-elements
;  (xs :where (true-listp xs)
;      :value (random-list-of (random-rational)
;                             :size (1+ (random-data-size)))
;   x :where (member-equal x (qsort xs))
;     :value (random-element-of (qsort xs)))
;  (member-equal x xs))


(defproperty msort-preserves-elements
  (xs :value (random-list-of (random-rational)
                             :size (1+ (random-data-size)))
   x :where (member-equal x xs)
     :value (random-element-of xs))
  (member-equal x (msort xs)))

(defproperty msort-conserves-elements
  (xs :where (true-listp xs)
      :value (random-list-of (random-rational)
                             :size (1+ (random-data-size)))
   x :where (member-equal x (msort xs))
     :value (random-element-of (msort xs)))
  (member-equal x xs))

(defun sortedp (xs)
  (if (consp (rest xs))
      (and (<= (first xs) (second xs)) (sortedp (rest xs)))
      t))

(defproperty msort-works
  (xs :value (random-list-of (random-rational)))
  (sortedp (msort xs)))

(defproperty qsort-works
  (xs :value (random-list-of (random-rational)))
  (sortedp (qsort xs)))

;(defproperty msort-equals-qsort
;  (xs :where (true-listp xs) :value (random-list-of (random-rational)))
;  (equal (my-msort xs) (qsort xs)))