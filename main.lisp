(defvar token-lp 'LPAREN)
(defvar token-rp 'RAPREN)
(defvar token-num 'NUMBER)
(defvar token-symbol 'SYMBOL)

(defun split-by-lines (str)
  (let ((lines ()))
    (let ((col 0))

      (dotimes (i (length str))
	(if (char= (char str i) #\Newline)
	    (progn
	      (push (subseq str col (- i 1)) lines)
	      (setq col (+ i 1))
	      )
	    )
	)
      (when (EQ lines nil) (push str lines))
      )
    lines)
  )


(defun tokenize-line (str)
  (let ((tokens (list)))
  (dotimes (i (length str))
    (cond 
      ((string= (char str i) "(") (push (list 'token-lp (char str i)) tokens))
      ((string= (char str i) "+") (push (list 'token-symbol (char str i)) tokens))
      ((string= (char str i) "-") (push (list 'token-symbol (char str i)) tokens))
      ((string= (char str i) "/") (push (list 'token-symbol (char str i)) tokens))
      ((string= (char str i) "*") (push (list 'token-symbol (char str i)) tokens))
      ((string= (char str i) ")") (push (list 'token-rp (char str i)) tokens))
      ((digit-char-p (char str i)) (push (list 'token-num (char str i)) tokens))
     )
    )
    tokens
  )
)


