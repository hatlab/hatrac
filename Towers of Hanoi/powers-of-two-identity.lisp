;(include-book "doublecheck" :dir :teachpacks)
(in-package "ACL2")
(include-book "arithmetic-3/top" :dir :system)
(include-book "doublecheck" :dir :teachpacks)

(defproperty powers-of-two-identity
  (n :value (random-between 0 40)
     :where (integerp n))
  (equal (+ (expt 2 n) (expt 2 n)) (expt 2 (1+ n))))
