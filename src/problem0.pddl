(define (problem example)
  (:domain planner)

  (:objects
    b0 b1 b2 b3 b4 b5 - book
    december november october september august july june may april march february january - month
  )

  (:init
    ;; Read books
    (bookRead b0)

    ;; Candidate books
    (bookCandidate b1)
    (bookCandidate b2)
    (bookCandidate b5)

    ;; Predecessor books
    (bookIsPredecessor b0 b3)
    (bookIsPredecessor b3 b5)
    (bookIsPredecessor b4 b5)

  )

  (:goal
    (forall (?b - book)
      (or (bookRead ?b) (and (bookCandidate ?b) (bookAssigned ?b)) (not (bookCandidate ?b)))
    )
  )
)
