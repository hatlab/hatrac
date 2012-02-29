(in-package "ACL2")
(include-book "doublecheck" :dir :teachpacks)

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

(defproperty demorgan-or :repeat 100
  (bs :value (random-list-of (random-boolean)))
  (equal (~ (big-and bs))
         (big-or (map-not bs))))

(defproperty demorgan-and :repeat 100
  (bs :value (random-list-of (random-boolean)))
  (equal (~ (big-or bs))
         (big-and (map-not bs))))