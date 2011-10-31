(in-package "ACL2")

(include-book "arithmetic-3/floor-mod/floor-mod" :dir :system)
(include-book "doublecheck" :dir :teachpacks)

(include-book "binary-adders")

(defun add-1 (x)
  (if (consp x)
      (if (= (first x) 1)
          (cons 0 (add-1 (rest x)))
          (cons 1 (rest x)))
      (list 1)))

(defun add-c (c x)
  (if (= c 1)
      (add-1 x)
      x))

(defun add (c0 x y)
  (if (and (consp x) (consp y))
      (let* ((x0 (first x))
             (y0 (first y))
             (a  (full-adder c0 x0 y0))
             (s0 (first a))
             (c1 (second a)))
        (cons s0 (add c1 (rest x) (rest y))))
      (if (consp x)
          (add-c c0 x)
          (add-c c0 y))))

(defproperty add-ok
  (c :value (random-bit)
   x :value (random-list-of (random-bit))
   y :value (random-list-of (random-bit)))
  (= (num (add c x y))
     (+ (num (list c))
        (num x) (num y))))

(defun my1 (x y)
  (if (consp x)
      (let* ((m  (my1 (rest x) y)))
        (if (= (first x) 1)
            (cons (first y) (add 0 (rest y) m))
            (cons 0 m)))
      nil))

(defun mul (x y)
  (if (consp y)
      (my1 x y)
      nil))

(defproperty mul-ok
  (x :value (random-list-of (random-bit))
   y :value (random-list-of (random-bit)))
  (= (num (mul x y))
     (* (num x) (num y))))
