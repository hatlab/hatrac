(include-book "basiclex")
(include-book "split-blocks-concat-defs")
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

;(defproperty concat-inverts-split-at-delim
;  (ds :value (random-list-of (random-char))
;   xs :value (random-list-of (random-char))
;      :where (and (true-listp xs) (true-listp ds)))
;  (equal (concat (split-at-delimiter ds xs)) xs))

;(defproperty splitoff-prefix-delivers-shorter-list-tst
;  (ps :value (random-list-of (random-char))
;   xs :value (random-list-of (random-char))
;      :where (and (consp ps)
;                  (not (null (car (splitoff-prefix ps xs))))))
;  (< (len (caddr (splitoff-prefix ps xs)))
;              (len xs)))

(defproperty append-pseudoinverts-splitoff-prefix-1
  (ps :value (random-list-of (random-char))
   xs :value (random-list-of (random-char)))
  (equal (append (car (splitoff-prefix ps xs)) 
                 (caddr (splitoff-prefix ps xs)))
         xs))

(defproperty append-pseudoinverts-splitoff-prefix-2
  (ps :value (random-list-of (random-char))
   xs :value (random-list-of (random-char)))
  (equal (append (car (splitoff-prefix ps xs)) 
                 (cadr (splitoff-prefix ps xs)))
         ps))
  
(defproperty concat-inverts-split-on-token
  (tok :value (random-list-of (random-char))
   xs  :value (random-list-of (random-char)))
  (equal (concat (split-on-token tok xs)) xs))

;(defproperty split-on-token-delivers-shorter-list-tst
;  (tok :value (random-list-of (random-char))
;   xs  :value (random-list-of (random-char))
;       :where (and (consp xs)
;                   (consp tok)))
;           (< (len (caddr (split-on-token tok xs)))
;              (len xs)))
