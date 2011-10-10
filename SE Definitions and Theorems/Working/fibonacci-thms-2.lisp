(include-book "fibonacci")
(include-book "arithmetic-5/top" :dir :system)

(defthm fib-tail-Fibonacci-recurrence-case-0
    (= (fib-tail 0 a b) a))
(defthm fib-tail-Fibonacci-recurrence-case-1
    (= (fib-tail 1 a b) b))
(defthm fib-tail-satisfies-Fibonacci-recurrence
  (implies (and (natp n) (>= n 2))
           (= (fib-tail n a b) 
              (+ (fib-tail (- n 1) a b)
                 (fib-tail (- n 2) a b)))))

(defthm Fibonacci=Fibonacci-fast
  (implies (natp n)
           (= (Fibonacci n) (Fibonacci-fast n))))

(defthm fib-extra-Fibonacci-recurrence-case-0
  (= (fib-tail-extra 0 a b) 
     a))
(defthm fib-extra-Fibonacci-recurrence-case-1
  (= (fib-tail-extra 1 a b)
     b))
(defthm fib-tail-extra-satisfies-Fibonacci-recurrence
  (implies (and (natp n) (>= n 2))
           (= (fib-tail-extra n a b) 
              (+ (fib-tail-extra (- n 1) a b) 
                 (fib-tail-extra (- n 2) a b)))))
(defthm Fibonacci=Fibonacci-faster
  (implies (natp n)
           (= (Fibonacci n)
              (Fibonacci-faster n)))
  :hints (("Goal"
           :in-theory
           (disable fib-tail-Fibonacci-recurrence-case-0
                    fib-tail-Fibonacci-recurrence-case-1
                    fib-tail-satisfies-Fibonacci-recurrence
                    Fibonacci=Fibonacci-fast))))
(defthm Fibonacci-fast=Fibonacci-faster
  (implies (natp n)
           (= (Fibonacci-fast  n)
              (Fibonacci-faster n)))
  :hints (("Goal"
           :use ((:instance Fibonacci=Fibonacci-fast)
                 (:instance Fibonacci=Fibonacci-faster)))))
