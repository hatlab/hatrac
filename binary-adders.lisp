(in-package "ACL2")

(include-book "doublecheck" :dir :teachpacks)

(include-book "numerals")

(defun or-gate (x y)
  (if (or (= x 1) (= y 1)) 1 0))

(defun and-gate (x y)
  (if (and (= x 1) (= y 1)) 1 0))

(defun xor-gate (x y)
  (if (and (= x 1) (= y 1))
      0
      (or-gate x y)))

(defun half-adder (x y)
  (list (xor-gate x y) (and-gate x y)))

(defun bitp (b)
  (or (= b 0) (= b 1)))

;(defrandom random-bit ()
;  (random-element-of '(0 1)))

(defproperty half-adder-works
  (x :where (bitp x) :value (random-element-of '(0 1))
   y :where (bitp y) :value (random-element-of '(0 1)))
  (= (num (half-adder x y)) (+ x y)))

(defun full-adder (c-in x y)
  (let* ((h1 (half-adder x y))
         (s1 (first h1))
         (c1 (second h1))
         (h2 (half-adder s1 c-in))
         (s (first h2))
         (c2 (second h2))
         (c (or-gate c1 c2)))
    (list s c)))

(defproperty full-adder-works
  (x :where (bitp x) :value (random-element-of '(0 1))
   y :where (bitp y) :value (random-element-of '(0 1))
   c-in :where (bitp c-in) :value (random-element-of '(0 1)))
  (= (num (full-adder x y c-in)) (+ x y c-in)))

;; Honors lecture 21
;; adder2