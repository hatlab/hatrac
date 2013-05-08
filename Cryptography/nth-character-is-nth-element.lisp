(include-book "cryptography-defs")
(include-book "doublecheck" :dir :teachpacks)

(defproperty nth-character-is-nth-element
  (vals :value (random-list-of (random-between 0 94))
        :where (and (viscode-listp vals) (consp vals))
      n :value (random-between 0 (1- (len vals)))
        :where (and (natp n) (<= n (1- (len vals)))))
  (equal (code-char (+ 32 (nth n vals))) (nth n (vis->txt vals))))
