;(include-book "doublecheck" :dir :teachpacks)
(in-package "ACL2")
(include-book "arithmetic-3/top" :dir :system)
(include-book "append")
(include-book "towers-of-hanoi-defs")

(defproperty length-append-lemma
  (xs :value (random-list-of (random-symbol))
   ys :value (random-list-of (random-symbol))
      :where (and (true-listp xs) (true-listp ys)))
  (equal (+ (length xs) (length ys))
         (length (append xs ys))))