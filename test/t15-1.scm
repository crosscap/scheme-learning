(define-syntax when-not
    (syntax-rules ()
        ((_ pred b1 ...)
         (if (not pred)
            (begin b1 ...)))))
