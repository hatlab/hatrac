; tests specify programmer expectations
(in-package "ACL2")
(include-book "doublecheck" :dir :teachpacks)
(include-book "split-blocks-concat-defs")

;New Properties: - ARS 03/12/12
(defproperty firstN-preserves-elements
  (n  :value (random-natural)
      :where (posp n)
   xs :value (random-list-of (random-integer))
   k  :value (random-between 0 (1- n))
      :where (and (>= k 0) (<= k (1- n))))
  (equal (nth k xs) (nth k (firstN n xs))))
