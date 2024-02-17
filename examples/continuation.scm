; 1
(define (return x)
    x)

(define (k+ a b k)
    (k (+ a b)))

(define (k* a b k)
    (k (* a b)))

; 2
;;; normal factorial
(define (fact n)
    (if (= n 1)
         1
        (* n (fact (- n 1)))))

;;; CPS factorial
(define (kfact n k)
    (if (= n 1)
        (k 1)
        (kfact (- n 1) (lambda (x) (k (* n x))))))

; 3
;;; normal
(define (product ls)
    (let loop ((ls ls) (acc 1))
        (cond
         ((null? ls) acc)
         ((zero? (car ls)) 0)
         (else (loop (cdr ls) (* (car ls) acc))))))

;;; CPS
(define (kproduct ls k)
    (let ((break k))
        (let loop ((ls ls) (k k))
            (cond
             ((null? ls) (k 1))
             ((zero? (car ls)) (break 0))
             (else (loop (cdr ls) (lambda (x) (k (* (car ls) x)))))))))

; 4
; Exception handling
(define (non-number-value-error x)
    (display "Value error: ")
    (display  x)
    (display " is not number.")
    (newline)
    'error)

(define (kproduct ls k k-value-error)
    (let ((break k))
        (let loop ((ls ls) (k k))
            (cond
             ((null? ls) (k 1))
             ((not (number? (car ls))) (k-value-error (car ls)))
             ((zero? (car ls)) (break 0))
             (else (loop (cdr ls) (lambda (x) (k (* (car ls) x)))))))))

(define call/cc call-with-current-continuation)

; 5
(define (find-leaf obj tree)
    (call/cc
        (lambda (cc)
            (letrec ((iter
                    (lambda (tree)
                        (cond
                         ((null?  tree) #f)
                         ((pair? tree)
                            (iter (car tree))
                            (iter (cdr tree)))
                         (else
                            (if (eqv? obj tree)
                                (cc obj)))))))
                (iter tree)))))
