(in-package "ACL2")
(include-book "doublecheck" :dir :teachpacks)
(include-book "min-max-defs")

(defproperty minimum-is-minimum
  (size :value (random-data-size)
     xs :value (random-list-of (random-integer) :size (1+ size))
      n :value (random-between 0 (1- (len xs)))  
      x :value (nth n xs)
        :where (and (rational-listp xs) (consp xs) (member-equal x xs)))
  (<= (minimum xs) x))
