(define (domain planner)
  (:requirements :adl :fluents :equality :typing)

  (:types book month)

  (:predicates
    (bookRead ?b)
    (bookCandidate ?b)
    (bookIsPredecessor ?b1 ?b2)
    (bookAssigned ?b)
    (monthCompleted ?m)
    (bookAssignedInMonth ?b ?m)
	)

	(:action assignBookPredecessor
    :parameters (?b ?m)
    :precondition (and (not (monthCompleted ?m)) (not (bookAssigned ?b)) (not (bookRead ?b))(not (exists (?aux - book) (and (bookIsPredecessor ?aux ?b) (not (bookRead ?aux)) (not (bookAssigned ?aux))))))
    :effect (and (bookAssigned ?b) (bookAssignedInMonth ?b ?m) (when (exists (?aux - book) (bookIsPredecessor ?b ?aux)) (monthCompleted ?m)))
	)
)
