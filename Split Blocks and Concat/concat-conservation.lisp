; tests specify programmer expectations
(in-package "ACL2")
(include-book "doublecheck" :dir :teachpacks)
(include-book "split-blocks-concat-defs")

(defproperty concat-conservation :repeat 100
  (x   :value (random-symbol)
   xss :value (random-list-of (random-list-of (random-symbol))))
  (iff (member-one+ x xss) (member-equal x (concat xss))))