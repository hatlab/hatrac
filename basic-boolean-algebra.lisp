(include-book "doublecheck" :dir :teachpacks)

(defproperty and-commutes
  (x :value (random-boolean)
   y :value (random-boolean))
  (iff (and x y) (and y x))
  :rule-classes nil)

(defproperty and-demorgan
  (x :value (random-boolean)
   y :value (random-boolean))
  (iff (not (and x y))
         (or (not x) (not y))))

(defproperty and-absorption
  (x :value (random-boolean)
   y :value (random-boolean))
  (iff (and (or x y) y) y)
  :rule-classes nil)

(defproperty or-implication
  (x :value (random-boolean)
   y :value (random-boolean)
   z :value (random-boolean))
  (iff (implies (or x y) z) (and (implies x z) (implies y z))))

(defproperty true-incognito
  (x :value (random-boolean)
   y :value (random-boolean))
  (implies x (implies (not x) y))
  :rule-classes nil)

(defproperty implication
  (x :value (random-boolean)
   y :value (random-boolean))
  (iff (implies x y) (or (not x) y)))

(defproperty absurdidity
  (x :value (random-boolean)
   y :value (random-boolean))
  (iff (and (implies x y) (implies x (not y))) (not x))
  :rule-classes nil)

