(in-package "ACL2")

(defun Fibonacci (n)
    (if (zp n)
         0
         (if (= n 1)
              1
              (+ (Fibonacci (- n 1))
                  (Fibonacci (- n 2))))))
(defun fib-tail (n a b)
    (if (zp n)
         a
         (if (= n 1)
              b
              (fib-tail (- n 1) b (+ a b)))))
(defun Fibonacci-fast (n)
    (fib-tail n 0 1))

(defun fib-tail-extra (n a b)
    (if (zp n)
         a
         (fib-tail-extra (- n 1) b (+ a b))))
(defun Fibonacci-faster (n)
     (fib-tail-extra n 0 1))
