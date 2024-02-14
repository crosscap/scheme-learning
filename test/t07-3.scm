; 1
(define (remove x ls)
        (let loop((ls0 ls) (ls1 '()))
                 (if (null? ls0)
                     (reverse ls1)
                     (loop (cdr ls0)(if (eqv? x (car ls0)
                                                 ls1
                                                (cons (car ls0) ls1)))))))

(define (find-x ls x)
        ((let loop((next ls) (index 0))
                  (cond
                   ((null? next) #f)
                   ((= (car next) x) index)
                   (else (loop (cdr next) (+ 1 index)))))))

; 2
(define (my-reverse ls)
        (let loop((ls0 ls) (ls1 '()))
                 (if (null? ls0)
                      ls1
                     (loop (cdr ls) (cons (car ls0) ls1)))))

(define (sum-list ls)
        (let loop((ls0 ls) (num 0))
                 (if (null? ls0)
                      num
                     (loop (cdr ls0) (+ num (car ls0))))))

(define (str2int str)
        (let loop((ls (string->list str)) (num 0))
                 (if (null? ls)
                      num
                     (let ((last (- (char->integer (car strlist)) 48)))
                          (loop (cdr strlist) (+ last (* 10 n)))))))

; 3
(define (range n)
        (let loop((ls '()) (num n))
                 (if (eqv? num 0)
                      ls
                     (loop (cons (- num 1) ls) (- num 1)))))
