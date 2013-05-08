;;;All proven - ARS 4/18/12;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(in-package "ACL2")
(include-book "doublecheck" :dir :teachpacks)
(include-book "permutations-defs")
(include-book "x-is-in-every-list-of-insert-everywhere")

(defproperty x-is-in-every-list-of-every-list-of-insert-everywhere-in-all
  (  n :value (1+ (random-data-size))
   xss :value (random-list-of (random-list-of (random-symbol)) :size n)
     x :value (random-symbol)
   yss :value (random-element-of (insert-everywhere-in-all x xss))
       :where (and (true-list-listp xss)
                   (true-list-listp yss)
                   (member-equal yss (insert-everywhere-in-all x xss))))
  (member-allp x yss))
