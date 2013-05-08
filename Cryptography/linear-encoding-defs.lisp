(IN-PACKAGE "ACL2")
(include-book "arithmetic-3/floor-mod/floor-mod" :dir :system)

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
  (and (true-listp xs)
       (or (endp xs)
           (and (codep m (car xs)) (code-listp m (cdr xs))))))
