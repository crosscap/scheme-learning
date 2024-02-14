(define (fun ls)
        (sqrt (apply + (map (lambda (x) (* x x)) ls))))
