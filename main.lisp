(load "./lib/utils.lisp")
(load "exceptions.lisp")

(defconstant token-lp 'LPAREN)
(defconstant token-rp 'RPAREN)
(defconstant token-number 'NUMBER)
(defconstant token-symbol 'SYMBOL)

(defun find-next-char-from-index (str ch index)
  (loop for i from index below (length str) do 
    (if (char= (char str i) ch) (return (list (+ i index) i)))
  )
)


;;(push tokens (lil-split-expr (subseq str (+ i 1) (nth 1 (find-next-char-from-index str #\) 0)))))

(defun lil-parse-expr (str) 
  (reverse (
            map 'list (lambda (elem) 
                        (cond ((numberp 
                                 (parse-integer elem :junk-allowed t)
                                 ) (list token-number (parse-integer elem))) (t (list token-symbol elem)))) (utl-split-string str " ")))
)

(defun lil-split-expr (str)
  "Will tokenize expression within parenthesis"
  (let ((tokens (list)) (trunc-str ""))
    (dotimes (i (length str)) 
      (cond 
        ((char= (char str i) #\() (progn 
              (push (list token-lp) tokens)
              )
            )
        ((char= (char str i) #\)) (push (list token-rp) tokens))
       (t (progn (setq trunc-str (concatenate 'string trunc-str (string (char str i))))))
      )
   )


  (lil-parse-expr trunc-str))
)


(defun do-op-on-stack (op stack) 
  (let ((result 0)) 
    (dotimes (i (length stack))
      (cond
        ((string= op "+") (setq result (+ result (nth i stack)))) 
        ((string= op "-") (setq result (- result (nth i stack)))) 
        ((string= op "/") (setq result (/ result (nth i stack)))) 
        ((string= op "*") (setq result (* (if (eql result 0) 1 result) (nth i stack)))) 
      )
    )
  result)
)

(defun lil-sus (expr)
  (let ((stack '()))
  (dotimes (i (length expr))
    (let ((token (nth i expr)))
      (cond 
        ((eql token-number (nth 0 token)) (push (nth 1 token) stack))
        ((eql token-symbol (nth 0 token)) (progn
            (let ((computed (do-op-on-stack (nth 1 token) stack)))
              (setq stack ())
              (push computed stack)
            )
        ))
      )
    )
  )
  stack)
)

;;(print (lil-split-expr  "(+ 1 (+ 1 (* 1 2)))"))

(print (lil-sus (lil-split-expr "(+ 1 (- 0 (* 1 2)))")))
(terpri)


(defun lil-tokenize-line (str)
  (let ((tokens (list)) (cursor 0) (paren-open t))
    (dotimes (i (length str))
      (cond
        ((char= (char str i) #\() (push `(,token-lp ,i) tokens)) 
        ((char= (char str i) #\)) (push `(,token-rp ,i) tokens)) 
        ((char= (char str i) #\+) (push `(,token-symbol ,i ,(char str i)) tokens)) 
        ((char= (char str i) #\-) (push `(,token-symbol ,i ,(char str i)) tokens)) 
        ((digit-char-p (char str i)) (progn 
              (print (char str i))
              (print (find-next-char-from-index str #\Space i))
              ;;(print (subseq str 0 (nth 0 (find-next-char-from-index str #\Space i))))
             ;;(incf i (+ 0 (nth 1 (find-next-char-from-index str #\Space i))))
         ))
      )
    )
    
  (reverse tokens))
)


(defun lil-tokenize (str)
  (let ((lines (utl-split-by-lines str)))
    (let ((program '()))
      (dotimes (i (length lines))
	(push (list (lil-tokenize-line (nth i lines)) i) program)
    )
      (reverse program))
    )
  )
