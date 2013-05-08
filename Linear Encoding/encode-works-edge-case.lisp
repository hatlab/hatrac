;;; All theorems proven in this file - ARS 04/11/12
(IN-PACKAGE "ACL2")
(include-book "doublecheck" :dir :teachpacks)
(include-book "arithmetic-3/floor-mod/floor-mod" :dir :system)
(include-book "linear-encoding-defs")

(defproperty encode-works-edge-case
  (m  :value (random-natural)
      :where (basep m)
   xs :value (random-list-of (random-between 0 (1- m)))
      :where (and (consp xs) (code-listp m xs)))
  (equal (car (last (encode m xs)))
         (mod (1- (car (last xs))) m)))
