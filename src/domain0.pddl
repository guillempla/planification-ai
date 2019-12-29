(define (domain planner)
  (:requirements :adl :fluents :equality :typing)

  (:types book month)

  (:predicates
    (bookRead ?b)
    (bookCandidate ?b)
    (bookAssigned ?m)
    (bookAssignedInMonth ?b ?m)
	)

	(:action assignBook
    :parameters (?b ?m)
    :precondition (and (not (bookAssigned ?b)) (not (bookRead ?b)) (bookCandidate ?b))
    :effect (and (bookAssigned ?b) (bookAssignedInMonth ?b ?m))
	)
)
