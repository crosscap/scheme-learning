; 1
(define (my-length ls)
        (if (null? ls)
             0
            (+ 1 (my-length (cdr ls)))))

; 2
(define (sum-list ls)
        (if (null? ls)
             0
            (+ (car ls) (sum-list (cdr ls)))))

; 3
; mine
(define (delete-x ls x)
        (if (not (null? ls))
            (if ((= (car ls) x))
                (cdr ls)
                ((let ((next (cdr ls)))
                      (if (not (null? next))
                          (if (= (car next) x)
                              (cons (car ls) (cdr next))
                              (delete-x next x))))))))

; answer
(define (remove x ls)
        (if (null? ls)
             '()
            (let ((h (car ls)))
                 ((if (eqv? x h)
                      (lambda (y) y)
                      (lambda (y) (cons h y)))
                  (remove x (cdr ls))))))

; 4
(define (find-x ls x)
        (if ((null? ls))
             #f
            (if ((= (car ls) x))
                 0
                ((+ 1 (find-x (cdr ls) x))))))
