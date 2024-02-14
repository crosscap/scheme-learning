(define (make-bank-account balance)
    (lambda (n)
        (if (negative? (+ n balance))
            (display "don't have enough money!")
            (begin
                (set! balance (+ balance n))
                balance))))

(define gates-bank-account (make-bank-account 10))
