(in-package "ACL2")
(include-book "fibonacci-defs")
(include-book "fibonacci-fibonacci-fast")
(include-book "arithmetic-5/top" :dir :system)
(include-book "doublecheck" :dir :teachpacks)

(defproperty fib-extra-Fibonacci-recurrence-case-0
  (a :value (random-natural)
   b :value (random-natural))
  (= (fib-tail-extra 0 a b) 
     a))
(defproperty fib-extra-Fibonacci-recurrence-case-1
  (a :value (random-natural)
   b :value (random-natural))
  (= (fib-tail-extra 1 a b)
     b))
(defproperty fib-tail-extra-satisfies-Fibonacci-recurrence
  (a :value (random-natural)
   b :value (random-natural)
   n :value (random-natural)
     :where (and (>= n 2) (natp n)))
  (= (fib-tail-extra n a b) 
     (+ (fib-tail-extra (- n 1) a b) 
        (fib-tail-extra (- n 2) a b))))
(defproperty Fibonacci=Fibonacci-faster
  (n :value (random-between 2 15))
  (= (Fibonacci n)
     (Fibonacci-faster n))
:hints (("Goal"
         :in-theory
         (disable fib-tail-Fibonacci-recurrence-case-0
                  fib-tail-Fibonacci-recurrence-case-1
                  fib-tail-satisfies-Fibonacci-recurrence
                  Fibonacci=Fibonacci-fast))))
