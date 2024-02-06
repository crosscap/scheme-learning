; 1
(define (my-reverse ls)
        (do ((ls0 ls (cdr ls0)) (ls1 '() (cons (car ls0) ls1)))
            ((null? ls0) ls1)))

; 2
(define (sum-list ls)
        (do ((ls0 ls (cdr ls0)) (num 0 (+ num (car ls0))))
            ((null? ls0) num)))

; 3
(define (str2int str)
        (do ((ls (string->list str) (cdr strlist))
             (num 0 (+ (- (char->integer (car strlist)) 48) (* 10 n))))
            ((null? ls) num)))
