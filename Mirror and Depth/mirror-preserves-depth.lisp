(in-package "ACL2")
(include-book "doublecheck" :dir :teachpacks)
(include-book "mirror-and-depth-defs")

(defproperty mirror-preserves-depth
  (p :value (random-sexp-of (random-symbol)))
  (equal (depth p) (depth (mirror p))))