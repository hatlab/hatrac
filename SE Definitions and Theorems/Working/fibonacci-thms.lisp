(include-book "fibonacci")
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
  (n :value (random-natural))
  (= (Fibonacci n) (Fibonacci-fast n)))

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
  (n :value (random-natural))
  (= (Fibonacci n)
     (Fibonacci-faster n))
:hints (("Goal"
         :in-theory
         (disable fib-tail-Fibonacci-recurrence-case-0
                  fib-tail-Fibonacci-recurrence-case-1
                  fib-tail-satisfies-Fibonacci-recurrence
                  Fibonacci=Fibonacci-fast))))
(defproperty Fibonacci-fast=Fibonacci-faster
  (n :value (random-natural))
  (= (Fibonacci-fast  n)
     (Fibonacci-faster n))
:hints (("Goal"
         :use ((:instance Fibonacci=Fibonacci-fast)
               (:instance Fibonacci=Fibonacci-faster)))))
