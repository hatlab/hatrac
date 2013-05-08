;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(in-package "ACL2")
(include-book "doublecheck" :dir :teachpacks)

(defproperty x-squared-is-non-neg
  (x :value (random-integer)
      :where (rationalp x))
      (>= (* x x) 0))
