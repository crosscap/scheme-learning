; 8
;;; simple structure definition

;;; lists of symbols -> string
(define (append-symbol . ls)
  (let loop ((ls (cdr ls)) (str (symbol->string (car ls))))
    (if (null? ls)
    str
    (loop (cdr ls) (string-append str "-" (symbol->string (car ls)))))))

;;; obj -> ls -> integer
;;; returns position of obj in ls
(define (position obj ls)
  (letrec ((iter (lambda (i ls)
           (cond
            ((null? ls) #f)
            ((eq? obj (car ls)) i)
            (else (iter (1+ i) (cdr ls)))))))
    (iter 0 ls)))


;;; list -> integer -> list
;;; enumerate list items
(define (slot-enumerate ls i)
  (if (null? ls)
      '()
    (cons `((,(car ls)) ,i) (slot-enumerate (cdr ls) (1+ i)))))

;;; define simple structure
(define-syntax defstruct
  (sc-macro-transformer
   (lambda (exp env)
     (let ((struct (second exp))
           (slots  (map (lambda (x) (if (pair? x) (car x) x)) (cddr exp)))
       (veclen (- (length exp) 1)))

       `(begin
      (define ,(string->symbol (append-symbol 'make struct))   ; making instance
        (lambda ls
              (let ((vec (vector ',struct ,@(map (lambda (x) (if (pair? x) (second x) #f)) (cddr exp)))))
        (let loop ((ls ls))
          (if (null? ls)
              vec
              (begin
                       (vector-set! vec (case (first ls) ,@(slot-enumerate slots 1)) (second ls))
            (loop (cddr ls))))))))

      (define ,(string->symbol (string-append (symbol->string struct) "?"))  ; predicate
        (lambda (obj)
          (and
           (vector? obj)
           (eq? (vector-ref obj 0) ',struct))))

      ,@(map
         (lambda (slot)
           (let ((p (1+ (position slot slots))))
         `(begin
            (define ,(string->symbol (append-symbol struct slot))    ; accessors
              (lambda (vec)
            (vector-ref vec ,p)))

            (define-syntax ,(string->symbol                           ; modifier
                     (string-append
                      (append-symbol 'set struct slot) "!"))
              (syntax-rules ()
            ((_ s v) (vector-set! s ,p v)))))))
         slots)

      (define ,(string->symbol (append-symbol 'copy struct))      ; copier
        (lambda (vec)
          (let ((vec1 (make-vector ,veclen)))
        (let loop ((i 0))
          (if (= i ,veclen)
              vec1
              (begin
            (vector-set! vec1 i (vector-ref vec i))
            (loop (1+ i)))))))))))))