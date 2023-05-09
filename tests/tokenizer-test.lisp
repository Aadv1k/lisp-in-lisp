(load "./utils.lisp")
(load "./pest.lisp")
(load "./tokenizer.lisp")

(defconstant token-lp 'LPAREN)
(defconstant token-rp 'RAPREN)
(defconstant token-num 'NUMBER)
(defconstant token-symbol 'SYMBOL)

(in-package :pest)

(print "check if line is tokenized correctly")
(let ((tokens))
    (setq tokens (lil-tokenize-line " ( + 1   1  ) "))
    (pest-assert-a-equal-to-b (nth 0 tokens (nth 0 tokens)) token-lp)
    (pest-assert-a-equal-to-b (nth 1 tokens (nth 1 tokens)) token-symbol)
    (pest-assert-a-equal-to-b (nth 2 tokens (nth 2 tokens)) token-symbol)
    (pest-assert-a-equal-to-b (nth 2 tokens (nth 2 tokens)) token-rp)
)
