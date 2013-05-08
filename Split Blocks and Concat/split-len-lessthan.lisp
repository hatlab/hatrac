; tests specify programmer expectations
(in-package "ACL2")
(include-book "doublecheck" :dir :teachpacks)
(include-book "split-blocks-concat-defs")

(defproperty split-len<
  (n  :value (random-natural)
   m  :value (random-between 1 (1- n))
   xs :value (random-list-of (random-integer) :size (- n m))
      :where (and (natp n) (< (len xs) n)))
  (= (len (car (split n xs))) (len xs)))
