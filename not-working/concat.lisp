(include-book "doublecheck" :dir :teachpacks)
(include-book "arithmetic-5/top" :dir :system)


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

(defproperty append-additive
  (xs :value (random-list-of (random-atom))
   ys :value (random-list-of (random-atom)))
  (= (+ (len xs) (len ys)) (len (append xs ys))))

(defproperty xs-is-a-prefix-of-append-xs-ys
  (xs :value (random-list-of (random-atom))
   ys :value (random-list-of (random-atom)))
  (equal (prefix (len xs) (append xs ys))
         xs))