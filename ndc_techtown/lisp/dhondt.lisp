(defstruct party
  name
  votes
  seats)

(defstruct quotient
  party-index
  value)

(defun generate-parties (num-parties)
  (let ((parties '()))
    (dotimes (i num-parties)
      (let* ((party-name (string (code-char (+ 65 i)))) ; ASCII 65 corresponds to 'A'
             (votes (* (1+ i) 1000))) ; (1+ i) to start from 1, not 0
        (push (make-party :name party-name :votes votes :seats 0) parties)))
    (reverse parties))) ; Reverse to maintain the original order since 'push' adds to the front

(defun d-hondt (parties total-seats)
  (dolist (party parties)
    (setf (party-seats party) 0))
  
  (let ((quotients '()))
    (dotimes (i (length parties))
      (dotimes (j total-seats)
        (push (make-quotient :party-index i :value (/ (party-votes (nth i parties)) (+ j 1))) quotients)))
    (setf quotients (sort quotients #'> :key 'quotient-value))
    
    (dotimes (i total-seats)
      (let ((party-index (quotient-party-index (nth i quotients))))
        (incf (party-seats (nth party-index parties)))))
    parties))

(let* ((num-parties 10)
       (parties (generate-parties num-parties))
       (total-seats 50000)
       (result (d-hondt parties total-seats)))
  (print result))
