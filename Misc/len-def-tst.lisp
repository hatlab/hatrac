; tests specify programmer expectations
(in-package "ACL2")
(include-book "doublecheck" :dir :teachpacks)

(defproperty len-def-tst
  (xs :value (random-list-of (random-integer))
      :where (consp xs))
  (= (len xs) (1+ (len (cdr xs)))))
