; 1
(define (filter-odd ls)
        (keep-matching-items ls (lambda (x) (eqv? 0 (modulo x 2)))))

; 2
(define (delete-nums ls)
        (delete-matching-items ls (lambda (x) (<= 10 x 100))))
