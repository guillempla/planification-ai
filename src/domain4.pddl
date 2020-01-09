(define (domain planner)
  (:requirements :adl :fluents :equality :typing)

  (:types book month)

  (:predicates
    (bookRead           ?b            - book)
    (bookCandidate      ?b            - book)
    (bookIsPredecessor  ?b1 ?b2       - book)
    (bookAssigned       ?b            - book)
    (monthCompleted     ?m            - month)
    (bookAssignedMonth  ?b - book ?m  - month)
	)

  (:functions
    (bookPages          ?b            - book)
    (monthPages         ?m            - month)
  )

	(:action assignBook
    :parameters (?b - book ?m - month)
    :precondition (and  (not (monthCompleted ?m))
                        (not (bookAssigned ?b))
                        (not (bookRead ?b))
                        (<=  (+ (monthPages ?m) (bookPages ?b)) 800)
                        (not (exists (?aux - book) (and (bookIsPredecessor ?aux ?b) (not (bookRead ?aux)) (not (bookAssigned ?aux)))))
                  )

    :effect (and (bookAssigned ?b) (bookAssignedMonth ?b ?m)
            (when (exists (?aux - book) (bookIsPredecessor ?b ?aux)) (monthCompleted ?m))
            (increase (monthPages ?m) (bookPages ?b))
	           )
   )
)
