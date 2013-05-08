(include-book "cryptography-defs")
(include-book "doublecheck" :dir :teachpacks)

(defproperty nth-viscode-is-nth-element
  (codes :value (random-list-of (random-between 0 255))
    chrs :value (visibilize-txt (codes->chrs codes))
         :where (and (visible-txt-listp chrs) (consp chrs))
       n :value (random-between 0 (1- (len chrs)))
         :where (and (natp n) (<= n (1- (len chrs)))))
  (equal (- (char-code (nth n chrs)) 32) (nth n (txt->vis chrs))))
