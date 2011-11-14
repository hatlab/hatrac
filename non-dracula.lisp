(encapsulate (((foo *) => *))
  (local (defun foo (x) x)))

(defun map-foo (xs)
  (if (endp xs)
    nil
    (cons (foo (first xs)) (map-foo (rest xs)))))

(defthm map-foo-preserves-len
  (= (len (map-foo xs)) (len xs)))
