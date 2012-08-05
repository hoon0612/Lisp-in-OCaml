(define (factorial n)
  "Calculates the factorial of the given number \"n\"."
  (if (= n 1)
    1
    (* n (factorial (- n 1))))))

(factorial 3)

"string literal test: (factorial 10)"
