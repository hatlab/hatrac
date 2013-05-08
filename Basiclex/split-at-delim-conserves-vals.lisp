(in-package "ACL2")
(include-book "basiclex-defs")
(include-book "split-blocks-concat-defs")
(include-book "doublecheck" :dir :teachpacks)

(defproperty split-at-delim-conserves-vals
  (ds :value (random-list-of (random-integer))
   xs :value (random-list-of (random-integer)))
  (let* ((pair (split-at-delimiter ds xs))
         (pfx (car pair))
         (sfx (cadr pair)))
    (equal (append pfx sfx)
           xs)))
