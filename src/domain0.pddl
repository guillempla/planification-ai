(define (domain planner)
  (:requirements :adl :fluents :equality :typing)

  (:types book month)

  (:functions
    (bookPages ?b - book)
    (bookRead ?b - book)
    (monthPages ?m - month)
  )

  (:predicates

    (bookAssigned ?m)
    (bookAssignedInMonth ?b ?m)
	)

	(:action assignBook
    :parameters (?b - book ?m - month)
    :precondition (and (not (bookAssigned ?b)) (not (bookRead ?b)) (<= (+ (bookPages ?b) (monthPages ?m)) 800))
    :precondition (and (not (bookAssigned ?x)) (not (bookRead ?x)))
    :effect (and (bookAssigned ?b) (bookAssignedInMonth ?b ?m) (increase (monthPages ?m) (bookPages ?b)))
	)
)
