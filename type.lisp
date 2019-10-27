(in-package :media)

(defgeneric flac-p (object))

(defmethod flac-p ((path pathname))
  (with-stream (stream (unistd-stream-open path :read t
                                           :input-buffer-size 4))
    (flac-p stream)))

(defmethod flac-p ((stream input-stream))
  (and (= (char-code #\f) (read stream))
       (= (char-code #\L) (read stream))
       (= (char-code #\a) (read stream))
       (= (char-code #\C) (read stream))))

(defgeneric wav-p (object))

(defmethod wav-p ((path pathname))
  (with-stream (stream (unistd-stream-open path :read t
                                           :input-buffer-size 4))
    (wav-p stream)))

(defmethod wav-p ((stream input-stream))
  (let* ((c1 (read stream))
         (c2 (read stream))
         (c3 (read stream))
         (c4 (read stream)))
    (or (and (= (char-code #\W) c1)
             (= (char-code #\A) c2)
             (= (char-code #\V) c3)
             (= (char-code #\E) c4))
        (and (= (char-code #\R) c1)
             (= (char-code #\I) c2)
             (= (char-code #\F) c3)
             (= (char-code #\F) c4)))))

(defparameter *media-type-handlers*
  '((:flac . flac-p)
    (:wav . wav-p)))

(defun media-type (x)
  (dolist (handler *media-type-handlers*)
    (destructuring-bind (type &rest fn) handler
      (when (funcall fn x)
        (return type)))))
