;;
;;  media - media file utilities
;;  Copyright 2019 Thomas de Grivel <thoxdg@gmail.com> 0614550127
;;

(in-package :common-lisp-user)

(defpackage :media.system
  (:use :common-lisp :asdf))

(in-package :media.system)

(defsystem "media"
  :depends-on ("cl-stream"
               "str"
               "trivial-utf-8"
               "unistd-stream")
  :components
  ((:file "package")
   (:file "type" :depends-on ("package"))))
