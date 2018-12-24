"
I'm an abstract test case for GraphShortestPathWalker
"
Class {
	#name : #GraphTraversalAlgorithmTest,
	#superclass : #TestCase,
	#category : #'Mole-Tests-Traversal'
}

{ #category : #testing }
GraphTraversalAlgorithmTest class >> isAbstract [

	^ self name = #GraphTraversalAlgorithmTest
]

{ #category : #private }
GraphTraversalAlgorithmTest >> directedGraph [

	^ self graphBuilder
		connect: 0 to: 1;
		connect: 0 to: 3;
		connect: 2 to: 0;
		connect: 3 to: 4;
		connect: 2 to: 1;
		connect: 4 to: 2;
		buildDirected
]

{ #category : #private }
GraphTraversalAlgorithmTest >> directedGraphExpectedNodesTraversed [

	self subclassResponsibility
]

{ #category : #private }
GraphTraversalAlgorithmTest >> directedTree [

	^ self graphBuilder
		connect: 0 to: 1;
		connect: 0 to: 2;
		connect: 1 to: 2;
		connect: 1 to: 3;
		connect: 0 to: 4;
		connect: 4 to: 5;
		buildDirected
]

{ #category : #private }
GraphTraversalAlgorithmTest >> directedTreeExpectedNodesTraversed [

	^ self subclassResponsibility
]

{ #category : #private }
GraphTraversalAlgorithmTest >> graphBuilder [

	^ GraphBuilder new
]

{ #category : #private }
GraphTraversalAlgorithmTest >> graphTraversalAlgorithm [

	^ self subclassResponsibility
]

{ #category : #tests }
GraphTraversalAlgorithmTest >> testTraverseDirectedGraph [

	| graph path |

	graph := self directedGraph.
	path := OrderedCollection new.
	
	self graphTraversalAlgorithm traverse: graph from: 0 doing: [ :node | path add: node ].
	
	self assert: path asArray equals: self directedGraphExpectedNodesTraversed
]

{ #category : #tests }
GraphTraversalAlgorithmTest >> testTraverseDirectedTree [

	| graph path |

	graph := self directedTree.
	path := OrderedCollection new.
	
	self graphTraversalAlgorithm traverse: graph from: 0 doing: [ :node | path add: node ].
	
	self assert: path asArray equals: self directedTreeExpectedNodesTraversed
]

{ #category : #tests }
GraphTraversalAlgorithmTest >> testTraverseUndirectedGraph [

	| graph path |

	graph := self undirectedGraph.
	path := OrderedCollection new.
	
	self graphTraversalAlgorithm traverse: graph from: 0 doing: [ :node | path add: node ].
	
	self assert: path asArray equals: self undirectedGraphExpectedNodesTraversed
]

{ #category : #private }
GraphTraversalAlgorithmTest >> undirectedGraph [

	^ self graphBuilder
		connect: 0 to: 1;
		connect: 0 to: 3;
		connect: 2 to: 0;
		connect: 3 to: 4;
		connect: 2 to: 1;
		connect: 4 to: 2;
		buildUndirected
]

{ #category : #private }
GraphTraversalAlgorithmTest >> undirectedGraphExpectedNodesTraversed [

	self subclassResponsibility
]
