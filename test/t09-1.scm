(define (get-lines p)
    (let loop((ls1 '()) (c (read-char p)))
            (if (equv? c #\Linefeed)
                (reverse (cons #\Linefeed ls1))
                (loop (cons s ls1) (read-char p))))

(define (read-lines file-name)
    (let ((p (open-input-file file-name)))
        (let loop((ls1 '()) (c (read-char p)))
            (if (eof-object? c)
                (begin (close-input-port p)
                    (reverse ls1)))
                (begin (get-lines p)
                    loop (cons s ls1) (read-char p)))))

; answer
(define (group-list ls sep)
    (letrec ((iter (lambda (ls0 ls1)
        (cond
            ((null? ls0) (list ls1))
            ((eqv? (car ls0) sep)
                (cons ls1 (iter (cdr ls0) '())))
            (else (iter (cdr ls0) (cons (car ls0) ls1)))))))
        (map reverse (iter ls '()))))


(define (read-lines file-name)
    (with-input-from-file file-name
        (lambda ()
            (let loop((ls1 '()) (c (read-char)))
                (if (eof-object? c)
                    (map list->string (group-list (reverse ls1) #\Linefeed))  ; *
                    (loop (cons c ls1) (read-char)))))))
