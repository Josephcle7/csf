So ... this lab starts with the material that we went over in class on Wed
April 23. We're going to be looking at how to represent relations and
Haskell functions that implement properties of relations. This is Chapter 
9 (7th edition) in the Discrete math text. THat would make it chapter 8 in
the 6th edition and chapter 7 in the 5th edition. It is chapter 10 in the
Discrete Math Using a Computer online textbook.

First how should we represent relations? We discussed 3 methods in class:
an adjacency matrix, a graph (V,E) of vertices and edges, where an edge
(x,y) means that xRy.   And a graph represented by adjacency lists 
[(v, [v])]: a list of pairs of vertices X list of adjacent vertices. In
that case (x, [x1, x2, x3]) means that there is an edge from x to x1, so xRx1.

Any one of these representations may be appropriate, depending on what you
want to do. But in Haskell a matrix may not be ideal, since a matrix
(a 2D array) is a state-based data structures and Haskell is not state-based.

The big difference between these graphs and the ones we did last week is
that graphs that represent relations must be directed. Ie (x,y) means that x
is related to y, but it doesn't mean that y is related to x. This of the
less-than relation.


So here is out type:

>	type Graph a = ([a], [(a,a)])

Suppose we want to determine if a relation is symmetric?


>	isSym edges [] 			= True
>	isSym edges ((x,y):xys)
>		| elem (y,x) edges 	= isSym edges xys
>		| otherwise		= False

The above implementation uses elem.  elem is primitive in Haskell. All
you need to use it is for the type of the elements in the list be equality
types. Ie if I have a graph whose vertices are represented as ints, ints
understand equality. But if I represented vertices as functions (for some
unknown reason) functions do NOT understand equality, so  elem would not work.

But, elem is not anything special. You don't need to use Haskell's definition.
You can use your own (this is good for practice at Haskell, not because you
need to redefine all these basic methods.)

Here is my version:

>	isMem _ [] = False
>	isMem y (x:xs)
>		| y == x	= True
>		| otherwise	= isMem y xs

Here's another way to do isMem

>	isMem' y xs = or $ map (\x -> y == x) xs
>	isMem'' y xs = or ( map (\x -> y == x) xs)

The first version just used basic list recusion. The second version
used higher order functions to implement isMem resulting in a shorter
if somewhat more obscure definition. Note that isMem' and isMem'' are
really the same.

First thing to understand is map. My definition of map is below, so skip down
to that briefly.  Assuming that you understand map, what does the $ do?
Remember that function application associates to the left and has the highest
priority. Now function application is really an operator, although it has
no character representing the operator: just juxtaposition. So (f g) represents
f applied to g. Some language make this explicit (eg f(g) or f@g). But Haskell
does not. Since it has a high priority if I write:

or map f xs

Haskell will attempt to evaluate: (((or map) f) xs).
This is NOT what we want. Instead we want to evaluate the sub-expression
(map f xs) first and THEN apply or to the result. The $ operator accomplishes
this. But so does the parenthesized expression.

The ... what does or do? The basic logical or operator is ||. so a || b
does a logical or. But if I want to generalize this to a number of logical
expressions: a || b || c || d what is really going on is (((a || b) || c) || d).
So if I have a list of logical expressions, or will do the logical or over all
of them. See my implementation below (or')

The last piece is what exactly are the arguments to map? Map takes a function
and a list. So the first argument is the function that we want to apply to
each of the elements of the list. I used an unnamed lamda expression
for the function. The way to read this:

\x -> x + 1

The \x specifies the argument. Then to the right of -> is the body of
the function. The above function adds 1 to its argument. It is the same as
the functions add1 and add1' below.


Here are two test graphs representing relations.

>	g1 = ([1,2,3], [(1,2), (2,3), (3,3)])
>	g2 = ([1,2,3], [(1,2), (2,3), (3,3), (2,1), (3,2)])
>	g3 = ([1, 2, 3], [(1, 2), (2, 3), (3, 3), (2, 1), (3, 2)])
>	g4 = ([5, 4, 3], [(4, 2)])

Q1. Try our isSym function on the two test graphs. Create 2 more graphs that
represent other relations to see if they are symmetric.

*Main> isSym (snd g2) (snd g3)
True
*Main> isSym (snd g2) (snd g4)
False

*Main> isSym (snd g1) (snd g1)
False
*Main> isSym (snd g2) (snd g2)
True
*Main> 


Let's look at map in detail. Here is the schema.

map f [x1, x2, x3] = [(f x1), (f x2), (f x3)]


Now I can define my own map using list recursion:

>	mymap f []	= []
>	mymap f (x:xs)	= (f x) : mymap f xs


Back to lambda terms. The "normal" way to define a function is by specifying
the function name and its arguments like this:

>	add1 x = x + 1

But that's not the only way. Another way is to use a lambda expression
and an "alias".

>	add1' = \x -> x + 1

In add1' I'm just saying "let add1' be the name of the lambda expression
that follows". It's no different than my definitions of g1 and g2 above.

Q2. Create a lambda expression that multiplies its argument by 3. Use
that lambda expression and map it over the list [1,2,3,4]. What happens? Why?

>	mult3 = \x -> x * 3
>	map_q2 = map (mult3) [1, 2, 3, 4]
It prints out [3, 6, 9, 12] because it mapped the mult3 function to the list [1, 2, 3, 4],
meaning it multiplied 1, 2, 3, and 4 by 3. 


>	or' [] = False
>	or' (x:xs) =  x || (or' xs)


Q3. Create an and' that does the same thing as or' but for the logical operator
&& (and). Test it on sample lists.

>	and' [] = True
>	and' (x:xs) = x && and' xs



Now the "real" homework:

1. Implement isTransitive
2. Implement isReflexive
3. Implement isAntiSymm
4. Implement isASym
5. Implement isIrreflexive
6. Implement relation composition. (This is Definition 6 and 7 in Section 9.1)
7. Test your definitions on the relations in Exercise 3 in section 9.1 and
in Figure 6 in Section .3)
8. Implement the symmetric closure of a relation.
9. Implement the transitive closure of a relation.
10. Implement the reflexive closure of a relation.

