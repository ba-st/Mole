"
I'm the implementation of the BFS traversal algorithm; this technique visits the neighbor vertices before visiting the child vertices. It can be used to find the shortest path from one vertex to another.

It starts at the tree root (or some arbitrary node of a graph), and explores all of the neighbor nodes at the present depth prior to moving on to the nodes at the next depth level.
"
Class {
	#name : #BreadthFirstTraversal,
	#superclass : #GraphTraversalAlgorithm,
	#category : #'Mole-Traversal'
}

{ #category : #traverse }
BreadthFirstTraversal >> traverse: aGraph from: aSourceVertex doing: aBlock [

	(aGraph includesVertex: aSourceVertex)
		ifTrue: [ aBlock value: aSourceVertex ].

	self traverse: aGraph from: aSourceVertex doing: aBlock havingVisited: (OrderedCollection with: aSourceVertex).
]

{ #category : #'private-traverse' }
BreadthFirstTraversal >> traverse: aGraph from: aSourceVertex doing: aBlock havingVisited: aVertexCollection [

	| neighborsToVisit |

	neighborsToVisit := (aGraph directSuccessorsOf: aSourceVertex) copyWithoutAll: aVertexCollection.
	aVertexCollection addAll: neighborsToVisit.
	neighborsToVisit do: aBlock; do: [ :neighbor | self traverse: aGraph from: neighbor doing: aBlock havingVisited: aVertexCollection ]

]
