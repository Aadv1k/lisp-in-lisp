(load "utils.lisp")
(load "exceptions.lisp")

(defconstant token-lp 'LPAREN)
(defconstant token-rp 'RAPREN)
(defconstant token-num 'NUMBER)
(defconstant token-symbol 'SYMBOL)

(defun lil-tokenize-line (str)
  (let ((tokens (list)))
  (dotimes (i (length str))
    (cond 
      ((string= (char str i) "(") (push (list 'token-lp (char str i) i) tokens))
      ((string= (char str i) "+") (push (list 'token-symbol (char str i) i) tokens))
      ((string= (char str i) "-") (push (list 'token-symbol (char str i) i) tokens))
      ((string= (char str i) "/") (push (list 'token-symbol (char str i) i) tokens))
      ((string= (char str i) "*") (push (list 'token-symbol (char str i) i) tokens))
      ((string= (char str i) ")") (push (list 'token-rp (char str i) i) tokens))
      ((digit-char-p (char str i))
       (push (list 'token-num (char str i) i) tokens))

      (t
       (progn

	 (when (not (char= (char str i) #\space))
	    (lil-syntax-error (format nil "unknown symbol ~a" (char str i)))
	)
    ))
     )
    )
    (reverse tokens)
  )
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
