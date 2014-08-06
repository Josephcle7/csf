This introduces some functions that support creating a spanning tree.

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

The algorithms for a spannign tree, dfs, bfs, etc. need a variety of support
functions. We'll explore these now.
Assume undirected graphs!

>	g5 :: GGraph Char
>	g5 = (['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k'], [('a', 'c'), ('b', 'c'), ('c', 'e'), ('e', 'd'), ('e', 'f'), ('d', 'f'), ('f', 'g'), ('f', 'h'), ('g', 'h'), ('h', 'i'), ('h', 'k'), ('k', 'j')])

>	g7 :: GGraph Char
>	g7 = (['q', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k'], [('q', 'c'), ('b', 'c'), ('c', 'e'), ('e', 'd'), ('e', 'f'), ('d', 'f'), ('f', 'g'), ('f', 'h'), ('g', 'h'), ('h', 'i'), ('h', 'k'), ('k', 'j')])

We need the list of adjacent vertecies:

>	adj w [] = []
>	adj w ((v1,v2):vs)
>		| w == v1		= v2 : (adj w vs)
>		| w == v2		= v1 : (adj w vs)
>		| otherwise		= adj w vs

And we want to see the edges:

>	edges (v,e) = e

And we want to see the vertices:

>	vertices (v,e) = v

And we'd like to know if a vertix is already in the set of vertcies:


>	mem v [] = False
>	mem v (w:ws)
>		| v == w		= True
>		| otherwise		= mem v ws



Q7. Give examples using adj, edge, vertices, and mem.

	edges g6 = [('a', 'c'), ('b', 'c'), ('c, 'e')]
	vertices g6 = *abce*
	mem 'd' (vertices g6) = False
	adj 'a' (edges g6)

Now we also need to know when two sets are equal (in this case because we
want to know when two sets of vertices are equal):

The standard definition of set equality is : A = B iff A subseteq of B and
B subseteq of A.

>	subset [] _	= True
>	subset (x:xs) ys
>		| mem x ys		= subset xs ys
>		| otherwise		= False

>	seteq xs ys = subset xs ys && subset ys xs

Q8. Test seteq on several sets (in this case, remember that sets are
implemented using lists.)

>	set1 = [1, 2, 3, 4, 5]
>	set2 = [6, 7, 8, 9, 10]
>	set3 = [11, 12, 13, 14, 15]
>	set4 = [6, 7, 8, 9, 10] 

Q9. Take two graphs and determine if they have the same set of vertices
(you will need to use the function vertices to extract the vertices.

seteq (vertices g5) (vertices g7) = false 

The next thing we want to do is find a vertex u adjacent to a vertex 
w that has not yet been visited: (in the context of a spanning tree this should
never fail since we assume the graph is connected.

So we have two graphs: the original graph (v,e) and the tree (v1, e1).
We want a vertex in v adjacent to w in the original graph that has not
yet been visited
(ie it is not in v1).

>	getUnvisited w g@((v:vs),e) (v1, e1) = unvisited adjs
>			where
>				adjs = adj w e
>				unvisited []			= error "Should not happen"
>				unvisited (x:xs)
>					| not (mem x v1)	= (w,x)
>					| otherwise			= unvisited xs

Q10. Use one of your graph and test getUnvisited. To use it (for instance):

*Main> getUnvisited 1 g1 ([1],[])
(1,2)
*Main> getUnvisited 2 g1 ([1,2], [(1,2)])
(2,3)
*Main> 

Now I'll define a boolean predicate that just returns true or false
depending on if a node has any unvisited adjacent nodes.

>	isUnvisited w g@((v:vs),e) (v1, e1) = unvisited adjs
>			where
>				adjs = adj w e
>				unvisited []			= False
>				unvisited (x:xs)
>					| not (mem x v1)	= True
>					| otherwise			= unvisited xs

Q11. What is different between isUnvisited and getUnvisited? Why would
you use it? Try it on the same graphs as for Q10.

Now we can put these together to get a node that is unvisited to add
to the tree:

Basically the algorithm is
	While there is a vertex in the tree t that has an adjacent node
	that has not yet been visited, add that edge to t and keep on
	going until there are no more unvisited vertices.

The funtion getAnUnvisited takes a graph and a spanning tree and
then uses isUnvisited and getUnvisited to actually get the desired vertex
and edge. (Note this is not efficient, but it follows the logic!)

The arguments to getAnUnvisited are the graph, then two copies of
the spanning tree being constructed. The first copy of the spanning tree
is used to control the iteration (we look at each visited vertex in turn).
But that means we are "changing" the spanning tree on each recursive
call, and we still need the unchanged spanning tree in order to test
if a node has been visited.

So the second copy is the untouched spanning tree under construction.

We use the graph itself to find the adjacent edges.

isUnvisited tells us that we've found a vertex that has an unvisited adjacent
edge. We then call getUnvisited to get that actual edge

If the current vertex we are looking at does not have an unvisited adjacent
vertex, we just keep looking at the visited nodes in the spanning tree.

>	getAnUnvisited g@(v1,e1) t@((v:vs), es) spanTree
>		| isUnvisited v g t		= getUnvisited v g spanTree
>		| otherwise				= getAnUnvisited g (vs,es) spanTree


*Main> getUnvisited 1 g1 ([1], [])
(1,2)
*Main> getUnvisited 1 g1 ([1,2], [(1,2)])
(1,3)
*Main> 

*Main> getAnUnvisited g1 ([1], []) ([1], [])
(1,2)
*Main> getAnUnvisited g1 ([1,2], [(1,2)]) ([1,2], [(1,2)])
(1,3)
*Main> 


Q12. What is the difference between getAnUnvisited and getUnvisited? Why
might you use one or the other? Try these methods on different graphs.

The input to spanning is the graph (v,e) and the output is a tree t@(v,e):
remember that a tree is just a graph with no cycles.
This is very similar to the dfs algorithm in section 10.4, but we don't visit
the nodes in a depth-first manner (ie from the last node visited) but instead
pick any node that is still unvisited. We'll talk about the difference next week.

We assume that we have a connected graph so that we know when we are done
when the vertices in t are equal to the vertices in the original graph.

To start you set t = ([v1], []) meaning that we assume we've visited
the node v1, and we are looking for adjacent edges from there.

We know we are done when we've visited all the nodes in the graph.

>	spanning g@(v1,e1) t@(v2,e2)
>		| seteq v1 v2		= t
>		| otherwise			= spanning g ((newVertex:v2), ((u,w):e2))
>			where
>				(u,w) = getAnUnvisited g t t
>				newVertex = if (mem u v2) then w else u


*Main> spanning g1 ([1], [])
([3,2,1],[(2,3),(1,2)])
*Main> 

Q13. Test spanning on a variety of graphs.
				
>	g4 = ([1,2,3,4], [(1,2), (1,3), (2,3), (1,4), (2,4)])

*Main> spanning g4 ([1], [])
([4,3,2,1],[(2,4),(2,3),(1,2)])



When I put in the edge into the spanning tree there is no guarantee that I 
put it in in the same order as it was represented in the graph. Ie (a,b) is
an undirected edge between a and b. But (b,a) is the same edge. So I 
don't bother to check the edge orientation.

Now the dfs method is not much different than this spanning tree EXCEPT that
in the dfs we always use the last node visited to continue the search for
nodes to visit. The description in the textbook is correct but the Algorithm
1 for DFS (constructing the spanning tree) is a little opaque since it doesn't
specify how to "back-up" to a node with an unvisited adjacent node. It actually
uses double recursion: it calls visit recursively AND it has a for loop
for each adjacent node to each visited node. That makes it somewhat complex
to analyze.

Here is the algorithm:

procedure DFS(G: connected graph with vertices v1, v2, ..., vn)
T:=tree consistsing only of the vertex v1
visit (v1)

procedure visit(v:vertex of G) 
for each vertex w adjacent to v and not yet in T
	add vertex w and edge (v,w) to T
	visit(w)

Here is the Haskell version of this. DON'T WORRY ABOUT THIS ONE YET!
IT USES A NUMBER OF HASKELL FEATURES THAT WE HAVEN'T LOOKED AT YET.

First I define a mem function that reverses the order of the arguments.

>	rmem [] v = False
>	rmem (w:ws) v
>		| v == w		= True
>		| otherwise		= rmem ws v

The following gives me all the vertices adjacent to v that are not
yet in the spanning tree.

(This uses another function called filter and function composition.)


>	adjs v g@(vs,es) t@(tvs, tes) = filter (not.(rmem tvs)) (adj v es)

Q14. Try using filter. First find the type of filter by entering into
Haskell:

:t filter

Then try entering:

filter ((<) 4) [1,2,5,6,10,14,2]
filter ((>) 4) [1,2,5,6,10,14,2]


Q15. What does rmem do?
Try entering:

rmem [1,3,5,7,9] 3
rmem [1,3,5,7,8] 2

Q16. the expression (not. (rmem tvs)) uses function composition and partial
application. Try entering 

(not . (rmem [1,3,5,7])) 4
(not . (rmem [1,3,5,7])) 5



To use visit, tvs (the vertices in the spanning tree) is initialized to
[v], indicating that we're starting at vertex v. The edges are empty, since
we haven't traversed any edges yet.

Eg: visit 1 g4 ([1], [])

>	dfs g@((v:vs), es) = visit v g ([v], [])


>	visit v g@(gvs, ges) t@(tvs, tes)
>		| seteq gvs tvs		= t
>		| otherwise			= do_visit v (adjs v g t) g t

The following is the for loop. Note that in the for loop, we
may visit a node w that was identified as adjacent to the vertex
v. BUT when we visit the node w, we may end up visiting some node
already on the list of nodes adjacent to v, so we need to filter out
these nodes that have already been visited.

>	do_visit _ [] _ t = t
>	do_visit v (w:ws) g t@(tvs, tes) = do_visit v new_ws g new_t
>		where
>			new_t@(ntvs, ntes) = visit w g (w:tvs, ((v,w):tes))
>			new_ws = filter (not.(rmem ntvs)) ws 

As noted above, the above 2 lines: new_t is the spanning tree that results
from visiting w.  But this may end up visiting some vertices specified in ws.
So we need to filter out those that have already been visited.

If we look at how spanning differs from dfs:

*Main> spanning g4 ([1], [])
([4,3,2,1],[(2,4),(2,3),(1,2)])
*Main> dfs g4
([4,3,2,1],[(2,4),(2,3),(1,2)])
*Main> 



Both produce spanning trees.
The dfs version starts with vertex 1, then visits 2, then from 2 it visits 3.
There are no more vertices unvisited from 3, so we go back to the vertices
adjacent to 2 ([1,2,3]), and look for nodes adjecent to 2, giving us (2,4).

The spanning tree version is neutral as to which vertex it picks, it just
marches down the list of vertices looking for nodes in the tree that have
unvisited adjacent nodes.

