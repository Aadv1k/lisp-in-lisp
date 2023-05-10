# Lisp^2 

This is an experimental implementation of [common lisp](https://common-lisp.net/) in common lisp, via [Steel Bank Common Lisp](http://www.sbcl.org/)

### Build

This project is built using common lisp via the [Steel Bank Common Lisp](https://www.sbcl.org/) compiler, so I would direct you to their [install page](https://www.sbcl.org/platform-table.html)

Testing can be done via [pest](./lib/pest.lisp), just run the following  in terminal

```console
$ sbcl --script ./tests/*.lisp
```

### Supported Syntax

```console
$ sbcl --script ./main.lisp
================DEMO#1=================
input: (+ 2 2)
expected: 4
output: (4)
================DEMO#2=================
input: (* 3 4)
expected: 12
output: (12)
================DEMO#3=================
input: (- 5 6)
expected: -1
output: (-1)
================DEMO#4=================
input: (/ 7 8)
expected: 7/8
output: (7/8)
================DEMO#5=================
input: (- (- 11 10) (* 9 10))
expected: -89
output: (-89)
========================================
```
