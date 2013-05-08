(in-package "ACL2")
(include-book "doublecheck" :dir :teachpacks)
(include-book "min-max-defs")

(defproperty maximum-is-maximum
  (size :value (random-data-size)
     xs :value (random-list-of (random-integer) :size (1+ size))
      n :value (random-between 0 (1- (len xs)))  
      x :value (nth n xs)
        :where (and (rational-listp xs) (consp xs) (member-equal x xs)))
  (>= (maximum xs) x))
