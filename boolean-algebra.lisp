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

; Exams

(defproperty f10-m1-4
  (a :value (random-boolean)
   b :value (random-boolean))
  (implies (not a) (not (and a b)))
  :rule-classes nil)

(defproperty f10-m1-5
  (a :value (random-boolean)
   b :value (random-boolean)
   c :value (random-boolean))
  (implies (implies (and a b) c) (implies a (implies b c)))
  :rule-classes nil)

(defproperty f10-m1-6
  (a :value (random-boolean)
   b :value (random-boolean))
  (implies (and (implies a b) (implies a (not b))) (not a))
  :rule-classes nil)

(defproperty f10-m1-7
  (a :value (random-boolean)
   b :value (random-boolean))
  (iff (and a (implies a b)) (and a b))
  :rule-classes nil)

(defproperty f10-m1-8
  (a :value (random-boolean)
   b :value (random-boolean)
   c :value (random-boolean)
   d :value (random-boolean))
  (implies (and (and (implies a b) c) d) (implies (implies a b) c))
  :rule-classes nil)