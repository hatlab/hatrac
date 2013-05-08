(include-book "cryptography-defs")
(include-book "doublecheck" :dir :teachpacks)

(defproperty codevis->plainvis-inverts-plainvis->codevis
  (vals :value (random-list-of (random-between 0 94))
        :where (and (viscode-listp vals) (consp vals)))
  (equal (codevis->plainvis (plainvis->codevis vals)) vals))
