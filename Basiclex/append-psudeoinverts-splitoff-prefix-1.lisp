(in-package "ACL2")
(include-book "basiclex-defs")
(include-book "split-blocks-concat-defs")
(include-book "doublecheck" :dir :teachpacks)

(defproperty append-pseudoinverts-splitoff-prefix-1
  (ps :value (random-list-of (random-integer))
   xs :value (random-list-of (random-integer)))
  (equal (append (car (splitoff-prefix ps xs)) 
                 (caddr (splitoff-prefix ps xs)))
         xs))
