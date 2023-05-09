(defpackage pest
  (:use :common-lisp)
  (:export pest-assert-a-equal-b pest-assert-a-has-b)
)

(in-package :pest)

(defun assertion-error (msg)
  (error "pest assertion error: ~A" msg)
)

(defun pest-assert-a-equal-b (a b)
  "Assert a is equal to b"
  (cond
    ((and (typep a 'list) (typep b 'list))
     (when (not (eql (length a) (length b)))
       (assertion-error (format nil "~A is not equal to ~A" a b))))
    (t
     (when (not (eql a b))
       (assertion-error (format nil "~A is not equal to ~A" a b))))))

(defun pest-assert-a-has-b (a b)
  "Check if a is in list b"
  (unless (member a b)
    (assertion-error (format nil "~A was not found in ~A" a b))
    )
  )
