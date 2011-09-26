(in-package "ACL2")

(defun mux (xs ys)
  (if (or (endp xs) (endp ys))
      (append xs ys)
      (append (list (car xs) (car ys)) (mux (cdr xs) (cdr ys)))))

(defun dmx (xys)
  (if (endp xys)
      (list nil nil)
      (let* ((x (car xys))
             (ysxs (dmx (cdr xys)))
             (ys (car ysxs))
             (xs (cadr ysxs)))
        (list (cons x xs) ys))))

(defun every-other (xs)
  (if (endp (cdr xs))
      xs
      (cons (car xs) (every-other (cddr xs)))))

(defun every-odd (xs)
  (every-other (cdr xs)))

