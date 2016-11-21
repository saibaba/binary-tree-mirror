(defpackage :mirror
  (:use :cl)
  (:export #:is-mirror #:is-mirror-stack #:make-node #:create-mirror))

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

(defun both-null (t1 t2)
  (and (null t1) (null t2)))

(defun both-not-null (t1 t2)
  (and (not (null t1)) (not (null t2))))

(defun only-one-null (t1 t2)
  (or
    (and (null t1) (not (null t2)))
    (and (not (null t1)) (null t2))))

(defun is-mirror-stack (tree1 tree2)
  (let* ( (stack nil) )
    (push (list tree1 tree2) stack)
    (loop for p on (pop stack)
          for t1 in (list (first p))
          for t2 in (list (second p))
          never (only-one-null t1 t2)
          always (or
                   (both-null t1 t2)
                   (equal (node-value t1) (node-value t2)))
          if (both-not-null t1 t2)
            do (progn (push (list (node-left t1) (node-right t2)) stack)
                    (push (list (node-right t1) (node-left t2)) stack))
          finally (return t )
          while stack)))

; both of above are extremely non-functional
; create a fmap for binary tree and use it to traverse original and generate new
; but fmap does not terminate when it etects that the trees are not mirror anymore (until end)
; use monad to terminate at will!
