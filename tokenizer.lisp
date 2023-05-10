(load "./lib/utils.lisp")
(load "./lib/globals.lisp")
(load "exceptions.lisp")

(defun lil-tokenize (str)
  (let ((expr 
          (if (char= (char str 0) #\()
            (subseq str 1 (nth 1 (utl-string-get-last-char str)))
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

        ((char= (char expr i) #\*) 
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
           (let ((num (subseq expr i (- (nth 0 (utl-find-next-space-or-end i expr)) 0))))
             (push (list token-number (parse-integer num)) tokens)
             (setq i (+ i (nth 1 (utl-find-next-space-or-end i expr))))
             )
           )
         )
        (t ()))
      )
    (reverse tokens)))



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

        ((char= (nth i stack) #\-) 
         (let ((computed (reduce #'- (mapcar #'identity local-stack))))
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
