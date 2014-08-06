This is a basic lab with exercises in constructing trees and traversing trees. 

First lets look at a basic tree:

>	data BTree a = Leaf a | Node a (BTree a) (BTree a)
>		deriving (Show)

Now lets use this tree to make a tree:

>	t1 = Leaf 1
>	t2 = Leaf 2
>	t3 = Node 3 t1 t2
>	t4 = Leaf 4
>	t5 = Leaf 5
>	t6 = Node 6 t4 t5
>	t7 = Node 7 t3 t6

Q1. Give an inorder traversal of the tree.

[1, 2, 1, 7, 4, 6, 5]

Q2. Give a postorder traversal of the tree.

7, 3, 1, 2, 6, 4, 5]
Q3. Give a preorder traversal of the tree.


How can we have Haskell give us these traversals?

>	inorder (Leaf x) = [x]
>	inorder (Node x t1 t2) = inorder t1 ++ [x] ++ inorder t2


>	preorder (Leaf x) = [x]
>	preorder (Node x t1 t2) = [x] ++ preorder t1 ++ preorder t2

Q3'. Use this model to write a postorder traversal.

>	postorder (Leaf x) = [x]
>	postorder (Node x t1 t2) = postorder t1 ++ postorder t2 ++ [x]

(EC1): Write a haskell function that takes
an inorder and preoder traversal and reconstructs the tree.

Now make an expression tree:

>	data ETree = Operand Int | Operator Char ETree ETree
>		deriving (Show)


>	e1 = Operator '+' (Operand 4) (Operand 5)

(EC2): Write an evaluator for the expression tree.
(EC3): Write a convertor that takes a prefix expression and
constructs the tree.


Q4. Make the expression tree for (4+5*2)-6/3 + 2 using normal precedence



What if we want this to be more general? So we're not limited to
ints and character operators?

>	data Expr a b = Oprnd a | BinOp b (Expr a b) (Expr a b) | UnOp b (Expr a b)
>		deriving (Show)


Now lets define some operators:

>	data ArithOps = Plus |  Minus | Mul | Div
>		deriving (Show)

>	data LogicOps = And | Not | Implies | Or
>		deriving (Show)

>	data PropLetters = P | Q | R | S | T
>		deriving (Show)

>	f1 = UnOp Not (BinOp And (Oprnd P) (Oprnd Q))

Q5. Construct the trees in Figure 14 from the textbook.

A Spanning tree is a tree that is a subgraph of a graph G such that it contains
every vertex in G. So to do this, we need to represent graphs. Even though
we're not doing graphs in detail until week 6, let's make a simple graph.

>	type Graph = ([Int], [(Int, Int)])

This is an alias: a graph is just a pair (V,E), where V is a list of
vertices and E  a list of edges.

>	g1 = ([1,2,3], [(1,2), (1,3), (2,3)])

Or more generally:

>	type GGraph a = ([a], [(a,a)])

>	g2 :: GGraph Int
>	g2 = ([1,2,3], [(1,2), (1,3), (2,3)])
>	g3 :: GGraph [Char]
>	g3 = (["Herman", "Hampden", "Etna"], [("Herman", "Hampden"), ("Hampden", "Etna")])

Q6. Make the graph in Figure 6 section 4


Now we can talk about two other kinds of traversals or searchs: Depth First search and breadth first search.

We can see that the precedure in Section 10.4 has a bunch of subproblems.
Assume undirected!
First we need to get adjacent vertices:

>	adj w [] = []
>	adj w ((v1,v2):vs)
>		| w == v1		= v2 : (adj w vs)
>		| w == v2		= v1 : (adj w vs)
>		| otherwise		= adj w vs

And we want to see the edges:

>	edges (v,e) = e

>	vertices (v,e) = v

>	mem v [] = False
>	mem v (w:ws)
>		| v == w		= True
>		| otherwise		= mem v ws



Q7. Give examples using adj, edge, vertices, and mem.

We'll finish dfs and bfs next time. But if you ready for it, you can start!
