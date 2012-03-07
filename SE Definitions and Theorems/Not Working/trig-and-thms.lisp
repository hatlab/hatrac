(include-book "doublecheck" :dir :teachpacks)

(defun ^ (b p)
  (if (zp p)
      1
      (if (< p 0)
          (/ 1 (^ b (- p)))
          (* b (^ b (1- p))))))

(defun sin-series (k s p n r x)
  (if (<= k 0)
      s
      (let* ((next-term (* p (- (/ (* x x) (* (* 2 n) (1+ (* 2 n)))))))
             (prev-error (/ next-term (* 2 s))))
        (if (<= (abs prev-error) r)
            s
            (sin-series (1- k) (+ s next-term) next-term (1+ n) r x)))))

(defun sin (r x)
  (if (< x 1)
      (if (< 0 x)
          (sin-series 100000000 x x 1 r x)
          (if (= 0 x)
              0
              (- (sin r (- x)))))
      (let ((sx/3 (sin r (/ x 3))))
        (* sx/3 (- 3 (* 4 (^ sx/3 2)))))))

(defun cos (r x)
  (- 1 (* 2 (^ (sin r (/ x 2)) 2))))
  
;(defun tan (r x)
;  (/ (sin r x) (cos r x)))
;

(defun arctan-series (k s p n r x)
  (if (<= k 0)
      s
      (let* ((next-term (* p (- (* (* x x) 
                                   (/ (1- (* 2 n)) (1+ (* 2 n)))))))
             (prev-error (/ next-term (* 2 s))))
        (if (<= (abs prev-error) r)
            s
            (sin-series (1- k) (+ s next-term) next-term (1+ n) r x)))))

(defun arctan (r x)
  (if (< x 0)
      (- (arctan r (- x)))
      (arctan-series 1000000000 x x 1 r x)))

(defun q (r)
  (- (* 4 (arctan r (/ 1 5))) (arctan r (/ 1 239))))

(defun atan2-r (r x y qr)
  (let ((y/x (/ y x)))
    (if (> (abs y/x) 1)
        (- (* 2 qr) (arctan r (/ 1 y/x)))
        (arctan r y/x))))

(defun atan2 (r y x)
  (if (= y 0)
      (if (< x 0)
          (* -4 (q r))
          0)
      (if (= x 0)
          (if (> y 0)
              (* 2 (q r))
              (* -2 (q r)))
          (if (> x 0)
              (atan2-r r x y (q r))
              (if (>= y 0)
                  (+ (* 4 (q r)) (atan2-r r x y (q r)))
                  (+ (* -4 (q r)) (atan2-r r x y (q r))))))))