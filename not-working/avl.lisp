(include-book "doublecheck" :dir :teachpacks)
(include-book "arithmetic-3/top" :dir :system)

(defun key (tree) (first tree))
(defun val (tree) (second tree))
(defun left (tree) (third tree))
(defun right (tree) (fourth tree))

(defun pow (b n)
  (if (zp n)
      1
      (* b (pow b (1- n)))))

(defun height (tree)
  (if (endp tree)
      0
      (+ 1 (max (height (left tree)) (height (right tree))))))

(defun size (tree)
  (if (endp tree)
      0
      (+ 1 (size (left tree)) (size (right tree)))))

(defun valid-treep (tree)
  (if (endp tree)
      t
      (and (rationalp (key tree))
           (implies (consp (left tree))
                    (<= (key (left tree)) (key tree)))
           (implies (consp (right tree))
                    (> (key (right tree)) (key tree)))
           (valid-treep (left tree))
           (valid-treep (right tree)))))

; Theorem: full tree
; \forall h. \forall s. ((height s = h) \wedge (size s >= 2^h - 1))

(defproperty full-tree
  (h :where (natp h) :value (random-natural)
   s :where (and (valid-treep h) (= (height s) h)) :value nil)
  (>= (size s) (- (pow 2 h) 1)))