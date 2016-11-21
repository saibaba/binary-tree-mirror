(defpackage :mirror
  (:use :cl)
  (:export #:is-mirror #:make-node #:create-mirror))

(in-package #:mirror)

;;; "mirror" goes here. Hacks and glory await!

(defstruct node
  value
  left
  right)

(defun is-mirror (tree1 tree2)
  (if (and (null tree1) (null tree2))
    t
    (and (equal (node-value tree1) (node-value tree2))
         (is-mirror (node-left tree1) (node-right tree2))
         (is-mirror (node-right tree1) (node-left tree2)))))

(defun create-mirror(tree)
  (if (null tree)
    nil
    (make-node :value (node-value tree)
      :left (create-mirror (node-right tree))
      :right (create-mirror (node-left tree)))))
