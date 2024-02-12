(define (print-line str-ls)
    (let loop((out str-ls))
        (if (not (null? str-ls))
            (begin
                (display (car str-ls))
                (newline)
                (loop (cdr str-ls))))))
