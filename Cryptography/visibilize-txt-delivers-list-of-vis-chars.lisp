(include-book "cryptography-defs")
(include-book "doublecheck" :dir :teachpacks)

(defproperty visibilize-txt-delivers-list-of-visible-characters
  (codes :value (random-list-of (random-between 0 255))
   chrs  :value (codes->chrs codes)
         :where (character-listp chrs))
  (visible-txt-listp (visibilize-txt chrs)))
