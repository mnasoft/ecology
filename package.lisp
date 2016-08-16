;;;; package.lisp

(defpackage #:ecology
  (:use #:cl #:hunchentoot #:cl-who #:cl-ppcre #:mnas-string #:mnas-site #:mnas-dns #:mnas-site-route #:mnas-site-template)
  (:export CO-ppm->mg/m3
	   NOx-ppm->mg/m3)
  (:export ecology-stop ecology-start)) 

;;;;(declaim (optimize (space 0) (compilation-speed 0)  (speed 0) (safety 3) (debug 3)))
