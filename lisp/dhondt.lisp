(defun get-random-int (min max)
  (+ min (random (+ 1 (- max min)))))

(defun get-random-name (length)
  (let ((characters "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz")
        (name ""))
    (dotimes (i length)
      (setf name (concatenate 'string name 
                              (string (elt characters (random (length characters)))))))
    name))

(defstruct party
  name
  votes
  seats)

(defstruct quotient
  party-index
  value)

(defun generate-random-parties (num-parties max-votes)
  (let ((parties '()))
    (dotimes (i num-parties)
      (let* ((name-length (get-random-int 1 10))
             (party-name (get-random-name name-length))
             (votes (get-random-int 0 max-votes)))
        (push (make-party :name party-name :votes votes :seats 0) parties)))
    parties))

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

(let* ((num-parties 1000)
       (max-votes 1000)
       (parties (generate-random-parties num-parties max-votes))
       (total-seats 500)
       (result (d-hondt parties total-seats)))
  (print result))
