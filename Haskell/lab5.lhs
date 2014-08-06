We went over in class a sort that I called insertion sort, although it
is different from the insertion sort in the textbook.

This insertion sort follows the following design:

insert x s ... inserts the value x into the already sorted list s

isort xs s ... iterates over the elements in xs and places them in the sorted
list s. Everytime we process an element x in xs, we reduce the size of xs by
1 and we grow the sorted list s by 1.

So here is the code:

>	insert a []	= [a]
>	insert a (x:xs)
>		| a <= x	= a:x:xs
>		| otherwise	= x:insert a xs


>	isort [] s	= s
>	isort (x:xs) s = isort xs s'
>		where
>			s' = insert x s


And then a driver to start off the sort:

>	insert_sort xs = isort xs []


>	l1 = [10,1,3,7,2,8,7,3,9]



*Main> insert_sort l1
[1,2,3,3,7,7,8,9,10]
*Main>


Make sure you can do the "rewriting" of these equations so you understand how
they work.

Then we looked at how to implement a for loop in Haskell.

Suppose we have this for loop:

for (int i=0; i<n; i++)
	sum = sum + a[i]

We can do that in Haskell in a few ways.

The first is implicit (ie we don't have a loop variable) and the other explicit.

>	mysum:: [Integer] -> Integer
>	mysum [] = 0
>	mysum (x:xs) = x+(mysum xs)

	l1 = [1, 2, 3]
	mysum l1 = mysum [1, 2, 3]
	1 + mysum [2,3]
	1 + 2 + mysum [3]
	1 + 2 + 3 + mysum []
	1 + 2 + 3 + 0

>	sum':: Int->Int->[Integer] -> Integer
>	sum' i n a
>		| i < n		= (a!!i) + (sum' (i+1) n a)
>		| otherwise	= 0



>	sum'':: Int->Int->[Integer] -> Integer -> Integer
>	sum'' i n a s
>		| i < n		= sum'' (i+1) n a (s + (a!!i))
>		| otherwise	= s


*Main> mysum [1,2,3,4,5]
15
*Main> sum' 0 5 [1,2,3,4,5]
15
*Main> sum'' 0 5 [1,2,3,4,5] 0
15
*Main>


Now your job is to implement the bubble sort (Alg 4 in section 3.1 6th edition)

First do the inner loop. Do it as an explicit for look with the
loop iteration variable. Assume that you have an exchange function. Here are
two versions of my exchange function:

>	xchng i l = take (i) l ++ [(l!!(i+1)), l!!i] ++ (drop (i+2) l) 

>	xchng' 0 (x:y:xs)	= y:x:xs
>	xchng' n (x:xs)		= x:(xchng' (n-1) xs)

On Wed in class we'll look at doing this without an implicit variable.

So, here are your tasks:

1. Implement bubble sort (alg 4 in section 3)

>	bubSort i n a
>		| i < n = if(a!!i > a!!(i+1)) then bubSort (i+1) n a' else bubSort (i+1) n a
>		| otherwise = a
>			where
>				a' = xchng' i a

>	bubble i n a
>		| i < n = bubble (i+1) n $ bubSort 0 (n-i) a
>		| otherwise = a

2. Implement fibonacci using straight recursion with the following definition:

fib 0 = 1
fib 1 = 1
fib n = fib (n-1) + fib (n-2)

Do this recursively in Haskell.

>	fib 0 = 1
>	fib 1 = 1
>	fib n = fib (n-1) + fib (n-2)

3. Write a factorial program using recursion:

fact 1 = 1
fact n = n * fact (n-1)

And then write it using a for loop with an explicit loop variable, also
in Haskell.

>	fact 1 = 1
>	fact n = n * fact (n-1)

>	fact' i n
>		| i > n = 1
>		| otherwise = i * fact' (i+1) n

4. Make sure you write a number of test cases for your programs.

*Main> fib 11
144
*Main> fib 12
233
*Main> fib 13
377
*Main> fib 20
10946
*Main> fib 30
1346269
*Main> fib 40
^CInterrupted.

*Main> fact' 2 5
120
*Main> fact' 3 5
60
*Main> fact' 4 5
20
*Main> fact' 5 5
5

*Main> fact 2
2
*Main> fact 3
6
*Main> fact 4
24
*Main> fact 5
120

5. Try using an accumulator as we did in class on Wed with fib.

>	fib' 0 a b = a
>	fib' n a b = fib (n-1) b (a+b)

>	fib'' n = fib n 1 1

Using this same technique, write a factorial that that is tail recursive,
using an acculumlator.

>	fact'' l f = f
>	fact'' n f = fact'' (n-1) (n*f)
