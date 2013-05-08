(include-book "cryptography-defs")
(include-book "doublecheck" :dir :teachpacks)

(defproperty txt->vis-delivers-list-of-viscodes
  (codes :value (random-list-of (random-between 0 255))
    chrs :value (visibilize-txt (codes->chrs codes))
         :where (visible-txt-listp chrs))
  (viscode-listp (txt->vis chrs)))