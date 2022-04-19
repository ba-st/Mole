# Graphs

Mole provides a model for graphs, both directed and undirected, labeled and
unlabeled. Graphs in Mole are immutable. A graph consists of a set of vertices
and edges connecting them. Any object can be used as a vertex.

## All graph types

Each graph can understand the following messages:

### Accessing

- `neighborsOf: aVertex` Returns the vertices that are connected to `aVertex`
- `edgesIncidentTo: aVertex` Returns the edges that are incident to `aVertex`
- `order` The number of vertices
- `size` The number of edges

### Converting

- `withoutVertex: aVertex` Returns a new graph excluding the vertex and all it's
  incident edges
- `withoutVertices: aVertexCollection` Returns a new graph excluding the vertices
  and all it's incident edges

### Testing

- `includesVertex: aVertex` Returns true if `aVertex` is included in the vertices
- `is: aVertex adjacentTo: anotherVertex` Returns true if exists and edge
  incident to `aVertex` and `anotherVertex`

## Undirected Graph

Undirected graphs, graphs in which the two endpoints of each edge are not
distinguished from each other, are modeled in `UndirectedGraph`.

The easier way to create an undirected graph it's to use `GraphBuilder` then
request an undirected graph using `buildUndirected`.

For example:

```smalltalk
GraphBuilder new
  connect: 1 to: 2;
  loopOn: 1;
  connect: 4 to: 3;
  addVertex: 8;
  buildUndirected
```

will create an undirected graph with 5 vertices `{1, 2, 3, 4, 8}` and the
following edges: `{(1,2), (1,1), (4,3)}`. The builder will take care of creating
the right type of edge and adding the vertices included in the edges automatically.

In addition to the messages common to all graphs, undirected graphs also understand:

- `degreeOf: aVertex`  The degree (or valency) of a vertex is the number of
  edges incident to the vertex. A special case is a self-loop, which adds two
  to the degree.
- `edgesIncidentTo: aVertex`

## Directed Graph

Directed graphs, graphs where all the edges are directed from one vertex to
another, are modeled in `DirectedGraph`. A directed graph is sometimes called a
digraph or a directed network.

The easier way to create a directed graph it's to use `GraphBuilder` then request
a directed graph using `buildDirected`.

For example:

```smalltalk
GraphBuilder new
  connect: 1 to: 2;
  connect: 4 to: 3;
  addVertex: 5;
  buildDirected
```

will create a directed graph with 5 vertices `{1, 2, 3, 4, 5}` and the following
edges: `{ 1 -> 2, 4 -> 3}`.

In addition to the messages common to all graphs, directed graphs also understand:

### Accessing digraphs

- `edgesIncomingTo: aVertex` Returns the edges converging to a vertex.
- `edgesOutgoingFrom: aVertex` Returns the edges starting from a vertex.
- `incomingDegreeOf: aVertex` Returns the number of edges converging to a vertex.
- `outgoingDegreeOf: aVertex` Returns the number of edges starting from a vertex.
- `topologicalSort` If the graph is acyclic returns a topological sort of its
  vertices. In case the graph is cyclic raises an exception.
- `verticesReachableFrom: aSourceVertex` Returns the vertices that can be reached
  starting from the source vertex.

### Testing digraphs

- `isAcyclic` Returns true if the graph is acyclic
- `isCyclic` Returns true if the graph is cyclic

## Weights and labels

Edges in both directed and undirected graphs can have additional information
embedded into them. This is generally referred to as `labeling`. A label can be
just a name to identify the edge, a weight to indicate the cost of traversing it
or even complex objects like functions.

To add a label, use the alternative messages in the builder: `connect:to:labeled:`
and `loopOn:labeled:`:

```smalltalk
GraphBuilder new
  connect: 1 to: 2 labeled: 'Simple edge';
  connect: 4 to: 3 labeled: 8;
  loopOn: 3 labeled: [:arguments | self logEdgeMovement: arguments ];
  buildDirected
```

will create a directed graph with and edge `{1 -> 2}` that is named `Simple edge`,
an edge `{4 -> 3}` with weight `8`, and a loop `{4 -> 4}` with a logging function
attached.

To use the information in an edge label, send the message `withLabelDo:ifUnlabeled:`,
for example:

```smalltalk
"Write information from the graph to aStream"
anEdge withLabelDo: [:name | aStream nextPutAll: name ]
       ifUnlabeled: [ aStream nextPutAll: 'N/A']

"Sum the distances represented by the weights in a path"
anEdge withLabelDo: [:weight | totalDistance := totalDistance + weight ]
       ifUnlabeled: [ ]

"Evaluate a function related to the edge traversed"
anEdge withLabelDo: [:function | function value: evaluationContext ]
       ifUnlabeled: [ Error signal: 'All edges are expected to have a function']
```

## Traversing

The traversing algorithm refers to the process of visiting each reachable vertex
of a (directed or undirected) graph from a source vertex. The two most well-known
algorithms are `Depth-First Search` and `Breadth-First Search`.

![BFS vs DFS](dfsbfs.gif)

To traverse a graph using any of these methods just write:

```smalltalk
BreadthFirstTraversal new
  traverse: aGraph from: aSourceVertex
  doing: [ :visitedVertex | path add: visitedVertex ]
DepthFirstTraversal new
  traverse: aGraph from: aSourceVertex
  doing: [ :visitedVertex | path add: visitedVertex ]
```

## Future Work

- Walks and paths
- Union, difference, and intersection
