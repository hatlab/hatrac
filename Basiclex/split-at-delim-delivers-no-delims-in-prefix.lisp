(in-package "ACL2")
(include-book "basiclex-defs")
(include-book "split-blocks-concat-defs")
(include-book "doublecheck" :dir :teachpacks)

(defproperty split-at-delim-delivers-no-delims-in-prefix
  (ds :value (random-list-of (random-between 0 10))
   xs :value (random-list-of (random-between 0 10))
   x  :value (random-between 0 10)
      :where (member-equal x (car (split-at-delimiter ds xs))))
  (not (member-equal x ds)))
