"
I'm a test case for DepthFirstTraversal
"
Class {
	#name : #DepthFirstTraversalTest,
	#superclass : #GraphTraversalAlgorithmTest,
	#category : #'Mole-Tests-Traversal'
}

{ #category : #private }
DepthFirstTraversalTest >> graphTraversalAlgorithm [

	^ DepthFirstTraversal new
]

{ #category : #private }
DepthFirstTraversalTest >> testTraverseDirectedGraph [

	| graph |

	graph := self directedGraph.
	
	self assertTraversing: graph from: 0 visitsInOrder: #(0 1 3 4 2)
]

{ #category : #tests }
DepthFirstTraversalTest >> testTraverseDirectedTree [

	| graph |

	graph := self directedTree.
	
	self assertTraversing: graph from: 0 visitsInOrder: #(0 1 2 3 4 5)
]

{ #category : #private }
DepthFirstTraversalTest >> testTraverseDisconnectedDirectedGraph [ 
	
	| graph | 
	
	graph := self disconnectedDirectedGraph. 

	self assertTraversing: graph from: 1 visitsInOrder: #(1 2 3).
	self assertTraversing: graph from: 4 visitsInOrder: #(4 5).
	self assertTraversing: graph from: 7 visitsInOrder: #(7). 
]

{ #category : #private }
DepthFirstTraversalTest >> testTraverseDisconnectedUndirectedGraph [ 
	
	| graph | 
	
	graph := self disconnectedUndirectedGraph. 
	
	self assertTraversing: graph from: 1 visitsInOrder: #(1 2 3).
	self assertTraversing: graph from: 4 visitsInOrder: #(4 5 6).
	self assertTraversing: graph from: 7 visitsInOrder: #(7). 
]

{ #category : #private }
DepthFirstTraversalTest >> testTraverseGraphFromNotIncludedVertex [

	| graph |

	graph := self directedTree.
	
	self assertTraversing: graph from: 99 visitsInOrder: #()
]

{ #category : #private }
DepthFirstTraversalTest >> testTraverseUndirectedGraph [

	| graph |

	graph := self undirectedGraph.
	
	self assertTraversing: graph from: 0 visitsInOrder: #(0 1 2 4 3).
]
