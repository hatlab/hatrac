(include-book "defstructure" :dir :teachpacks)
(include-book "doublecheck" :dir :teachpacks)
(include-book "binary-io-utilities" :dir :teachpacks)

(defsturcture header
  (file-length (:assert (natp file-length)))
  (offset (:assert (natp offset))
  (width (:assert (natp width)))
  (height (:assert (natp height)))
  (bits-per-pixel (:assert (natp bits-per-pixel)))
  (

(defun get-bmp (filename STATE)
  (mv-let (input error-open STATE)
          (binary-file->byte->list (string-append filename ".bmp") STATE)
          (if error-open
              (mv error-open STATE)
              (let* ((header-info (process-header input))
                     (width (header-width header-info))
                     (height (header-height header-info))
                     (offset (header-offset header-info))
                     (size (header-pixel-size header-info))
                     (pixel-data 
                      (get-pixels input offset size width height)))
                (mv (image header-info pixel-data) STATE)))))