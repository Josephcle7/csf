import networkx as nx
import matplotlib.pyplot as plt

G = nx.Graph()

G.add_nodes_from(['a', 'b', 'c', 'd', 'e', 'f'])
G.add_edges_from([('a','b'),('a','c'),('b','c'),('b','d'),('c','d'),('c','f'),
                ('d','f'),('d','e')])

nx.draw(G)
plt.show()