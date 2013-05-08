;;; All theorems proven in this file - ARS 04/11/12
(IN-PACKAGE "ACL2")
(include-book "doublecheck" :dir :teachpacks)
(include-book "arithmetic-3/floor-mod/floor-mod" :dir :system)
(include-book "linear-encoding-defs")

(defproperty encode-works
  (m     :value (random-natural)
         :where (basep m)
   size  :value (+ 2 (random-data-size))
   xs    :value (random-list-of (random-between 0 (1- m)) :size size)
         :where (and (consp xs) (code-listp m xs))
   n     :value (random-between 0 (- (length xs) 2))
         :where (and (natp n) (<= n (- (length xs) 2))))
  (equal (nth n (encode m xs))
         (mod (+ (nth n xs) (nth (1+ n) xs)) m)))
