#!/usr/local/bin/guile -s
!#

;; Exercise 1.11. A function f is defined by the rule that
;; f(n) = n if n<3 and f(n) = f(n - 1) + 2f(n - 2) + 3f(n - 3) if n> 3.
;; Write a procedure that computes f by means of a recursive process.
;; Write a procedure that computes f by means of an iterative process. 


; Recursive process

(define (f n)
    (cond ((< n 3) n)
          ((>= n 3) (+ (f (- n 1))
                       (* 2 (f (- n 2)))
                       (* 3 (f (- n 3)))))))


; Iterative process

(define (f n)
    (cond ((< n 3) n)
          ((>= n 3) (f-iter 0 1 2 n))))

(define (f-iter a b c counter)
    (cond ((< counter 3) c)
          ((>= counter 3) (f-iter b c (+ c (* 2 b) (* 3 a)) (- counter 1)))))

