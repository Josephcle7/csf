Chapter 12 is about langauges and Grammars. We study this extensively in
the program "Computability etc." so this will just be a quick over-view,
not at all an in-depth study.

One of the central questions about computer languages is: is a string 
in the language. IE is the java program you just typed in a legal Java program?
That's another way of asking "is the Java program you juyst typed in the
language Java?"

Probably in 5th or 6th grade you learned to diagram sentences (if English is
your first language, that is.) There are grammatical rules that define what
is a correct English sentence. Those rules determine a "parse": a way to
deconstruct a sentence according to the grammar rules to confirm that the
string can be derived by 1 or more applications of the rules.

There are different kinds of grammars, each representing a larger class of
languages.

Type 3: regular expressions
Type 2: context free grammars, phrase structured grammars
Type 1: context sensitive grammars
Type 0: unrestricted grammars

(See section 12.1, p 789 in the 7th edition and p 790, Table 1)

Natural languages are generally produced by unrestricted grammars. Most
programming languages are produced by context free grammars. The tokens
and literals in a programming languages are produced by Type 0 grammars 
(EG the key words, the labels, the identifiers, literal integer constants,
literal floating point constants).

Each grammar corresponds to an abstract machine 

Type 3 --> finite state machine
Type 2 --> push down automata
Type 1 --> turing machine with a finite tape
Type 0 --> turing machine with an infinite tape

We're only going to look at Type 3 and some of Type 2 in this lab.

The book is a little backwards on this. Regular expressions are covered in
section 12.4, finite machines in sections 12.2 and 12.3, and phrase structured
grammars in 12.1. I cannot justify this progression, but perhaps the authors
believed this was more intuitive. 

In Defn 2, he specifies a phrase structure grammar as a structure 
(V, T, S, P) where V is the vocabulary (variables and terminal symbols),
T is the terminal symbols (T is a subset of V), S is the start symbol. P
is a set of productions (rules).  In a Type 2 grammar the rules are restricted
to a w1 -> w2, where w1 is a single non terminal (V-T) and w2 is a string
over V.

In a Type 3 grammar, the rules are of the form w1 -> w2, where w1 is a single
non-terminal and w2 has the form aA, where a is a terminal (an element of T)
and A is a non-terminal (an element of V-T). 

Suppose we have the grammar from Example 12:

P = {
S -> AB,
A -> Ca,
B -> Ba,
B -> Cb,
B -> b,
C -> cb,
C -> b }

V = {S,A,B,C, a,b,c},
T = {a,b,c}


We can check if the word cbab is in the language

S -> AB
  -> CaB
  -> cbaB
  -> cbab


We can also "parse" this automatically using a top-down parser. For
this parse we are answering "yes" or "no" (yes the string is in the
language) (no the string is not in the language). We'll talk about
producing the parse tree after.

There is only one rule for S. It must be an A followed by a B.

S -> AB

>	s [] = (False, [])
>	s xs
>	  | v' 				= (v'', xs'')
>	  | otherwise	= (False, xs')
>		where
>			(v', xs') = a xs
>			(v'', xs'') = b xs'

The rule for A is it must be a C followed by 'a'.

A -> Ca

>	a []	= (False, [])
>	a xs  = (x == 'a', xs')
>		where
>			(v, x:xs') = c xs

The parse for b is harder since there are three rules.
The first B rule is recursive and will produce Ba^n for n applications
of the rule. The second rule will produce one of two terminal strings:
"cb" or "b". So this rule can produce ba^n for n>=0 OR cba^n OR bba^n

Here are some sample derivations:

B -> Ba
  -> Baa
  -> Baaa
  -> Cbaaa
  -> cbaaa

B -> Ba
  -> Baa
  -> Baaa
  -> baaa

B -> Ba
  -> Baa
  -> Cbaa
  -> bbaa

B -> b

B -> Ba | Cb | b

So putting them all together, the b rule will have to "look ahead" two
characters. If the string ends with the "b", then we are done (B->b).
If the string starts with ba, then we must use the B rule (B ->Ba).
	and for each a, we apply the b rule one more time.
If the string starts with cb, then we must use the C rule (B->Cb, C->cb).
If the string starts with bb, then we must use the C rule (B->Cb, C->b).


>	b l@(x:y:xs)
>		| x == 'b' && y == 'a'					= (v', xs')
>		| x == 'c' && y == 'b' && x'' == 'b'	= (v'',  xs'')
>		where
>			(v',xs') = b (x:xs)
>			(v'', (x'':xs'')) = c l
>	b ('b':xs) = (True , xs)
>	b _ = (False, [])

B -> Cb
  -> cbb

B -> Cb
  -> bb

Note that C is always followed by an 'a' or a 'b'.
So the remaining part of the string is guaranteed to not be empty.
But B may end the string (S->AB) or there may be more (B -> Ba)
So the remaining part of the string my be empty.

Now the c-rule only has terminal strings:

>	c ('c':'b':xs) = (True, xs)
>	c ('b':xs) = (True, xs)

This is a top-down (recursive descent) parser. It just tells us yes/no.
If we want the parse tree, we would return a structure.

>	data Parse = S Parse Parse | A Parse Char | B1 Parse Char | B2 Parse Char | B3 Char | C1 [Char] | C2 Char | None
>		deriving (Show)

*Main> (S (A (C1 "ab" ) 'a') (B3 'b' ) )
S (A (C1 "ab") 'a') (B3 'b')
*Main> 

>	s' [] = (False, [], None)
>	s' xs
>	  | v'              = (v'', xs'', S s1 s2)
>	  | otherwise   = (False, xs', None)
>		where
>			(v', xs', s1) = a' xs
>			(v'', xs'', s2) = b' xs'


>	a' []    = (False, [], None)
>	a' xs  = (x == 'a', xs', A s1 'a' )
>		where
>			(v, x:xs', s1) = c' xs


>	b' l@(x:y:xs)
>		| x == 'b' && y == 'a'                  = (v', xs', B1 s1 'a')
>		| x == 'c' && y == 'b' && x'' == 'b'    = (v'',  xs'', B2 s2 'b')
>			where
>				(v',xs', s1) = b' (x:xs)
>				(v'', (x'':xs''), s2) = c' l
>	b' ('b':xs) = (True , xs, B3 'b')
>	b' _ = (False, [], None)

>	c' ('c':'b':xs) = (True, xs, C1 "cb")
>	c' ('b':xs) = (True, xs, C2 'b')

*Main> s' "cbab"
(True,"",S (A (C1 "cb") 'a') (B3 'b'))
*Main> 







So the most restrictive kind of grammar is the grammar that produces
regular languages. A grammar of this form can only have rules that look like:


We could define a language for integers:

D -> 0 | 1 | 2 | 3  | 4 | 5 | 6 | 7 | 8 | 9
I -> D I

Then a finite state machine is a structure (Q, S, F, Sigma, P)
Where Q is the set of states,  S is the start state, F is a set of final
states, Sigma is the terminal alphabet, and P are the productinos.
(This is a finite state machine with no output, section 12.3, p 805)

Now the way to recognize an string that represents an integer:

Q = {q0}
S = q0
F = {q0}
Sigma = {0,1,2,3,4,5,6,7,8,9}


P = {
p(q0, v) = q0 for all v in Sigma
}

This is sort of uninteresting.

What if we want to recognize all strings that have a certain pattern of repetition.

A regular language L allows us to speicfy this. A regular set is composed
of 
for all a in Sigma, a is a regular set
If a,b are regular, then so is ab (concatentation)
if a,b are regular then so is a or b (alternation)
if a is regular then so is a* (kleene star)

Supose Sigma = {a,b}
We can specify a regular set S by using the above operations:

L = a (ab)* b

Strings in the language are then:

ab
aabb
aababb
aabababb
etc.

Here is a finite state machine that recognizes this language:

Q = {q0, q1, q2, q3, q4}
S = q0
F = {q4}
P =
{ p(q0, a) = q1,
  p(q1, b) = q4,
  p(q1, a) = q2,
  p(q2, b) = q3,
  p(q3, a) = q2
  p(q3, b) = q4
}

So in q0 we recognize 'a'.
In q1-q2 we recognize "ab" pairs.
In q3 we've recognized a complete pair, and will either
start the "ab" over again or terminate with 'b'.

>	data Rule = R State Char State
>		deriving (Show)

>	data State = Q0 | Q1 | Q2 | Q3 | Q4
>		deriving (Show, Eq)

>	fsm' = ([Q0, Q1, Q2,  Q3, Q4], Q0, [Q4], [R Q0 'a' Q1, R Q1 'a' Q2, R Q2 'b' Q3, R Q3 'a' Q2, R Q3 'b' Q4, R Q1 'b' Q4])

>	fsm curState [] (q,s,f,p)= elem curState f
>	fsm curState (x:xs) m@(q,s,f,p) 
>		| succ						= fsm curState' xs m
>		| otherwise					= False
>		where
>			(succ, curState') = findRule p
>			findRule [] = (False, Q0)
>			findRule ((R s1 c s2):ys)
>				| s1 == curState && x == c	= (True, s2)
>				| otherwise					= findRule ys


*Main> fsm Q0 "ab" fsm'
True
*Main> fsm Q0 "aabb" fsm'
True
*Main> fsm Q0 "aababb" fsm'
True
*Main> fsm Q0 "aabab" fsm'
False
*Main> 


Q1. Write  a parser for the following language:

S -> A C
A -> Aa | Bb | d
C -> Cc | c

>	s [] = (False, [])
>	s xs
>		| v' = (v'', xs'')
>		| otherwise = (False, xs')
>		where
>			(v', xs') = a xs
>			(v'', xs'') = c xs'

>	a l@(x:y:xs)
>		| x == 'a' && y == 'a' 					= (v', xs')
>		| x == 'b' && y == 'b' && x'' == 'b'	= (v'', xs'')
>		where
>			(v', xs') = b (x:xs)
>			(v'', (x'':xs'')) = b l
>	



Q2. Add in a parse tree

Q3. Write an fsm for the language a (bb)* (aa)* b
