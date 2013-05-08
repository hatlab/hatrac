;;; All theorems in this file are proven - ARS 04/11/12
(in-package "ACL2")
(include-book "doublecheck" :dir :teachpacks)
(include-book "arithmetic-5/top" :dir :system)
(include-book "linear-regression-defs")

(defproperty avg-works
  (xs :value (random-list-of (random-integer))
      :where (and (consp xs) (rational-listp xs)))
  (equal (avg xs) (/ (sum xs) (len xs))))
