(include-book "doublecheck" :dir :teachpacks)

;; Admission proves that dmx terminates
(defun dmx (xs)
  (cond ((and (consp xs) (consp (rest xs)))
         (let* ((yszs (dmx (rest (rest xs))))
                (ys (first yszs))
                (zs (second yszs)))
           (list (cons (first xs) ys) (cons (second xs) zs))))
        ((consp xs)
         (list (list (first xs)) nil))
        (t (list nil nil))))

