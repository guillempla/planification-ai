(define (domain planner)
  (:requirements :adl :fluents :equality :typing)

  (:types book month)

  (:predicates
    (bookRead           ?b            - book)
    (bookCandidate      ?b            - book)
    (booksAreParallel   ?b1 ?b2       - book)
    (bookIsPredecessor  ?b1 ?b2       - book)
    (bookAssigned       ?b            - book)
    (monthCompleted     ?m            - month)
    (bookAssignedMonth  ?b - book ?m  - month)
	)

  (:action assignParallel
    :parameters (?b - book ?m - month)
    :precondition (and  (not (monthCompleted ?m))
                        (not (bookAssigned ?b))
                        (not (bookRead ?b))
                        (exists (?aux - book) (booksAreParallel ?aux ?b))
                  )
    :effect (and  (bookAssigned ?b)
                  (bookAssignedMonth ?b ?m))
  )

  (:action assignBook
    :parameters (?b - book ?m - month)
    :precondition (and (not (monthCompleted ?m)) (not (bookAssigned ?b)) (not (bookRead ?b))(not (exists (?aux - book) (and (bookIsPredecessor ?aux ?b)
     (not (bookRead ?aux)) (not (bookAssigned ?aux))))) (not (exists (?aux - book) (booksAreParallel ?aux ?b))))
    :effect (and (bookAssigned ?b) (bookAssignedMonth ?b ?m) (when (exists (?aux - book) (bookIsPredecessor ?b ?aux)) (monthCompleted ?m)))
	)
)
