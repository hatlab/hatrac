;;;All the theorems in this file have been proven - ARS 04/11/12;;;;;;;;;;;
(include-book "linear-encoding-and-thms")
(include-book "doublecheck" :dir :teachpacks)
(include-book "list-utilities" :dir :teachpacks)

(defun visibilize-txt (chrs)
  (if (consp chrs)
      (if (and (>= (char-code (car chrs)) 32)
               (<= (char-code (car chrs)) 126))
          (cons (car chrs) (visibilize-txt (cdr chrs)))
          (cons #\Space (visibilize-txt (cdr chrs))))
      nil))

(defun txt->vis (chrs)
  (if (consp chrs)
      (cons (- (char-code (car chrs)) 32) (txt->vis (cdr chrs)))
      nil))

(defun vis->txt (viscs)
  (if (consp viscs)
      (cons (code-char (+ 32 (car viscs))) (vis->txt (cdr viscs)))
      nil))

(defun plainvis->codevis (viscs)
  (encode 95 viscs))

(defun codevis->plainvis (viscs)
  (decode 95 viscs))

(defun visible-txt-listp (chrs)
  (or (endp chrs)
      (and (>= (char-code (car chrs)) 32)
           (<= (char-code (car chrs)) 126)
           (visible-txt-listp (cdr chrs)))))

(defun viscode-listp (vals)
  (code-listp 95 vals))

(defproperty visibilize-txt-delivers-list-of-visible-characters
  (chrs :value (random-list-of (random-char))
        :where (character-listp chrs))
  (visible-txt-listp (visibilize-txt chrs)))

(defproperty txt->vis-delivers-list-of-viscodes
  (chrs :value (visibilize-txt (random-list-of (random-char)))
        :where (visible-txt-listp chrs))
  (viscode-listp (txt->vis chrs)))

(defproperty nth-viscode-is-nth-element
  (chrs :value (visibilize-txt (random-list-of (random-char)))
        :where (and (visible-txt-listp chrs) (consp chrs))
      n :value (random-between 0 (1- (len chrs)))
        :where (and (natp n) (<= n (1- (len chrs)))))
  (equal (- (char-code (nth n chrs)) 32) (nth n (txt->vis chrs))))

(defproperty vis->txt-delivers-list-of-characters
  (vals :value (random-list-of (random-between 0 94))
        :where (viscode-listp vals))
  (character-listp (vis->txt vals)))

(defproperty nth-character-is-nth-element
  (vals :value (random-list-of (random-between 0 94))
        :where (and (viscode-listp vals) (consp vals))
      n :value (random-between 0 (1- (len vals)))
        :where (and (natp n) (<= n (1- (len vals)))))
  (equal (code-char (+ 32 (nth n vals))) (nth n (vis->txt vals))))

(defproperty codevis->plainvis-inverts-plainvis->codevis
  (vals :value (random-list-of (random-between 0 94))
        :where (and (viscode-listp vals) (consp vals)))
  (equal (codevis->plainvis (plainvis->codevis vals)) vals))