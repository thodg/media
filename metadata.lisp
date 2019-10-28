
(in-package :media)

(defun flac-metadata-tag (x)
  (etypecase x
    (string (intern (cl-ppcre:regex-replace "[ _]+" x "-")
                    :keyword))
    (symbol x)))

(defun flac-metadata (pathname)
  (append (libflac:metadata-get-streaminfo pathname)
          (mapcan (lambda (tag)
                    (list (flac-metadata-tag (car tag)) (cdr tag)))
                  (libflac:metadata-get-tags pathname))))

(defun add-metadata (pathname)
  (unless (pathnamep pathname)
    (setq pathname (pathname pathname)))
  (let ((metadata (case (media-type pathname)
                    ((:flac) (flac-metadata pathname))
                    ((:wav) (wav-metadata pathname))
                    (t (error "unknown media type")))))
    (facts:add* `(,pathname ,@metadata))))

#+nil
(flac-metadata "/home/dx/Downloads/Umber Vamber - 2013 - Spacial Shift [FLAC]/01 - Umber Vamber - Spectrum Future.flac")

#+nil
(add-metadata "/home/dx/Downloads/Umber Vamber - 2013 - Spacial Shift [FLAC]/01 - Umber Vamber - Spectrum Future.flac")
