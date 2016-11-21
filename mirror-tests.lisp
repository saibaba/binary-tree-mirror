(defpackage :mirror-tests
  (:use :cl :lisp-unit :mirror))

(in-package :mirror-tests)

(defun sample-mirror-tree1()
  (make-node :value 10 :left (make-node  :value 5) :right (make-node :value 15)))

(defun sample-mirror-tree2()
  (make-node :value 100 :left (make-node  :value 50) :right (make-node :value 150)))

(define-test empty-tree-test (assert-true (is-mirror nil nil)))
(define-test empty-with-non-empty-1 (assert-false (is-mirror (make-node :value 10) (make-node))))
(define-test empty-with-non-empty-2 (assert-false (is-mirror (make-node) (make-node :value 10) )))

(define-test one-node-tree (assert-true (is-mirror (make-node :value 10) (make-node :value 10))))

(define-test one-node-not-a-mirror-tree (assert-false (is-mirror (make-node :value 10) (make-node :value 20))))

;                2                              2
;        3              4           4                    4
;   5        6     7        8   8       7         6           5
;9    10   11 12  13 14  15  161615   14  13    12  11       10 9

(defun sample-big-tree1()
  (make-node :value 2
    :left (make-node :value 3
      :left (make-node :value 5 :left (make-node :value 9) :right (make-node :value 10))
      :right (make-node :value 6 :left (make-node :value 11) :right (make-node :value 12)))
    :right (make-node :value 4
      :left (make-node :value 7 :left (make-node :value 13) :right (make-node :value 14))
      :right (make-node :value 8 :left (make-node :value 15) :right (make-node :value 16)))))

(defun sample-big-tree2()
  (make-node :value 2
    :left (make-node :value 4
      :left (make-node :value 8 :left (make-node :value 16) :right (make-node :value 15))
      :right (make-node :value 7 :left (make-node :value 14) :right (make-node :value 13)))
    :right (make-node :value 3
      :left (make-node :value 6 :left (make-node :value 12) :right (make-node :value 11))
      :right (make-node :value 5 :left (make-node :value 10) :right (make-node :value 9)))))

(define-test big-tree-test (assert-true (is-mirror (sample-big-tree1) (sample-big-tree2))))

(defun sample-partial-tree1 ()
  (make-node :value 1
    :left (make-node :value 2 :left (make-node :value 3) )
    :right (make-node :value 2 :right (make-node :value 3))))

(define-test partial-tree-test1 (assert-true (is-mirror (sample-partial-tree1) (sample-partial-tree1))))

(defun sample-asym-tree1()
  (make-node :value 1
    :left (make-node :value 2 :left (make-node :value 4) )
    :right (make-node :value 3 :left (make-node :value 5))))

(defun sample-asym-tree2()
  (make-node :value 1
    :left (make-node :value 3 :right (make-node :value 5) )
    :right (make-node :value 2 :right (make-node :value 4))))

(define-test asym-tree-test (assert-true (is-mirror (sample-asym-tree1) (sample-asym-tree2))))

(defun a-tree()
  (make-node :value 4
    :left (make-node :value 2 :left (make-node :value 1) :right (make-node :value 3))
    :right (make-node :value 6 :left (make-node :value 5) :right (make-node :value 7))))

(define-test create-mirror-test1 (assert-true (is-mirror (a-tree) (create-mirror (a-tree)))))

; iterative version

(define-test empty-tree-test-stack (assert-true (is-mirror-stack nil nil )))
(define-test empty-with-non-empty-1-stack (assert-false (is-mirror-stack (make-node :value 10) nil )))
(define-test empty-with-non-empty-2-stack (assert-false (is-mirror-stack (make-node) (make-node :value 10) )))
(define-test one-node-tree-stack (assert-true (is-mirror-stack (make-node :value 10) (make-node :value 10))))
(define-test one-node-not-a-mirror-tree-stack (assert-false (is-mirror-stack (make-node :value 10) (make-node :value 20))))
(define-test big-tree-test-stack (assert-true (is-mirror-stack (sample-big-tree1) (sample-big-tree2))))
(define-test partial-tree-test1-stack (assert-true (is-mirror-stack (sample-partial-tree1) (sample-partial-tree1))))
(define-test asym-tree-test-stack (assert-true (is-mirror-stack (sample-asym-tree1) (sample-asym-tree2))))
