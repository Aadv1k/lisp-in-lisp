(load "./lib/utils.lisp")
(load "./lib/pest.lisp")
(load "./tokenizer.lisp")

(defconstant token-lp 'LPAREN)
(defconstant token-rp 'RAPREN)
(defconstant token-num 'NUMBER)
(defconstant token-symbol 'SYMBOL)


(let ((tokens))
  (setq tokens (lil-tokenize-line "(+ 1 1 )"))
  (print "Check if the tokenizer produces correct output")
  (pest-assert-a-equal-to-b (nth 0 (nth 0 tokens)) 'token-lp)
  (pest-assert-a-equal-to-b (nth 0 (nth 1 tokens)) 'token-symbol)
  (pest-assert-a-equal-to-b (nth 0 (nth 2 tokens)) 'token-num)
  (pest-assert-a-equal-to-b (nth 0 (nth 3 tokens)) 'token-num)
  (pest-assert-a-equal-to-b (nth 0 (nth 4 tokens)) 'token-rp)
)


(let ((tokens))
  (handler-case 
    (lil-tokenize-line "this will not work")
   (error () (progn

  (print "Check if the tokenizer throws error on bad input")
  (terpri)
              )))
)

