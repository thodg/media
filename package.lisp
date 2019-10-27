
(in-package :common-lisp)

(defpackage :media
  (:use :cl :cl-stream :str :unistd-stream)
  #.(cl-stream:shadowing-import-from)
  (:export
   #:media-type))
