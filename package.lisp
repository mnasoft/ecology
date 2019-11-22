;;;; package.lisp

(defpackage #:ecology)

(defpackage #:ecology
  (:use #:cl #:hunchentoot #:cl-who
;;;;	#:cl-ppcre
	#:mnas-string #:mnas-site #:mnas-dns #:mnas-site-route #:mnas-site-template)
  (:export ecology::CO-ppm->mg/m3
	   ecology::NOx-ppm->mg/m3)
  (:export ecology::ecology-stop ecology-start)) 

;;;;(declaim (optimize (space 0) (compilation-speed 0)  (speed 0) (safety 3) (debug 3)))

;;;; (declaim (optimize (compilation-speed 0) (debug 3) (safety 0) (space 0) (speed 0)))
