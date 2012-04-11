(include-book "doublecheck" :dir :teachpacks)

(defun big-and (bs)
   (if (endp bs)
       t
       (and (first bs)
            (big-and (rest bs)))))

(defproperty big-and-nil-if-any-element-is-nil
   (bs :value (random-list-of (random-boolean)))
  (implies (member nil bs)
           (not (big-and bs))))

(defun running-and (bs r)
   (if (endp bs)
       r
       (running-and (rest bs) (and (first bs) r))))

(defproperty running-and=big-and
   (bs :value (random-list-of (random-boolean)))
  (iff (running-and bs t)
       (big-and bs)))

(defun tail-fib (n a b)
   (if (zp n)
       b
       (tail-fib (- n 1) b (+ a b))))

(defproperty tail-fib-one-step
   (n :value (random-natural) :where (natp n)
    a :value (random-natural) :where (rationalp a)
    b :value (random-natural) :where (rationalp b))
  (= (tail-fib (+ n 2) a b)
     (+ (tail-fib (+ n 1) a b)
        (tail-fib n a b))))

(defproperty append-preserves-elements
  (xs :value (random-list-of (random-atom))
   ys :value (random-list-of (random-atom))
   x :value (random-element-of (list (random-element-of xs)
                                     (random-element-of ys)
                                     (random-atom))))
  (implies (or (member x xs)
               (member x ys))
           (member x (append xs ys))))

(defun slow-fib (n)
  (cond ((zp n) 0)
        ((zp (- n 1)) 1)
        (t (+ (slow-fib (- n 1)) (slow-fib (- n 2))))))

(defproperty tail-fib=slow-fib
  (n :value (random-natural))
  (= (tail-fib n 0 1)
     (slow-fib n)))











