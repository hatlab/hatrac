;;;All the theorems in this file have been proven - ARS 04/11/12;;;;;;;;;;;
(IN-PACKAGE "ACL2")
(include-book "linear-encoding-defs")
(include-book "doublecheck" :dir :teachpacks)
(include-book "list-utilities" :dir :teachpacks)

(defun codes->chrs (codes)
   (if (endp codes)
       nil
       (cons (code-char (car codes)) (codes->chrs (cdr codes)))))

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