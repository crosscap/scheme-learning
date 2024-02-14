; 1
(define (abs x)
        (if (> x 0)
            x
            (- 0 x)))

; 2
(define (reciprocal x)
        (if (= x 0)
            #f
            (/ 1 x)))

; 3
(define (int2char i)
        (if (<= 33 i 126)
            (integer->char i)
            #f))
