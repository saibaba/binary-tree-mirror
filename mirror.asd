;;;; mirror.asd

(asdf:defsystem #:mirror
  :description "Describe mirror here"
  :author "Your Name <your.name@example.com>"
  :license "Specify license here"
  :serial t
  :depends-on (:lisp-unit)
  :components ((:file "mirror")
               (:file "mirror-tests")))

