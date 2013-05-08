; tests specify programmer expectations
(in-package "ACL2")
(include-book "doublecheck" :dir :teachpacks)

(defproperty len-is-natural-number
  (xs :value (random-list-of (random-integer)))
  (natp (len xs)))
