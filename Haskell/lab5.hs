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
