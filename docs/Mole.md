Graphs
======
Mole provides a model for graphs, both directed and undirected, labeled and unlabeled. Graphs in Mole are immutable. A graph consists on a set of vertices and edges connecting them. Any object can be used as a vertex.

Each graph can understand the following messages:

### Accessing

- `neighborsOf: aVertex` Returns the vertices that are connected to `aVertex`
- `order` The number of vertices
- `size` The number of edges

### Converting
- `withoutVertex: aVertex` Returns a new graph excluding the vertex and all it's incident edges
- `withoutVertices: aVertexCollection` Returns a new graph excluding the vertices and all it's incident edges

### Testing
- `includesVertex: aVertex` Returns true if `aVertex` is included in the vertices
- `is: aVertex adjacentTo: anotherVertex` Returns true if exists and edge incident to `aVertex` and `anotherVertex`

## Undirected Graph

Undirected graphs, graphs in which the two endpoints of each edge are not distinguished from each other, are modeled in `UndirectedGraph`.

The easier way to create an undirected graph it's to use the builder: `UndirectedGraphBuilder`.
For example:
```smalltalk
UndirectedGraphBuilder new
  relate: 1 to: 2;
  selfRelate: 1;
  relate: 4 to: 3;
  addVertex: 8;
  build
```
will create an undirected graph with 5 vertices {1, 2, 3, 4, 8} and the following edges: { (1,2), (1,1), (4,3)}. The builder will take care of creating the right type of edge and adding the vertices included in edges automatically.

In addition to the messages common to all graphs, undirected graphs also understand:

- `degreeOf: aVertex`  The degree (or valency) of a vertex is the number of edges incident to the vertex.	A special case is a self loop, which adds two to the degree.
- `edgesIncidentTo: aVertex`

## Directed Graph

Directed graphs, graphs where all the edges are directed from one vertex to another, are modeled in `DirectedGraph`. A directed graph is sometimes called a digraph or a directed network.

The easier way to create an directed graph it's to use the builder: `DirectedGraphBuilder`.
For example:
```smalltalk
DirectedGraphBuilder new
  connect: 1 to: 2;
  connect: 4 to: 3;
  addVertex: 5;
  build
```
will create an directed graph with 5 vertices {1, 2, 3, 4, 5} and the following edges: { 1 -> 2, 4 -> 3}.

In addition to the messages common to all graphs, directed graphs also understand:

### Accessing
- `edgesIncomingTo: aVertex` Returns the edges converging to a vertex.
- `edgesOutgoingFrom: aVertex` Returns the edges starting from a vertex.
- `incomingDegreeOf: aVertex` Returns the number of edges converging to a vertex.
- `outgoingDegreeOf: aVertex` Returns the number of edges starting from a vertex.
- `topologicalSort` If the graph is acyclic returns a topological sort of its vertices. In case the graph is cyclic raises an exception.
- `verticesReachableFrom: aSourceVertex` Returns the vertices that can be reached starting from the source vertex.

### Testing
- `isAcyclic` Returns true if the graph is acyclic
- `isCyclic` Returns true if the graph is cyclic

## Future Work
- Traversal algorithms
- Walks and paths
- Union, difference and intersection
