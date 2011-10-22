(include-book "doublecheck" :dir :teachpacks)


(defun dmx (xys) ; xys = (x1 y1 x2 y2 x3 y3 ...)
  (if (consp xys)
      (mv-let (ys xs)
              (dmx (rest xys)) ; ((x1 x2 ...)(y1 y2 ...))
              (mv (cons (first xys) xs) ys)) ; {dmx1}
      (mv nil nil)))                         ; {dmx0}

(defproperty dmx-shortens-list
  (xs :value (random-list-of (random-natural))
       :where (consp (rest xs)))
  (mv-let (ys zs) (dmx xs)
          (and (< (len ys) (len xs))
               (< (len zs) (len xs)))))

(defproperty dmx-preserves-len
  (xys :value (random-list-of (random-natural)))
  (mv-let (xs ys) (dmx xys)
          (= (+ (len xs) (len ys))
             (len xys))))

(defun mrg (xs ys)
  (declare (xargs :measure (+ (len xs) (len ys))))
  (if (and (consp xs) (consp ys))
      (let* ((x (first xs)) (y (first ys)))
        (if (<= x y)
            (cons x (mrg (rest xs) ys))    ; {x<=y}
            (cons y (mrg xs (rest ys)))))  ; {y<x}
      (if (not (consp ys))
          xs         ; note: ys is empty   ; {mg0}
          ys)))      ; note: xs is empty   ; {mg1}

(defproperty merge-preserves-len
  (xs :value (random-list-of (random-natural))
   ys :value (random-list-of (random-natural)))
  (= (len (mrg xs ys)) (+ (len xs) (len ys))))

(defun merge-sort (xs)
  (declare (xargs
            :measure (len xs)
            :hints (("Goal" ;requires separate "shortens" thms
                    :use ((:instance dmx-shortens-list))))))
  (if (consp (rest xs)) ; (len xs) > 1?
      (mv-let (odds evns) (dmx xs)
              (mrg (merge-sort odds)
                   (merge-sort evns))) ;  {msrt2}
      xs))           ; xs = (x1) or empty {msrt1}

(defun insert (x xs) ; assume xs is already in proper order
  (if (and (consp xs) (> x (first xs)))
      (cons (first xs) (insert x (rest xs))) ; {ins2}
      (cons x xs)))                          ; {ins1}

(defun insertion-sort (xs)
  (if (consp (rest xs)) ; (len xs) > 1?
      (insert (first xs) (insertion-sort (rest xs))) ; {isrt2}
      xs))                                           ; {isrt1}

(defun orderedp (xs)
  (or (not (consp (rest xs))) ; (len xs) < 2
      (and (<= (first xs) (second xs))
           (orderedp (rest xs)))))

(defproperty insertion-sort-sorts
  (xs :value (random-list-of (random-natural)))
  (orderedp (insertion-sort xs)))

(defproperty insertion-sort-preserves-len
  (xs :value (random-list-of (random-natural)))
  (= (len (insertion-sort xs)) (len xs)))

(defun partial-sums (s xs)
  (if (consp xs)
      (let* ((s+x (+ s (first xs))))
        (cons s+x (partial-sums s+x (rest xs))))
      xs))

(defrandom random-increasing ()
  (partial-sums 0 (random-list-of (random-natural))))

(defproperty mrg-preserves-order
  (xs :value (random-increasing)
      :where (orderedp xs)
   ys :value (random-increasing)
      :where (orderedp ys))
  (implies (and (orderedp xs) (orderedp ys))
           (orderedp (mrg xs ys))))

(defproperty merge-sort-sorts-base-case
  (xs :value (random-list-of (random-natural)
              :size (random-between 0 1))
      :where (not (consp (rest xs))))
  (orderedp (merge-sort xs)))

(defproperty merge-sort-sorts
  (xs :value (random-list-of (random-natural)))
  (orderedp (merge-sort xs)))

(defproperty merge-sort-preserves-len-base-case
  (xs :value (random-list-of (random-natural)
              :size (random-between 0 1))
      :where (not (consp (rest xs))))
  (= (len (merge-sort xs)) (len xs)))

(defproperty merge-sort-preserves-len-inductive-case
  (x  :value (random-natural)
   xs :value (random-list-of (random-natural)))
  (= (len (merge-sort (cons x xs)))
     (1+ (len (merge-sort xs)))))

(defproperty merge-sort-preserves-len
  (xs :value (random-list-of (random-natural)))
  (= (len (merge-sort xs)) (len xs)))