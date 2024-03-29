;;;; ecology.asd

(defsystem #:ecology
  :description "Describe ecology here"
  :author "Mykola Matvyeyev <mnasoft@gmail.com>"
  :license "GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007 or later"  
  :serial t
  :depends-on (#:cl-annot
	       #:hunchentoot #:cl-who #:mnas-string #:mnas-site #:mnas-dns #:mnas-site-route #:mnas-site-template
	        )
  :components ((:file "package")
               (:file "ecology")
               (:file "ecology-html")))
