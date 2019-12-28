(define (domain planner)
  (:requirements :adl :fluents)

  (:types book month)

  (:functions
    (bookPages ?x - book)
    (monthPages ?x - month)
  )

  (:predicates

    (BOOK ?x)
    (MONTH ?X)
    (bookAssigned ?x)
    ;;(booksAreParallel ?x ?y)
    ;;(bookIsPredecessor ?x ?y)
	)


	(:action assignBook

	)
)
