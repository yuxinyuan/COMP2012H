(define > (lambda (x y) (< y x)))
(define >= (lambda (x y) (not (< x y))))
(define <= (lambda (x y) (not (< y x))))
(define = (lambda (x y) (if (< x y) 0 (not (< y x)))))
(define abs (lambda (x) (if (< x 0) (- 0 x) x)))

(define factorial 
  (lambda (x) 
    (if (< x 2) 
	1 
	(* x (factorial (- x 1))))))

(define for-each
  (lambda (f args)
    (if (nullp args)
	(quote ())
	(cons (f (car args)) (for-each f (cdr args))))))    

(define zero? (lambda (n) (= n 0)))
(define list (lambda args args))
(define len
  (lambda (li)
    (define len-iter
      (lambda (li n)
	(if (nullp li)
	    n
	    (len-iter (cdr li) (+ n 1)))))
    (len-iter li 0)))

(define for-each-args
  (lambda n    

    (define test-length
      (lambda (arg-list)
	(define test
	  (lambda (arg-list n)
	    (if (nullp arg-list)
		1
		(if (= n (len (car arg-list)))
		    (test (cdr arg-list) n)
		    0))))
	(test (cdr arg-list) (len (car arg-list)))))

    (define get-first
      (lambda (arg-list)
	(if (nullp arg-list)
	    (quote ())
	    (cons (car (car arg-list)) (get-first (cdr arg-list))))))
    
    (define get-rest
      (lambda (arg-list)
	(if (nullp arg-list)
	    (quote ())
	    (cons (cdr (car arg-list)) (get-rest (cdr arg-list))))))
    
    (define no-args
      (lambda (arg-list)
	(if (nullp (car arg-list))
	    1
	    0)))
    
    (define main
      (lambda n
	(define func (car n))
	(define arg-list (cdr n))
	(if (no-args arg-list)
	    (quote ())
	    (begin (apply func (get-first arg-list))
		   (apply for-each-args (cons func (get-rest arg-list)))))))

    (if (test-length (cdr n))
	(apply main n)
	(print (quote error)))))

(define list-tail
  (lambda (li num)
    (if (zero? num)
	li
	(list-tail (cdr li) (- num 1)))))

(define list-ref
  (lambda (li index)
    (if (zero? index)
	(car li)
	(list-ref (cdr li) (- index 1)))))


(define reverse
  (lambda (li)

    (define get-last
      (lambda (l)
	(if (nullp (cdr l))
	    (car l)
	    (get-last (cdr l)))))

    (if (nullp li)
	(quote ())
	(cons (get-last li) (reverse (cdr li))))))
    