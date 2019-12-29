(define (problem example)
  (:domain planner)

  (:objects
    b0 b1 b2 b3 - book
    january february march april may june august september october november december - month
  )

  (:init
    ;; Read books
    (bookRead b0)
  )

  (:goal (forall (?b - book) (not (bookRead ?b)) (bookAssigned ?b)))
)
