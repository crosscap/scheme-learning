; 1
(cons "hi" "everybody")

; 2
(cons 0 '())

; 3
(cons (cons 1 10) 100) ;w
(cons 1 (cons 10 100))

; 4
(cons 1 (cons 10 (cons 100 '())))

; 5
(cons #\I (cons "saw" (cons 3 (cons "girls" '()))))

; 6
; build (1 2 3 4) first
(cons 1 (cons 2 (cons 3 (cons 4 '()))))
; put it into whole list
(cons "Sum of" (cons (cons 1 (cons 2 (cons 3 (cons 4 '())))) (cons "is" (cons 10 '()))))
