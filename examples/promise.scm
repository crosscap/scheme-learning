; 1
;;;;; basic functions and a macro

;;; car for lazy evaluation
(define lazy-car car)

;;; cdr for lazy evaluation
(define (lazy-cdr ls)
  (force (cdr ls)))

;;; lazy cons
(define-syntax lazy-cons
   (syntax-rules ()
      ((_ a b) (cons a (delay b)))))

;;; lazy map
(define (lazy-map fn . lss)
  (if (memq '() lss)
      '()
    (lazy-cons (apply fn (map lazy-car lss))
               (apply lazy-map fn (map lazy-cdr lss)))))

;;; lazy filter
(define (lazy-filter pred ls)
  (if (null? ls)
      '()
    (let ((obj (lazy-car ls)))
      (if (pred obj)
          (lazy-cons obj  (lazy-filter pred (lazy-cdr ls)))
        (lazy-filter pred (lazy-cdr ls))))))

;;; returns n-th item of the lazy list
(define (lazy-ref ls n)
  (if (= n 0)
      (lazy-car ls)
    (lazy-ref (lazy-cdr ls) (- n 1))))

;;; returns first n items of the ls
(define (head ls n)
  (if (= n 0)
      '()
     (cons (lazy-car ls) (head (lazy-cdr ls) (- n 1)))))

; 2
;;;;  sequences

;;; infinite sequences represented by a_(n+1) = f(a_n)
(define (inf-seq a0 f)
  (lazy-cons a0 (inf-seq (f a0) f)))

;;; arithmetic sequence
(define (ari a0 d)
  (inf-seq a0 (lambda (x) (+ x d))))

;;; geometric sequence
(define (geo a0 r)
  (inf-seq a0 (lambda (x) (* x r))))

; 4
;;; Newton-Raphson method
(define (newton-raphson n)
  (inf-seq 1 (lambda (x) (/ (+ x (/ n x)) 2))))

;;; returning a reasonable answer.
;;; If the ratio of successive terms is in (1 - eps) and (1 + eps),
;;; or the following term is zero,
;;; the function returns it.
(define (lazylist->answer ls eps)
  (let ((e1 (- 1.0 eps))
        (e2 (+ 1.0 eps)))
    (let loop ((val (lazy-car ls))
               (ls1 (lazy-cdr ls)))
      (let ((val2 (lazy-car ls1)))
        (if  (or (zero? val2) (< e1 (/ val val2) e2))
            (exact->inexact val2)
          (loop val2 (lazy-cdr ls1)))))))

;;;
(define (my-sqrt n eps)
  (lazylist->answer (newton-raphson n) eps))

; 5
;;; differentiation

;;; primitive function for differentiation
(define (easydiff f x h)
  (/ (- (f (+ x h)) (f x)) h))

;;; create a lazy list of approximation for differentiation
(define (lazylist-diff h0 f x)
  (lazy-map (lambda (h) (easydiff f x h)) (geo h0 0.5)))

;;; eliminate error from the approximation
(define (elimerror n ls)
  (let ((a (lazy-car ls))
        (b (lazy-second ls))
        (c (fix:lsh 1 n)))   ; (expt 2 n)
    (lazy-cons
     (/ (- (* b c) a) (- c 1))
     (elimerror n (lazy-cdr ls)))))

;;; estimate `n' in elimerror
(define (order ls)
  (let* ((a (lazy-car ls))
         (b (lazy-second ls))
         (c (lazy-ref ls 2))
         (d (- (/ (- a c) (- b c)) 1.0)))
    (cond
     ((< d 2) 1)
     ((<= 2 d 16) (inexact->exact (round (log2 d))))
     (else 4))))

;;;
(define (log2 x)
  (/ (log x) (log 2)))

;;; improve convergence of the lazy list of the approximation
(define (improve ls)
  (elimerror (order ls) ls))

;;; return the second value of the lazy list
(define (lazy-second ls)
  (lazy-car (lazy-cdr ls)))

;;; further improve the convergence of the list
(define (super ls)
  (lazy-map lazy-second (inf-seq ls improve)))


;;; calculate the differentiation of function `f' at x within error eps
;;; h0 is initial window width
(define (diff f x h0 eps)
  (lazylist->answer (super (lazylist-diff h0 f x)) eps))

; 6
;;; integration

;;; primitive integration
(define (easyintegrate f a b)
  (* (/ (+ (f a) (f b)) 2) (- b a)))

;;; create the lazy list of approximation for integration
(define (lazylist-integrate f a b)
  (let ((mid (/ (+ a b) 2)))
    (lazy-cons (easyintegrate f a b)
               (lazy-map + (lazylist-integrate f a mid)
                           (lazylist-integrate f mid b)))))

;;; integrate function `f' in a range of `a' and `b' within error `eps'
(define (integrate f a b eps)
  (lazylist->answer (super (lazylist-integrate f a b)) eps))