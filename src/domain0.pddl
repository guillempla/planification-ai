(define (domain planner)
  (:requirements :adl :fluents :equality :typing)

  (:types book month)

  (:predicates
    (bookRead ?b)
    (bookCandidate ?b)
    (bookIsPredecessor ?b1 ?b2)
    (bookAssigned ?m)
    (bookAssignedInMonth ?b ?m)
	)

	(:action assignBook
    :parameters (?b ?m)
    :precondition (and (not (bookAssigned ?b)) (not (bookRead ?b))(not (exists (?aux - book) (and (bookIsPredecessor ?aux ?b) (not (bookRead ?aux)) (not (bookAssigned ?aux))))))
    :effect (and (bookAssigned ?b) (bookAssignedInMonth ?b ?m))
	)
)
