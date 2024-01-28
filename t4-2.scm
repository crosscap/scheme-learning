(define pi (* 4 (atan 1.0)))

(define (ang2red theta) (* theta (/ pi 180.0)))

(define (vt2s x t) (* x t))

(define (time Vy) (* 2 (/ Vy 9.8)))

(define (distance v theta)
        (vt2s (* v (cos (ang2red theta)))
              (time (* v (sin (ang2red theta))))))
