(include-book "doublecheck" :dir :teachpacks)
(include-book "demorgans-defs")

(defproperty demorgan-or :repeat 50
  (nums :value (random-list-of (random-between 0 1))
     bs :value (mv (numbers->bools nums) STATE))
  (equal (~ (big-and bs))
         (big-or (map-not bs))))
