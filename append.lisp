(in-package "ACL2")

(include-book "doublecheck" :dir :teachpacks)
(include-book "arithmetic-3/top" :dir :system)

(defun concat (xss)
  (if (endp xss)
      nil
      (append (car xss) (concat (cdr xss)))))

(defun prefix (n xs)
  (if (zp n)
      nil
      (if (endp xs)
          nil
          (cons (car xs)
                (prefix (- n 1) (cdr xs))))))

(defproperty append-len-additive
  (xs :value (random-list-of (random-atom))
   ys :value (random-list-of (random-atom)))
  (= (+ (len xs) (len ys)) (len (append xs ys))))

(defproperty append-associative
  (xs :value (random-list-of (random-atom))
   ys :value (random-list-of (random-atom))
   zs :value (random-list-of (random-atom)))
  (equal (append xs (append ys zs)) (append (append xs ys) zs)))

;(defthm xs-is-prefix-of-xs++ys
;  (implies (and (true-listp xs) (true-listp ys))
;           (equal (prefix (length xs) (append xs ys))
;                  xs)))

(defproperty xs-is-a-prefix-of-append-xs-ys
  (xs :where (true-listp xs) :value (random-list-of (random-atom))
   ys :where (true-listp ys) :value (random-list-of (random-atom)))
  (equal (prefix (length xs) (append xs ys))
         xs))
