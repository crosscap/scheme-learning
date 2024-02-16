; 1
(define (fact n)
    (if (= n 1)
         1
        (* n (fact (- n 1)))))

; 2 tail
(define (fact-tail n)
    (fact-rec n n))

(define (fact-rec n p)
    (if (= n 1)
         p
        (let ((m (- n 1)))
             (fact-rec m (* p m)))))

; 3 let
(define (fact-let n)
    (let loop((n1 n) (p n))           ; 1
        (if (= n1 1)
             p
            (let ((m (- n1 1)))
                 (loop m (* p m))))))      ; 2

; 4 letrec
(define (fact-letrec n)
    (letrec ((iter (lambda (n1 p)
                        (if (= n1 1)
                             p
                            (let ((m (- n1 1)))
                                (iter m (* p m)))))))     ; *
        (iter n n)))

; 5 do
(define (fact-do n)
    (do ((n1 n (- n1 1)) (p n (* p (- n1 1)))) ((= n1 1) p)))
