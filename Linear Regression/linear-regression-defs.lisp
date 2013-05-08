;;; All theorems in this file are proven - ARS 04/11/12
(in-package "ACL2")
(include-book "doublecheck" :dir :teachpacks)
(include-book "arithmetic-5/top" :dir :system)

(defun avg (xs)
  (if (consp xs)
      (/ (+ (* (avg (cdr xs)) (len (cdr xs))) (car xs)) (len xs))
      0))

(defun vector+scalar (xs s)
  (if (consp xs)
      (cons (+ (car xs) s) (vector+scalar (cdr xs) s))
      nil))

(defun vector*vector (xs ys)
  (if (and (consp xs) (consp ys))
      (cons (* (car xs) (car ys)) (vector*vector (cdr xs) (cdr ys)))
      nil))

(defun sum (xs)
  (if (consp xs)
      (+ (car xs) (sum (cdr xs)))
      0))

