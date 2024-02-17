; 1
;;; abbreviation for call-with-current-continuation
(define call/cc call-with-current-continuation)

;;; This function is re-assigned in `choose` and `fail` itself.
(define fail #f)

;;; function for nondeterminism
(define (choose . ls)
  (if (null? ls)
    (fail)
    (let ((fail0 fail))
      (call/cc
        (lambda (cc)
          (set! fail (lambda ()
                       (set! fail fail0)
                       (cc (apply choose (cdr ls)))))
          (cc (car ls)))))))

;;; write following at the end of file
;;; initial value for fail
(call/cc
  (lambda (cc)
    (set! fail (lambda ()
                 (cc 'no-choice)))))

; 2
;;; nondeterminism macro operator
(define-syntax amb
  (syntax-rules ()
    ((_) (fail))
    ((_ a) a)
    ((_ a b ...)
     (let ((fail0 fail))
       (call/cc
    (lambda (cc)
      (set! fail
        (lambda ()
          (set! fail fail0)
          (cc (amb b ...))))
      (cc a)))))))

; 3
;;; returning all possibilities
(define-syntax set-of
  (syntax-rules ()
    ((_ s)
      (let ((acc '()))
        (amb (let ((v s))
               (set! acc (cons v acc))
               (fail))
             (reverse! acc))))))

;;; if not pred backtrack
(define (assert pred)
  (or pred (amb)))

;;; returns arbitrary number larger or equal to n
(define (an-integer-starting-from n)
  (amb n (an-integer-starting-from (1+ n))))

;;; returns arbitrary number between a and b
(define (number-between a b)
  (let loop ((i a))
    (if (> i b)
        (amb)
      (amb i (loop (1+ i))))))

; 4
(define (xor a b)
  (if a (not b) b))

(define (all-different? . ls)
  (let loop ((obj (car ls)) (ls (cdr ls)))
    (or (null? ls)
        (and (not (memv obj ls))
             (loop (car ls) (cdr ls))))))

;;; SICP Exercise 4.42
(define (girls-exam)
  (let ((kitty (number-between 1 5))
        (betty (number-between 1 5)))
    (assert (xor (= kitty 2) (= betty 3)))
    (let ((mary (number-between 1 5)))
      (assert (xor (= kitty 2) (= mary 4)))
      (assert (xor (= mary 4) (= betty 1)))
      (let ((ethel (number-between 1 5))
            (joan (number-between 1 5)))
        (assert (xor (= ethel 1) (= joan 2)))
        (assert (xor (= joan 3) (= ethel 5)))
        (assert (all-different? kitty betty ethel joan mary))
        (map list '(kitty betty ethel joan mary) (list kitty betty ethel joan mary))))))

;;; Bad answer for ex 4.42
(define (girls-exam-x)
  (let ((kitty (number-between 1 5))
        (betty (number-between 1 5))
        (mary (number-between 1 5))
        (ethel (number-between 1 5))
        (joan (number-between 1 5)))
    (assert (xor (= kitty 2) (= betty 3)))
    (assert (xor (= kitty 2) (= mary 4)))
    (assert (xor (= mary 4) (= betty 1)))
    (assert (xor (= ethel 1) (= joan 2)))
    (assert (xor (= joan 3) (= ethel 5)))
    (assert (all-different? kitty betty ethel joan mary))
    (map list '(kitty betty ethel joan mary) (list kitty betty ethel joan mary))))