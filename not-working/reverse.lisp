(include-book "doublecheck" :dir :teachpacks)

(defun rev (xs)
  (if (endp xs)
      xs
      (append (rev (rest xs)) (first xs))))

(defproperty reverse-plus-one
  (xs :value (random-list-of (random-atom))
   x :value (random-atom))
  (equal (rev (cons x xs)) (append (rev xs) (list x))))