(define (domain planner)
  (:requirements :adl :fluents :equality :typing)

  (:types book month)

  (:functions
    (bookPages ?x - book)
    (monthPages ?x - month)
  )

  (:predicates
    (bookRead ?x - book)
    (booksAreParallel ?x ?y - book)
    (bookIsPredecessor ?x ?y - book)
    (bookAssigned ?x - book)
    (bookAssignedInMonth ?x - book ?y - month)
	)

	(:action assignBook
    :parameters (?x - book ?y - month)
    :precondition (and (not (bookAssigned ?x)) (not (bookRead ?x)))
    :effect (and (bookAssigned ?x) (bookAssignedInMonth ?x ?y) (increase (monthPages ?y) (bookPages ?x)))
	)
)
