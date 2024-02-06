; 1
(define (my-keep-matching-items ls proc)
        (letrec (iter (lambda (ls0 ls1)
                              (if (null? ls0)
                                  (reverse ls1)
                                  (iter (cdr ls0) (if (proc (car ls0))
                                                      (cons (car ls0) ls1)
                                                       ls1)))))
                (iter ls '())))

;; answer
(define (my-keep-matching-items ls fn)
    (cond
     ((null? ls) '())
     ((fn (car ls))
        (cons (car ls) (my-keep-matching-items (cdr ls) fn)))
     (else
        (my-keep-matching-items  (cdr ls) fn))))

; 2 [x]
(define (my-map fun . lss)
    (letrec ((iter (lambda (fun lss)
                             (if (null? lss)
                             '()
                             (cons (fun (car lss))
                                 (iter fun (cdr lss))))))
             (map-rec (lambda (fun lss)
                            (if (memq '() lss)
                            '()
                            (cons (apply fun (iter car lss))
                                (map-rec fun (iter cdr lss)))))))
        (map-rec fun lss)))
