(include-book "doublecheck" :dir :teachpacks)

(defproperty reverse-plus-one
  (xs :where (true-listp xs) :value (random-list-of (random-atom))
   x :where (atom x) :value (random-atom))
  (equal (reverse (append (list x) xs)) (append (reverse xs) (list x))))