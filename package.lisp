;;;; package.lisp

(defpackage #:ecology
  (:use #:cl #:mnas-string #:mnas-site #:mnas-dns #:mnas-site-route #:hunchentoot #:cl-who #:cl-ppcre)
  (:export CO-ppm->mg/m3
	   NOx-ppm->mg/m3)) 

;;;;(declaim (optimize (space 0) (compilation-speed 0)  (speed 0) (safety 3) (debug 3)))
