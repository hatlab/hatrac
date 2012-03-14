(include-book "doublecheck" :dir :teachpacks)
(include-book "ariithmetic-3/floor-mod/floor-mod " :dir :system)

(defun encode (m xs)
  (if (consp (cdr xs))
      (cons (mod (+ (car xs) (cadr xs)) m) (encode m (cdr xs)))
      (list (mod (+ (car xs) (1- m)) m))))

(defun decode (m ys)
  (if (consp (cdr ys))
      (let* ((cdr-xs (decode m (cdr ys)))
             (car-xs (mod (- (car ys) (car cdr-xs)) m)))
        (cons car-xs cdr-xs))
      (list (mod (- (car ys) (1- m)) m))))

(defun basep (m)
  (and (natp m) (>= m 2)))

(defun codep (m x)
  (and (natp x) (> m x)))

(defun code-listp (m xs)
  (or (endp xs)
      (and (codep m (car xs)) (code-listp m (cdr xs)))))

(defrandom random-encodable-integer (m)
  (random-between 0 (1- m)))

(defproperty encode-delivers-encodable-ints
  (m  :value (random-natural)
      :where (basep m)
   xs :value (random-list-of (random-encodable-integer m))
      :where (and (consp xs) (code-listp m xs)))
  (code-listp m (encode m xs)))

(defproperty decode-delivers-encodable-ints
  (m  :value (random-natural)
      :where (basep m)
   ys :value (random-list-of (random-encodable-integer m))
      :where (and (consp ys) (code-listp m ys)))
  (code-listp m (decode m ys)))

(defproperty encode-works
  (m    :value (random-natural)
        :where (basep m)
   size :value (1+ (1+ (random-data-size)))   
   xs   :value (random-list-of (random-encodable-integer m) :size size)
        :where (and (consp xs) (code-listp m xs))
   n    :value (random-between 0 (- (length xs) 2))
        :where (and (natp n) (<= n (- (length xs) 2))))
  (equal (nth n (encode m xs))
         (mod (+ (nth n xs) (nth (1+ n) xs)) m)))
  
(defproperty encode-works-2
  (m  :value (random-natural)
      :where (basep m)
   xs :value (random-list-of (random-encodable-integer m))
      :where (and (consp xs) (code-listp m xs)))
  (equal (car (last (encode m xs)))
         (mod (1- (car (last xs))) m)))

(defproperty decode-inverts-encode
  (m  :value (random-natural)
      :where (basep m)
   xs :value (random-list-of (random-encodable-integer m))
      :where (and (consp xs) (code-listp m xs)))
  (equal (decode m (encode m xs)) xs))