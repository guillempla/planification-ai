(define (problem example)
  (:domain planner)

  (:objects
    b0 b1 b2 b3 - book
    january february march april may june august september october november december - month
  )

  (:init
    ;; Read books
    (bookCandidate b0)
    (bookCandidate b1)
    (bookCandidate b2)
    (bookCandidate b3)
  )

  (:goal (forall (?b - book) (bookAssigned ?b)))
)
