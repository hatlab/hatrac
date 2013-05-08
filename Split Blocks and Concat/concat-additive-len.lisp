; tests specify programmer expectations
(in-package "ACL2")
(include-book "doublecheck" :dir :teachpacks)
(include-book "split-blocks-concat-defs")

(defproperty concat-additive-len
  (xss :value (random-list-of (random-list-of (random-symbol))))
  (= (len (concat xss)) (total-len xss)))
