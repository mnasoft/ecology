;;;; package.lisp

(defpackage #:ecology
  (:use #:cl 
;;;;	#:cl-ppcre
	#:hunchentoot
	#:cl-who
	#:mnas-string
	#:mnas-site
	#:mnas-dns #:mnas-site-route #:mnas-site-template
	)) 

;;;;(declaim (optimize (space 0) (compilation-speed 0)  (speed 0) (safety 3) (debug 3)))

;;;; (declaim (optimize (compilation-speed 0) (debug 3) (safety 0) (space 0) (speed 0)))
