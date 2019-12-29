(define (domain planner)
  (:requirements :adl :fluents :equality :typing)

  (:types book month)

  (:functions
    (bookRead ?b - book)
  )

  (:predicates
    (bookAssigned ?m)
    (bookAssignedInMonth ?b ?m)
	)

	(:action assignBook
    :parameters (?b - book ?m - month)
    :precondition (and (not (bookAssigned ?b)) (not (bookRead ?b)))
    :precondition (and (not (bookAssigned ?x)) (not (bookRead ?x)))
    :effect (and (bookAssigned ?b) (bookAssignedInMonth ?b ?m) (increase (monthPages ?m) (bookPages ?b)))
	)
)
