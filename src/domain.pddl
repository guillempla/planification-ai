(define (domain planner)
  (:requirements :adl :fluents :equality)

  (:types book month)

  (:functions
    (bookPages ?x - book)
    (monthPages ?x - month)
  )

  (:predicates
    (bookRead ?x)
    (booksAreParallel ?x ?y)
    (bookIsPredecessor ?x ?y)
    (bookAssigned ?x)
    (bookAssignedInMonth ?x ?y)
	)

	(:action assignBook
    :parameters (?x - book ?y - month)
    :precondition (and (not (bookAssigned ?x)) (not (bookRead ?x)))
    :effect (and (bookAssigned ?x) (bookAssignedInMonth ?x ?y) (increase (monthPages ?y) (bookPages ?x)))
	)
)
