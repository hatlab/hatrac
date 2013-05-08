; tests specify programmer expectations
(include-book "doublecheck" :dir :teachpacks)
(include-book "split-blocks-concat-defs")

;New Properties: - ARS 03/12/12
(defproperty second-element-of-split-is-shorter
  (n  :value (random-natural)
      :where (posp n)
   xs :value (random-list-of (random-integer))
      :where (and (consp xs) (true-listp xs)))
  (> (length xs) (length (cadr (split n xs)))))
