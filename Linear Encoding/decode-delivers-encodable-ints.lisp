;;; All theorems proven in this file - ARS 04/11/12
(IN-PACKAGE "ACL2")
(include-book "doublecheck" :dir :teachpacks)
(include-book "arithmetic-3/floor-mod/floor-mod" :dir :system)
(include-book "linear-encoding-defs")

(defproperty decode-delivers-encodable-ints
  (m  :value (random-natural)
      :where (basep m)
   ys :value (random-list-of (random-between 0 (1- m)))
      :where (and (consp ys) (code-listp m ys)))
  (code-listp m (decode m ys)))
