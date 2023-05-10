(load "parser.lisp")
(load "tokenizer.lisp")

(defvar demos (list
  '(+ 2 2)
  '(* 3 4)
  '(- 5 6)
  '(/ 7 8)
  '(- (- 11 10) (* 9 10))
))

(defun map-index (function sequence)
  (loop for element in sequence
        for index from 0
        collect (funcall function element index)))

(map-index (lambda (demo index) 
   (let ((demo-input demo))
     (format 't "================DEMO#~A=================~%" (+ 1 index))
     (format 't "input: ~A~%" demo-input)
     (format 't "expected: ~A~%" (eval demo-input))
     (format 't "output: ~A~%" (lil-parse (lil-tokenize (princ-to-string demo-input))))
)) demos)
(format 't "========================================~%")


