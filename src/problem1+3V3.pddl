(define (problem example)
  (:domain planner)

  (:objects
    b0 b1 b2 b3 b4 b5 b6 b7 - book
    december november october september august july june may april march february january - month
  )

  (:init
    ;; Read books
    (bookRead b0)
    (bookRead b7)

    ;; Candidate books
    (bookCandidate b1)
    (bookCandidate b2)
    (bookCandidate b3)
    (bookCandidate b4)
    (bookCandidate b5)
    (bookCandidate b6)


    ;; Predecessor books
    (bookIsPredecessor b2 b1)
    (bookIsPredecessor b5 b3)
    (bookIsPredecessor b6 b4)

    ;; Pages of each book
    (= (bookPages b0) 400)
    (= (bookPages b1) 800)
    (= (bookPages b2) 200)
    (= (bookPages b3) 200)
    (= (bookPages b4) 400)
    (= (bookPages b5) 600)
    (= (bookPages b6) 1200)
    (= (bookPages b7) 600)

    ;; Pages asigned to each month
    (= (monthPages december)  0)
    (= (monthPages november)  0)
    (= (monthPages october)   0)
    (= (monthPages september) 0)
    (= (monthPages august)    0)
    (= (monthPages july)      0)
    (= (monthPages june)      0)
    (= (monthPages may)       0)
    (= (monthPages april)     0)
    (= (monthPages march)     0)
    (= (monthPages february)  0)
    (= (monthPages january)   0)

  )

  (:goal
    (forall (?b - book)
      (or (bookRead ?b) (and (bookCandidate ?b) (bookAssigned ?b)) (not (bookCandidate ?b)))
    )
  )
)
