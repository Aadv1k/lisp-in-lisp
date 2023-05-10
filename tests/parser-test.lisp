(load "./lib/pest.lisp")
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
	     (let (
		   (computed (nth 0 (lil-parse (lil-tokenize (princ-to-string demo))))))

     (pest-assert-a-equal-to-b computed (eval demo))
)) demos)
