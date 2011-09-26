(in-package "ACL2")
(include-book "doublecheck" :dir :teachpacks)

(defun && (x y) (if x y nil))
(defun || (x y) (if x t y))
(defun ~ (x) (if x nil t))

(defproperty demorgan-or :repeat 100
  (x :value (random-boolean)
   y :value (random-boolean))
  (equal (~ (|| x y))
         (&& (~ x) (~ y))))

(defproperty demorgan-and :repeat 100
  (x :value (random-boolean)
   y :value (random-boolean))
  (equal (~ (&& x y))
         (|| (~ x) (~ y))))