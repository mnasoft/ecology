;;;; package.lisp

(defpackage #:ecology
  (:use #:cl #:mnas-string #:mnas-site #:hunchentoot #:cl-who)
  (:export CO-ppm->mg/m3
	   NOx-ppm->mg/m3)) 

;;;;(declaim (optimize (space 0) (compilation-speed 0)  (speed 0) (safety 3) (debug 3)))
