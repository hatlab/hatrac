(include-book "basiclex")
(include-book "doublecheck" :dir :teachpacks)

(defproperty split-at-delim-conserves-vals-tst
  (ds :value (random-list-of (random-char))
   xs :value (random-list-of (random-char)))
  (let* ((pair (split-at-delimiter ds xs))
         (pfx (car pair))
         (sfx (cadr pair)))
    (equal (append pfx sfx)
           xs)))

(defproperty split-at-delim-delivers-no-delims-in-prefix-tst
  (ds :value (random-list-of (random-char))
   xs :value (random-list-of (random-char))
   x  :value (random-char)
      :where (member-equal x (car (split-at-delimiter ds xs))))
  (not (member-equal x ds)))

(defproperty split-at-delim-delivers-suffix-that-starts-with-delim-tst
  (ds :value (random-list-of (random-char))
   xs :value (random-list-of (random-char))
      :where (consp (cadr (split-at-delimiter ds xs))))
  (member-equal (car (cadr (split-at-delimiter ds xs))) ds))

(defproperty split-at-delim-does-not-deliver-longer-lists-tst
  (ds :value (random-list-of (random-char))
   xs :value (random-list-of (random-char)))
  (and (<= (len (car (split-at-delimiter ds xs)))
                    (len xs))
                (<= (len (cadr (split-at-delimiter ds xs)))
                    (len xs))))

;(defproperty splitoff-match-delivers-shorter-list-tst
;  (ps :value (random-list-of (random-char))
;   xs :value (random-list-of (random-char))
;      :where (and (consp ps)
;                  (not (null (car (splitoff-prefix ps xs))))))
;  (< (len (caddr (splitoff-prefix ps xs)))
;              (len xs)))
;
;(defproperty split-on-token-delivers-shorter-list-tst
;  (tok :value (random-list-of (random-char))
;   xs  :value (random-list-of (random-char))
;       :where (and (consp xs)
;                   (consp tok)))
;           (< (len (caddr (split-on-token tok xs)))
;              (len xs)))
