(define (print-line str)
    (let loop((out (string->list str)))
        (if (not (null? out))
            (begin
                (display (car out))
                (newline)
                (loop (cdr out))))))
