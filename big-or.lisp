(include-book "doublecheck" :dir :teachpacks)

(defun big-or (bs)
  (if (endp bs)
      bs
      (or (first bs) (big-or (rest bs)))))

(defproperty or-returns-t-with-any-t
  (bs :value (random-list-of (random-boolean))
   cs :value (random-list-of (random-boolean)))
  (big-or (append bs '(t) cs)))