(in-package "ACL2")
(defun cons-all (x xss)
  (if (consp xss)
      (cons (cons x (car xss)) (cons-all x (cdr xss)))
      nil))

(defun insert-everywhere (x xs)
  (if (consp xs)
      (let* ((part-xss (insert-everywhere x (cdr xs)))
             (cdr-xss (cons-all (car xs) part-xss)))
        (cons (cons x xs) cdr-xss))
      (list (list x))))

(defun insert-everywhere-in-all (x xss)
  (if (consp xss)
      (cons (insert-everywhere x (car xss))
            (insert-everywhere-in-all x (cdr xss)))
      nil))

(defun concat (xss)
  (if (consp xss)
      (append (car xss) (concat (cdr xss)))
      nil))

(defun permutations (xs)
  (if (consp (cdr xs))
      (concat (insert-everywhere-in-all (car xs) (permutations (cdr xs))))
      (list xs)))

(defun permutationp (xs ys)
  (if (consp xs)
      (permutationp (cdr xs) (remove1 (car xs) ys))
      (not ys)))

(defun permutation-listp (xs xss)
  (or (endp xss)
      (and (permutationp xs (car xss))
           (permutation-listp xs (cdr xss)))))

(defun member-allp (x xss)
  (or (null xss)
      (and (member x (car xss))
           (member-allp x (cdr xss)))))

(defun true-list-list-listp (xsss)
    (if (atom xsss) 
        (null xsss) 
        (and (true-list-listp (car xsss))
             (true-list-list-listp (cdr xsss)))))