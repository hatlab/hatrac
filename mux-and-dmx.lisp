(include-book "doublecheck" :dir :teachpacks)

;; For auto-ignoring unused mv-let parameters. Dracula doesn't support (declare
;; (ignore ...)) apparently.
(set-ignore-ok t)

(defun mux (xs ys)
  (cond ((endp xs) ys)
        ((endp ys) xs)
        (t (append (list (car xs) (car ys))
                   (mux (cdr xs) (cdr ys))))))

(defun dmx (xs)
  (cond ((and (consp xs) (consp (rest xs)))
         (mv-let (ys zs)
                 (dmx (rest (rest xs)))
                 (mv (cons (first xs) ys) (cons (second xs) zs))))
        ((consp xs)
         (mv (list (first xs)) nil))
        (t (mv nil nil))))

(defproperty dmx-preserves-length 
  (xys :value (random-list-of (random-atom)))
  (mv-let (xs ys)
          (dmx xys)
          (= (+ (len xs) (len ys))
             (len xys))))

(defproperty mux-preserves-length
  (xs :value (random-list-of (random-atom))
   ys :value (random-list-of (random-atom)))
  (= (+ (len xs) (len ys))
     (len (mux xs ys))))

(defproperty mux-conservation-of-elements
  (xs :value (random-list-of (random-atom)
                             :size (+ 1 (random-data-size)))
   ys :value (random-list-of (random-atom)
                             :size (+ 1 (random-data-size)))
   e :value (random-element-of
             (list (random-atom)
                   (random-element-of xs)
                   (random-element-of ys))))
  (iff (member-equal e (mux xs ys))
       (or (member-equal e xs)
           (member-equal e ys))))

(defproperty mux-inverts-dmx
  (xys :where (true-listp xys) :value (random-list-of (random-atom)))
  (mv-let (xs ys) (dmx xys)
          (equal (mux xs ys) xys)))

(defproperty dmx-inverts-mux
  (xs :where (true-listp xs) :value (random-list-of (random-atom))
   ys :where (and (true-listp ys) (= (len xs) (len ys)))
      :value (random-list-of (random-atom)))
  (equal (dmx (mux xs ys)) (mv xs ys)))

(defun every-other (xs)
  (if (endp (rest xs))
      xs
      (cons (first xs) (every-other (rest (rest xs))))))

(defun every-odd (xs)
  (every-other (rest xs)))

(defproperty mux-evens=xs
  (xs :where (true-listp xs) :value (random-list-of (random-atom))
   ys :where (and (true-listp ys) (= (len xs) (len ys)))
      :value (random-list-of (random-atom)))
  (equal (every-other (mux xs ys)) xs))

(defproperty mux-odds=ys
  (xs :where (true-listp xs) :value (random-list-of (random-atom))
   ys :where (and (true-listp ys) (= (len xs) (len ys)))
      :value (random-list-of (random-atom)))
  (equal (every-odd (mux xs ys)) ys))

(defproperty dmx-evens=xs
  (xys :where (true-listp xys) :value (random-list-of (random-atom)))
  (mv-let (xs _) (dmx xys)
          (equal (every-other xys)
                 xs)))

;(defproperty dmx-evens=ys
;  (xys :where (true-listp xys) :value (random-list-of (random-atom)))
;  (mv-let (_ ys) (dmx xys)
;          (equal (every-odd xys)
;                 ys)))
