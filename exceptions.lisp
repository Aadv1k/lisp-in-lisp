(defun lil-not-implemented (msg)
    (error "not implemented: ~A" msg)
)

(defun lil-syntax-error (msg &optional (row nil row-supplied-p) (col nil col-supplied-p))
  (if (and row-supplied-p col-supplied-p)
      (error "syntax error: at line ~D, column ~D: ~A" row col msg)
      (error "syntax error: ~A" msg)))
