(include-book "cryptography-defs")
(include-book "doublecheck" :dir :teachpacks)

(defproperty vis->txt-delivers-list-of-characters
  (vals :value (random-list-of (random-between 0 94))
        :where (viscode-listp vals))
  (character-listp (vis->txt vals)))
