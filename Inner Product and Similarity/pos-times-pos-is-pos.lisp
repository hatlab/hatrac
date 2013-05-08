;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(in-package "ACL2")
(include-book "doublecheck" :dir :teachpacks)
(include-book "arithmetic-5/top" :dir :system)

(defproperty pos-times-pos-is-pos
  (x :value (random-natural)
   y :value (random-natural)
     :where (and (posp x) (posp y)))
  (< 0 (* x y)))

