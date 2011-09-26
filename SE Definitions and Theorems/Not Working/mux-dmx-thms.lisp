(in-package "ACL2")
(include-book "mux-dmx-defs")
(include-book "doublecheck" :dir :teachpacks)

(defproperty dmx-preserves-length-tst :repeat 100
  (xys :value (random-list-of (random-natural)))
  (= (+ (len (car (dmx xys)))
        (len (cadr (dmx xys))))
     (len xys)))

(defproperty dmx-conservation-of-elements :repeat 100
  (xys :value (random-list-of (random-between 0 10))
   e   :value (random-between 0 20))
  (iff (member-equal e xys)
       (or (member-equal e (car (dmx xys)))
           (member-equal e (cadr (dmx xys))))))
;
;(defproperty dmx-evens=xs-tst :repeat 100
;  (xys :value (random-list-of (random-natural)))
;  (equal (car (dmx xys))
;         (every-other xys)))
;
;(defproperty dmx-odds=ys-tst :repeat 100
;  (xys :value (random-list-of (random-natural)))
;  (equal (cadr (dmx xys))
;         (every-odd xys)))

(defproperty mux-preserves-length-tst :repeat 100
  (xs :value (random-list-of (random-natural))
   ys :value (random-list-of (random-natural)))
  (= (+ (len xs) (len ys))
     (len (mux xs ys))))

;(defproperty mux-conservation-of-elements :repeat 100
;  (xs :value (random-list-of (random-natural))
;   ys :value (random-list-of (random-natural))
;   e  :value (random-natural))
;  (iff (member-equal e (mux xs ys))
;       (or (member-equal e xs)
;           (member-equal e ys))))

;(defproperty mux-evens=xs-tst :repeat 100
;  (n  :value (random-data-size)
;   xs :value (random-list-of (random-natural) :size n)
;   ys :value (random-list-of (random-natural) :size n)
;      :where (= (len xs) (len ys)))
;  (equal (every-other (mux xs ys))
;         xs))
;
;(defproperty mux-odds=ys-tst :repeat 100
;  (xs :value (random-list-of (random-natural))
;   ys :value (random-list-of (random-natural) :size (len xs))
;      :where (= (len xs) (len ys)))
;  (equal (every-odd (mux xs ys))
;         ys))

;(defproperty dmx-inverts-mux-tst :repeat 100
;  (xs :value (random-list-of(random-natural))
;   ys :value (random-list-of(random-natural) :size (len xs))
;      :where (= (len xs) (len ys)))
;  (equal (dmx (mux xs ys))
;         (list xs ys)))

;(defproperty mux-inverts-dmx-tst :repeat 100
;  (xys :value (random-list-of (random-natural)))
;  (equal (mux (car (dmx xys))
;              (cadr (dmx xys)))
;         xys))
