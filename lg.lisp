(include-book "doublecheck" :dir :teachpacks)
(include-book "arithmetic-3/top" :dir :system)
(include-book "arithmetic-3/floor-mod/floor-mod" :dir :system)

(defun pow (b n)
  (if (zp n)
      1
      (* b (pow b (1- n)))))

(defun ceil (n d)
  (let ((fl (floor n d)))
    (if (= fl (/ n d))
        fl
        (1+ fl))))

(defun lg (n)
  (if (or (= n 1) (not (and (natp n) (> n 0))))
      0
      (1+ (lg (ceil n 2)))))

(defproperty lg-reverses-pow-2
  (n :where (and (natp n) (> n 0)) :value (+ 1 (random-natural)))
  (>= (pow 2 (lg n)) n))