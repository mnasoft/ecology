;;;; ecology.asd

(asdf:defsystem #:ecology
  :description "Describe ecology here"
  :author "Your Name <your.name@example.com>"
  :license "Specify license here"
  :serial t
  :depends-on (#:hunchentoot #:cl-who #:mnas-string #:mnas-site #:mnas-dns #:mnas-site-route)
  :components ((:file "package")
               (:file "ecology")
               (:file "ecology-html")))

