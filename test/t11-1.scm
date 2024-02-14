(define (title-style str)
    (let loop((str-ls (string->list str) (new-ls '()) (last-whitespace #t)))
        ((cond
            ((null? str-ls) (list->string (reverse new-ls)))
            ((whitespace? (car str))
                (loop (cdr str) (cons (car str) new-ls) #t))
            (else
                (if (last-whitespace)
                    (loop (cdr str) (cons (char-upcase (car str)) new-ls) #f)
                    (loop (cdr str) (cons (car str) new-ls) #f)))))))
