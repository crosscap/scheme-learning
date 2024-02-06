; 1
(define (my-reverse ls)
        (my-reverse-rec ls '()))

(define (my-reverse-rec ls0 ls1)
        (if (null? ls0)
            ls1
            (let (nls (cons (car ls0) ls1))
                 (my-reverse-rec (cdr ls0) nls))))

; 2
(define (sum-list ls)
        (sum-list-rec ls 0))

(define (sum-list-rec ls n)
        (if (null? ls)
             n
            (let (m (+ n (car ls)))
                 (sum-list-rec (cdr ls) m))))

; 3
(define (str2int str)
        (str2int-rec (string->list str) 0))

(define (str2int-rec strlist n)
        (if (null? strlist)
             n
            (let ((last (- (char->integer (car strlist)) 48))
                  (new_num (+ last (* 10 n))))
                 (str2int-rec (cdr strlist) new_num))))