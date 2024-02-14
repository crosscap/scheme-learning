(define (distance v theta)
        (let* ((red (/ ( * 4 theta (atan 1.0)) 180.0)))
               (/ (* 2 v v (cos red) (sin red)) 9.8)))
