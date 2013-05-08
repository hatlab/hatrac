(include-book "doublecheck" :dir :teachpacks)
(include-book "demorgans-defs")

(defproperty demorgan-and :repeat 50
  (nums :value (random-list-of (random-between 0 1))
     bs :value (mv (numbers->bools nums) STATE))
  (equal (~ (big-or bs))
         (big-and (map-not bs))))
