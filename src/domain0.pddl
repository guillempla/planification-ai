(define (domain planner)
  (:requirements :adl :fluents :equality :typing)

  (:types book month)

  (:functions
    (bookRead ?b - book)
    (bookCandidate ?b - book)
  )

  (:predicates
    (bookAssigned ?m)
    (bookAssignedInMonth ?b ?m)
	)

	(:action assignBook
    :parameters (?b - book ?m - month)
    :precondition (and (not (bookAssigned ?b)) (not (bookRead ?b)) (bookCandidate ?b))
    :effect (and (bookAssigned ?b) (bookAssignedInMonth ?b ?m))
	)
)
