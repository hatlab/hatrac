; tests specify programmer expectations
(in-package "ACL2")
(include-book "doublecheck" :dir :teachpacks)
(include-book "split-blocks-concat-defs")

(defproperty split-inv
  (n  :value (random-natural)
   xs :value (random-list-of (random-integer))
      :where (natp n))
  (equal (append (car (split n xs))
                 (cadr (split n xs)))
         xs))
