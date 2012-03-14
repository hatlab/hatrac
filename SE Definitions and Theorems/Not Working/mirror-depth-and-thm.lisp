(include-book "doublecheck" :dir :teachpacks)

(defun mirror (p)
  (if (atom p)
      p
      (cons (mirror (cdr p)) (mirror (car p)))))

(defun depth (p)
  (if (atom p)
      1
      (1+ (max (depth (car p)) (depth (cdr p))))))

(defproperty mirror-preserves-depth
  (p :value (random-sexp-of (random-symbol)))
  (equal (depth p) (depth (mirror p))))