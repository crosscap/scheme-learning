; 1
(define (my-reverse ls)
        (letrec ((iter (lambda (ls0 ls1)
                               (if (null? ls0)
                                     ls1
                                    ((iter (cdr ls0) (cons (car ls0) ls1)))))))
                (iter ls '())))

; 2
(define (sum-list ls)
        (letrec ((iter (lambda (ls0 num)
                               (if (null? ls0)
                                     num
                                   (iter (cdr ls0) (+ num (car ls0)))))))
                (iter ls 0)))

; 3
(define (str2int str)
        (letrec ((iter (lambda (ls num)
                               (if (null? ls)
                                    num
                                   (iter (cdr strlist)
                                         (+ (- (char->integer (car strlist)) 48)
                                            (* 10 n)))))))
                (iter (string->list str) 0)))
