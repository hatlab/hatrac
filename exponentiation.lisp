(include-book "doublecheck" :dir :teachpacks)
(include-book "arithmetic-3/top" :dir :system)
(include-book "arithmetic-3/floor-mod/floor-mod" :dir :system)

(defun pow (b n)
  (if (zp n)
      1
      (* b (pow b (1- n)))))

(defun rp (b n)
  (cond ((zp n)
         1)
        ((oddp n)
         (* b (rp (* b b) (floor n 2))))
        ((evenp n)
         (rp (* b b) (floor n 2)))))

(defproperty rp-equivalent-to-pow
  (b :value (random-natural)
   n :value (random-natural))
  (= (pow b n) (rp b n)))

(defproperty rp-equivalent-to-expt
   (b :value (random-natural)
      :where (natp b)
    n :value (random-natural)
      :where (natp n))
   (= (rp b n) (expt b n)))
