(define (problem example)
  (:domain planner)

  (:objects
    b0 b1 b2 b3 - book
    january february march april may june august september october november december - month
  )

  (:init
    ;; Pages of each book
    (= (bookPages b0) 400)
    (= (bookPages b1) 300)
    (= (bookPages b2) 200)
    (= (bookPages b3) 100)

    ;; Predecessors of each book
    (bookIsPredecessor b0 b1)
    (bookIsPredecessor b2 b3)

    ;; Read books
    (bookRead b0)
  )

  (:goal (forall (?x - book) (not (bookRead ?x)) (bookAssigned ?x)))
)
