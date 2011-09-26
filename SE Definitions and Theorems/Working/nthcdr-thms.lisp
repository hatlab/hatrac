(in-package "ACL2")
(include-book "doublecheck" :dir :teachpacks)

(defproperty nthcdr-reduces-length :repeat 100
  (n  :value (random-natural)
      :where (posp n)
   xs :value (random-list-of (random-symbol))
      :where (consp xs))
  (< (len (nthcdr n xs))
     (len xs))
  :hints (("Goal" :induct (len xs))))
