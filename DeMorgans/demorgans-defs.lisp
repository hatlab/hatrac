(in-package "ACL2")

(defun && (x y) (if x y nil))
(defun || (x y) (if x t y))
(defun ~ (x) (if x nil t))

(defun big-and (xs)
  (if (consp xs)
      (if (car xs) (big-and (cdr xs)) nil)
      t))

(defun big-or (xs)
  (if (consp xs)
      (if (car xs) t (big-or (cdr xs)))
      nil))

(defun map-not (xs)
  (if (consp xs)
      (cons (not (car xs)) (map-not (cdr xs)))
      nil))

(defun numbers->bools (nums)
   (if (endp nums)
       nil
       (if (posp (car nums))
           (cons t (numbers->bools (cdr nums)))
           (cons nil (numbers->bools (cdr nums))))))
