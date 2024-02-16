; 1
; 一个将变量赋值为'()的宏
(define-syntax nil!
    (syntax-rules ()
        ((_ x)
         (set! x '()))))

; 2
; 当谓词求值为真时，求值相应语句
(define-syntax when
    (syntax-rules ()
        ((_ pred b1 ...)
         (if pred (begin b1 ...)))))

; 3
; 谓词 while 和 for
(define-syntax while
    (syntax-rules ()
        ((_ pred b1 ...)
         (let loop () (when pred b1 ... (loop))))))

(define-syntax for
    (syntax-rules ()
        ((_ (i from to) b1 ...)
         (let loop((i from))
            (when (< i to)
                b1 ...
                (loop (1+ i)))))))

; 4
(define-syntax incf
  (syntax-rules ()
    ((_ x) (begin (set! x (+ x 1)) x))
    ((_ x i) (begin (set! x (+ x i)) x))))

; 5
(define-syntax my-and
    (syntax-rules ()
        ((_) #t)
        ((_ e) e)
        ((_ e1 e2 ...)
         (if e1
            (my-and e2 ...)
             #f))))

(define-syntax my-or
    (syntax-rules ()
        ((_) #f)
        ((_ e) e)
        ((_ e1 e2 ...)
         (let ((t e1))
           (if t t (my-or e2 ...))))))

; 6
(define-syntax my-cond
    (syntax-rules (else)
        ((_ (else e1 ...))
         (begin e1 ...))
        ((_ (e1 e2 ...))
         (when e1 e2 ...))
        ((_ (e1 e2 ...) c1 ...)
         (if e1
         (begin e2 ...)
         (my-cond c1 ...)))))

; 7
(define-syntax show-vars
    (sc-macro-transformer
        (lambda (exp env)
            (let ((vars (cdr exp)))
               `(begin
                  (display
                    (list
                    ,@(map (lambda (v)
                                (let ((w (make-syntactic-closure env '() v)))
                                 `(list ',w ,w)))
                          vars)))
      (newline))))))

(define-syntax random-choice
    (sc-macro-transformer
        (lambda (exp env)
            (let ((i -1))
                `(case (random ,(length (cdr exp)))
                    ,@(map (lambda (x)
                                `((,(incf i)) ,(make-syntactic-closure env '() x)))
                                (cdr exp)))))))

(define-syntax aif
    (sc-macro-transformer
        (lambda (exp env)
            (let ((test (make-syntactic-closure env '(it) (second exp)))
                (cthen (make-syntactic-closure env '(it) (third exp)))
                (celse (if (pair? (cdddr exp))
                    (make-syntactic-closure env '(it) (fourth exp))
                     #f)))
            `(let ((it ,test))
            (if it ,cthen ,celse))))))
