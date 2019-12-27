(define (problem example)
  (:domain planner)
  (:objects
    b0 b1 b2 b3 - book
    january february march april may june august september october november december - month
  )
  (:init
    (BOOK b0)
    (BOOK b1)
    (BOOK b2)
    (BOOK b3)
    (MONTH january)
    (MONTH february)
    (MONTH march)
    (MONTH april)
    (MONTH may)
    (MONTH june)
    (MONTH august)
    (MONTH september)
    (MONTH october)
    (MONTH onovember)
    (MONTH december) 
  )
  ;; The goal is:
  (:goal (forall (?x - book) (bookAssigned ?x)))
)
