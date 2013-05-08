;;; All theorems proven in this file - ARS 04/11/12
(IN-PACKAGE "ACL2")
(include-book "doublecheck" :dir :teachpacks)
(include-book "arithmetic-3/floor-mod/floor-mod" :dir :system)
(include-book "linear-encoding-defs")

(defproperty one-element-lemma
  (xs :value (random-list-of (random-integer))
      :where (and (true-listp xs) (consp xs) (not (consp (cdr xs)))))
  (equal (list (car xs)) xs))

(defproperty decode-inverts-encode
  (m  :value (random-natural)
      :where (basep m)
   xs :value (random-list-of (random-between 0 (1- m)))
      :where (and (consp xs) (code-listp m xs)))
  (equal (decode m (encode m xs)) xs))
