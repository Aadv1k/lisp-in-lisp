(defun utl-split-by-lines (str)
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

(defun utl-string-get-last-char (str)
  (list (char str (- (length str) 1)) (- (length str) 1))
)


(defun utl-find-next-space-or-end (start str)
  (let ((index (loop for i from start below (length str)
                    when (or (char= (char str i) #\Space)
                             (char= (char str i) #\Newline)
                             (char= (char str i) #\Tab)
                             (char= (char str i) #\))

                             )
                    return i
                    finally (return (length str)))))
    (list index (- index start))))


(defun utl-split-string (string &optional (separator " "))
  (split-str-1 string separator))

(defun split-str-1 (string &optional (separator " ") (r nil))
  (let ((n (position separator string
		     :from-end t
		     :test #'(lambda (x y)
			       (find y x :test #'string=)))))
    (if n
	(split-str-1 (subseq string 0 n) separator (cons (subseq string (1+ n)) r))
      (cons string r))))

(defun utl-char-to-num (chr)
  (- (char-code chr) 48)
  )
