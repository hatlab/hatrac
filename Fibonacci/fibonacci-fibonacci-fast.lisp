(in-package "ACL2")
(include-book "fibonacci-defs")
(include-book "arithmetic-5/top" :dir :system)
(include-book "doublecheck" :dir :teachpacks)

(defproperty fib-tail-Fibonacci-recurrence-case-0
  (a :value (random-natural)
   b :value (random-natural))
  (= (fib-tail 0 a b) a))
(defproperty fib-tail-Fibonacci-recurrence-case-1
  (a :value (random-natural)
   b :value (random-natural))
  (= (fib-tail 1 a b) b))
(defproperty fib-tail-satisfies-Fibonacci-recurrence
  (a :value (random-natural)
   b :value (random-natural)
   n :value (random-natural)
     :where (and (natp n) (>= n 2)))
  (= (fib-tail n a b) 
     (+ (fib-tail (- n 1) a b)
        (fib-tail (- n 2) a b))))

;The above fails without (natp n).  Interesting.

(defproperty Fibonacci=Fibonacci-fast
  (n :value (random-between 2 20))
  (= (Fibonacci n) (Fibonacci-fast n)))

