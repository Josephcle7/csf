Here is a simple list. We're going to play with this list to get used to Haskell
types before we start playing with trees. This is a literate script, so even
though I'm typing readable text for you, it is also a program. Program lines are
head by the carot symbol.  Non programs lines are just typed in with no carot.

"data" is a keyword that tells haskell you are introducing a new type. "a" is a
type variable.

>	data List a = Empty | Cons a (List a) 
>		deriving (Show)

So a List is either empty or it is a list with a head and a tail. All
lists are homogeneous: they only contain one type of value. You've already seen
this in Java with the use of Java type variables (generics) and the Java class
Object.

Let's define head and tail now:

>	hd Empty = error "Exception! head on an empty list"
>	hd (Cons a _) = a

>	tl Empty = error "Exception! tail on an empty list"
>	tl (Cons _ t) = t

Notice that hd and tl are partial functions: they are not defined on empty lists.

Now we'll make a few lists:

>	l1 = Empty
>	l2 = (Cons 1 (Cons 2 (Cons 3 Empty)))

Q1. Now make the list [5,1,7,2,9,10] using the above List. You should edit THIS
file in your pico editor, save it, and then load it into your ghci. So to complete
this lab question you will create a list called l3 which contains the above
mentioned values.

>	l3 = (Cons 5 (Cons 1 (Cons 7 (Cons 2 (Cons 9 (Cons 10 Empty))))))

Ok now, lets count the number of elements in a list:

>	cnt Empty = 0
>	cnt (Cons _ t) = 1 + cnt t

Q2. Using rewriting (which we introduced last week) show how cnt works on the
list l3. Put your answer into this file using pico.

	cnt l3 = (Cons 5 (Cons 1 (Cons 7 (Cons 2 (Cons 9 (Cons 10 Empty))))))
	1 + cnt (Cons 1 (Cons 7 (Cons 2 (Cons 9 (Cons 10 Empty)))))
	1 + 1 + cnt (Cons 7 (Cons 2 (Cons 9 (Cons 10 Empty))))
	1 + 1 + 1 + cnt (Cons 2 (Cons 9 (Cons 10 Empty)))
	1 + 1 + 1 + 1 + cnt (Cons 9 (Cons 10 Empty))
	1 + 1 + 1 + 1 + 1 + cnt (Cons 10 Empty)
	1 + 1 + 1 + 1 + 1 + 1 + cnt Empty
	 

Now we'd like to create an append function:

>	app l Empty = l
>	app Empty l = l
>	app (Cons a t) xs = Cons a (app t xs)

Q4. Test this function on by appending l1 l2. Paste the results in this file
using pico.

"""
Appending l1 and l2:
Cons 1 (Cons 2 (Cons 3 Empty))
"""

Lets make some pairs. Pairs are a kind of tuple. So (a,b) is a pair. But we can also
create a 3-tuple. For now let's just look at pairs. Suppose that I want to "package"
my list up as a list with its length: (list, len). I can name a function package
that does this:
	
>	data Pr a b = Pr a b
>		deriving(Show)

>	package l = (l, cnt l)

Or ... we talked about zip in class. Let's define zip again:

>	myzip Empty _ = Empty
>	myzip _ Empty = Empty
>	myzip (Cons x xs) (Cons y ys) = Cons (x,y) (myzip xs ys)

So that create a list of pairs from two lists. 

Q5. What is the type of app, package, and myzip. 

Then we can unzip!

>	myunzip Empty = (Empty, Empty)
>	myunzip (Cons (x,y) zs) = ((Cons x l1), (Cons y l2))
>		where
>			(l1, l2) = myunzip zs


Q6. Now, use myzip and any of the lists in this file and create a zipped list.
Then unzip the list. How do these work. Demonstrate how they work using rewriting.

Now we're going to look at a few higher order functions. This is a little more
challenging. Remember we said that in Haskell functions are values? We can use them
very flexibly. Suppose that I want to apply a function f to every member of a list.
This function is usually called map. So is I start out with a list [1,2,3] and I want
to add 1 to each element of the list, I can "map" a function that adds 1 over these
elements. Here's what it looks like:

>	mymap _ Empty = Empty
>	mymap f (Cons a t) = Cons (f a) (mymap f t)

And I'll use an anonymous function to add 1: (\x -> x+1).

Q7. See what happens when you type: mymap (\x -> x+1) l2. Use rewriting to see why
this happens. What is the type of mymap? What does this type mean?

Okay, now we're going to Workshop 6, doing only the first 4 questions.
