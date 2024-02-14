; 0. define the number of pi
(define pi (* 4 (atan 1.0)))

; 1. convert the unit of angles from degree to radian
(define (ang2red theta)
        (* theta (/ pi 180.0)))

; 2. calculates a distance of moving at a constant velocity (vx) in t seconds.
(define (vt2s x t)
        (* x t))

; 3. calculates a duration reach the ground
;    that is launched with vertical velocity of vy.
(define (time Vy)
        (* 2 (/ Vy 9.8)))

; 4. calculates a flying distance of a ball thrown
;    with an initial velocity v and an angle theta degree
(define (distance v theta)
        (vt2s (* v (cos (ang2red theta)))
              (time (* v (sin (ang2red theta))))))
