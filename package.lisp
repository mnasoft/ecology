;;;; package.lisp

(defpackage #:ecology
  (:use #:cl #:mnas-string #:postmodern #:hunchentoot #:cl-who)
  (:export CO-ppm->mg/m3
	   NOx-ppm->mg/m3)) 

(declaim (optimize (speed 0) (safety 3) (debug 3)))
