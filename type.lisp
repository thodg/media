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
  (and (= (char-code #\W) (read stream))
       (= (char-code #\A) (read stream))
       (= (char-code #\V) (read stream))
       (= (char-code #\E) (read stream))))

(defparameter *media-type-handlers*
  '((:flac . flac-p)
    (:wav . wav-p)))

(defun media-type (x)
  (dolist (handler *media-type-handlers*)
    (destructuring-bind (type &rest fn) handler
      (when (funcall fn x)
        (return type)))))
