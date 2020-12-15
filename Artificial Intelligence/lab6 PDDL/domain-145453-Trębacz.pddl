(define
    (domain world-of-blocks)
    (:requirements :adl)
    (:predicates
        (on-top ?x ?y)
        (on-floor ?x)
        (clear ?x)
        (picked-up ?x)
        (in-air)
    )
    (:action pickup-from-block
        :parameters (?x ?y)
        :precondition (and
            (clear ?x)
            (on-top ?x ?y)
            (not (in-air))
        )
        :effect (and
            (not (on-top ?x ?y))
            (clear ?y)
            (in-air)
            (picked-up ?x)
            (not (clear ?x))
        )
    )
    (:action pickup-from-floor
        :parameters (?x)
        :precondition (and
            (clear ?x)
            (not (in-air))
            (on-floor ?x)
        )
        :effect (and
            (in-air)
            (picked-up ?x)
            (not (on-floor ?x))
            (not (clear ?x))
        )
    )
    (:action putdown-to-floor
        :parameters (?x)
        :precondition (and 
            (in-air)
            (picked-up ?x)
        )
        :effect (and
            (on-floor ?x)
            (not (in-air))
            (not (picked-up ?x))
            (clear ?x)
        )
    )
    (:action putdown-to-block
        :parameters (?y ?x)
        :precondition (and 
            (in-air)
            (picked-up ?x)
            (clear ?y)
        )
        :effect (and
            (on-top ?x ?y)
            (not (clear ?y))
            (not (picked-up ?x))
            (not (in-air))
            (clear ?x)
        )
    )
)