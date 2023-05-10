(load "./lib/globals.lisp")
(load "./lib/utils.lisp")
(load "./lib/pest.lisp")
(load "./tokenizer.lisp")

(let ((tokens))
  (setq tokens (lil-tokenize "(+ 1 1 )"))
  (format nil "Check if the tokenizer produces correct output ~%")
  (pest-assert-a-equal-to-b (nth 0 (nth 0 tokens)) token-symbol)
  (pest-assert-a-equal-to-b (nth 0 (nth 1 tokens)) token-number)
  (pest-assert-a-equal-to-b (nth 0 (nth 2 tokens)) token-number)
)

