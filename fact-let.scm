(define (fact-let n)
        (let loop((n1 n) (p n))           ; 1
                 (if (= n1 1)
                      p
                     (let ((m (- n1 1)))
                          (loop m (* p m))))))      ; 2
