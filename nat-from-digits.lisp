(include-book "doublecheck" :dir :teachpacks)
(include-book "arithmetic-3/top" :dir :system)
(include-book "arithmetic-3/floor-mod/floor-mod" :dir :system)

; from exponentiation.lisp
(defun pow (b n)
  (if (zp n)
      1
      (* b (pow b (1- n)))))

(defun nat-from-digits-r (b ds n)
  (if (consp ds)
   (+ (* (pow b n) (first ds))
      (nat-from-digits-r b (rest ds) (1+ n)))
   0))

(defun nat-from-digits (b ds)
  (nat-from-digits-r b ds 0))

(defun horners-rule (b ds)
  (if (consp ds)
      (+ (first ds) (* b (horners-rule b (rest ds))))
      0))

(defun valid-digitsp (b ds)
  (or (endp ds)
      (let ((d (first ds)))
        (and (integerp d) (>= d 0) (< d b) 
             (valid-digitsp b (rest ds))))))

(defproperty horners-rule-works
  (b :where (not (zp b))
     :value (random-natural)
   ds :where (valid-digitsp b ds)
      :value (random-list-of (random-between 0 (1- b))))
  (= (nat-from-digits b ds)
     (horners-rule b ds)))