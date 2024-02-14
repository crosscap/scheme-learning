(define-structure (book keyword-constructor copier)
  title authors publisher year isbn)

(define bazaar
  (make-book
   'title "The Cathedral and the Bazaar"
   'authors "Eric S. Raymond"
   'publisher "O'Reilly"
   'year 1999
   'isbn 0596001088))
