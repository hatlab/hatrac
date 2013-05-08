(in-package "ACL2")
(include-book "basiclex-defs")
(include-book "split-blocks-concat-defs")
(include-book "doublecheck" :dir :teachpacks)

(defproperty split-at-delim-delivers-suffix-that-starts-with-delim
  (ds :value (random-list-of (random-between 0 10))
   xs :value (random-list-of (random-between 0 10))
      :where (consp (cadr (split-at-delimiter ds xs))))
  (member-equal (car (cadr (split-at-delimiter ds xs))) ds))
