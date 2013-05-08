(in-package "ACL2")
(include-book "fibonacci-defs")
(include-book "fibonacci-fibonacci-fast")
(include-book "fibonacci-fibonacci-faster")
(include-book "arithmetic-5/top" :dir :system)
(include-book "doublecheck" :dir :teachpacks)

(defproperty Fibonacci-fast=Fibonacci-faster
  (n :value (random-natural))
  (= (Fibonacci-fast  n)
     (Fibonacci-faster n))
:hints (("Goal"
         :use ((:instance Fibonacci=Fibonacci-fast)
               (:instance Fibonacci=Fibonacci-faster)))))
