#!/usr/local/bin/sbcl --script
(load "~/quicklisp/setup.lisp")
(ql:quickload "mirror")
(in-package :mirror-tests)
(setq *print-failures* t)
(print-errors (lisp-unit:run-tests))
