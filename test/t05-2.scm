; 1
(define (mulAllPositive a b c)
        (if (and (> a 0) (> b 0) (> c 0))
            (* a b c)))

; 2
(define (mulOneNegative a b c)
        (if (or (< a 0) (< b 0) (< c 0))
            (* a b c)))
