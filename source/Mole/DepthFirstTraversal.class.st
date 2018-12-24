"
I'm the implementation of the DFS traversal algorithm; this technique visits the child vertices before visiting the sibling vertices.

The algorithm begins with a chosen ""root"" vertex; it then iteratively transitions from the current vertex to an adjacent, unvisited vertex, until it can no longer find an unexplored vertex to transition to from its current location. The algorithm then backtracks along previously visited vertices, until it finds a vertex connected to yet more uncharted territory. It will then proceed down the new path as it had before, backtracking as it encounters dead-ends, and ending only when the algorithm has backtracked past the original ""root"" vertex from the very first step.
"
Class {
	#name : #DepthFirstTraversal,
	#superclass : #GraphTraversalAlgorithm,
	#category : #'Mole-Traversal'
}

{ #category : #traverse }
DepthFirstTraversal >> traverse: aGraph from: aSourceVertex doing: aBlock [

	(aGraph includesVertex: aSourceVertex)
		ifTrue: [ aBlock value: aSourceVertex ].

	self traverse: aGraph from: aSourceVertex doing: aBlock havingVisited: OrderedCollection new.
]

{ #category : #'private-traverse' }
DepthFirstTraversal >> traverse: aGraph from: aSourceVertex doing: aBlock havingVisited: aVertexCollection [

	aVertexCollection add: aSourceVertex.
	(aGraph directSuccessorsOf: aSourceVertex) do: [ :neighbor |
		(aVertexCollection includes: neighbor) ifFalse: [
			aBlock value: neighbor.
			self traverse: aGraph from: neighbor doing: aBlock havingVisited: aVertexCollection ] ]
]
