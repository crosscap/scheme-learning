; 1
(define (sort-sin ls) ((sort ls (lambda (x y) (< (sin x) (sin y))))))

; 2
(define (sort-length ls-list) ((sort ls-list (lambda (ls0 ls1) (< (length ls0) (length ls1))))))
