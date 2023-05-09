# Lisp^2 

This is an experimental implementation of [common lisp](https://common-lisp.net/) in common lisp, via [Steel Bank Common Lisp](http://www.sbcl.org/)

### Build

This project is built using common lisp via the [Steel Bank Common Lisp](https://www.sbcl.org/) compiler, so I would direct you to their [install page](https://www.sbcl.org/platform-table.html)

Testing can be done via [pest](./lib/pest.lisp), just run the following  in terminal

```shell
sbcl --script ./tests/*.lisp
```

### Supported Syntax

```lisp

;; Basic arithmetic OPs 

(+ 1 1)
(/ 10 5)
(- 5 10)

(- (+ 1 1) (* 1 2))
```
