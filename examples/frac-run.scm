(compile-file "frac.scm")
(load "frac")

;; C-Curve
(fractal c-curve 14 '((0 . 0) (2 . 3)) "c14.dat")
;Value: done

;; Dragon-Curve
(fractal dragon-curve 14 '((0 . 0) (1 . 0)) "d14.dat")
;Value: done

;; Koch-Curve
(fractal koch 5 '((0 . 0) (1 . 0)) "k5.dat")
;Value: done
