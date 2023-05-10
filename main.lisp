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

(defun string-get-last-char (str)
  (list (char str (- (length str) 1)) (- (length str) 1))
)


(defun find-next-space-or-end (start str)
  (let ((index (loop for i from start below (length str)
                    when (or (char= (char str i) #\Space)
                             (char= (char str i) #\Newline)
                             (char= (char str i) #\Tab)
                             (char= (char str i) #\))

                             )
                    return i
                    finally (return (length str)))))
    (list index (- index start))))



(defun tokenize (str)
  (let ((expr 
          (if (char= (char str 0) #\()
            (subseq str 1 (nth 1 (string-get-last-char str)))
            nil
            )) 
        (tokens '()))

    (dotimes (i (length expr))
      (cond 
        ((char= (char expr i) #\+) 
         (push (list token-symbol (char expr i)) tokens)
         )
        ((char= (char expr i) #\/) 
         (push (list token-symbol (char expr i)) tokens)
         )

        ((char= (char expr i) #\%)
         (push (list token-symbol (char expr i)) tokens)
         )

        ((char= (char expr i) #\-) 
         (push (list token-symbol (char expr i)) tokens)
         )

        ((char= (char expr i) #\() 
         (push (list token-lp (char expr i)) tokens)
         )

        (
         (and (digit-char-p (char expr i)) t)
         (progn
           (let ((num (subseq expr i (- (nth 0 (find-next-space-or-end i expr)) 0))))
             (push (list token-number (parse-integer num)) tokens)
             (setq i (+ i (nth 1 (find-next-space-or-end i expr))))
             )
           )
         )
        (t ()))
      )
    (reverse tokens)))



;;((SYMBOL #\+) (NUMBER 34) (LPAREN #\() (SYMBOL #\-) (NUMBER 36) (NUMBER 1))



(defun lil-eval-stack (stack)
  (let ((result 0) (local-stack '()))
    (dotimes (i (length stack))
      (cond 
        ((numberp (nth i stack)) (push (nth i stack) local-stack))
        ((char= (nth i stack) #\+) 
         (let ((computed (reduce #'+ (mapcar #'identity local-stack))))
          (setq local-stack '())
          (push computed local-stack)
        ))

        ((char= (nth i stack) #\-) 
         (let ((computed (reduce #'- (mapcar #'identity local-stack))))
          (setq local-stack '())
          (push computed local-stack)
        ))

        ((char= (nth i stack) #\/) 
         (let ((computed (reduce #'/ (mapcar #'identity local-stack))))
          (setq local-stack '())
          (push computed local-stack)
        ))


        ((char= (nth i stack) #\*) 
         (let ((computed (reduce #'* (mapcar #'identity local-stack))))
          (setq local-stack '())
          (push computed local-stack)
        ))
      ))
    local-stack))

(defun lil-parse (tokens) "Expects a list of tokens"
  (let ((stack '()) (token nil) (token-type nil) (token-value nil) (paren-open t))
    (dotimes (i (length tokens)) 
      (setq token (nth i tokens))
      (setq token-type (nth 0 token))
      (setq token-value (nth 1 token))

      (cond 
        ((and (eql token-type #\() (not paren-open)) 
         (setq paren-open t))
        ((and (eql token-type #\)) paren-open) 
         (setq paren-open nil))
        ((eql token-type 'SYMBOL) 
         (push token-value stack))
        ((eql token-type 'NUMBER) 
         (push token-value stack))
      )
    )
  (lil-eval-stack stack))
)

(print (lil-parse (tokenize "(+ 34 (- 36 1))")))
