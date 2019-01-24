"
I'm a test case for BreadthFirstTraversal
"
Class {
	#name : #BreadthFirstTraversalTest,
	#superclass : #GraphTraversalAlgorithmTest,
	#category : #'Mole-Tests-Traversal'
}

{ #category : #private }
BreadthFirstTraversalTest >> graphTraversalAlgorithm [

	^ BreadthFirstTraversal new
]

{ #category : #tests }
BreadthFirstTraversalTest >> testTraverseDirectedGraph [

	| graph |

	graph := self directedGraph.
	
	self assertTraversing: graph from: 0 visitsInOrder: #(0 1 3 4 2)
]

{ #category : #tests }
BreadthFirstTraversalTest >> testTraverseDirectedTree [

	| graph |

	graph := self directedTree.
	
	self assertTraversing: graph from: 0 visitsInOrder: #(0 1 2 4 3 5)
]

{ #category : #tests }
BreadthFirstTraversalTest >> testTraverseDisconnectedDirectedGraph [ 
	
	| graph | 
	
	graph := self disconnectedDirectedGraph. 
	
	self assertTraversing: graph from: 1 visitsInOrder: #(1 2 3).
	self assertTraversing: graph from: 4 visitsInOrder: #(4 5).
	self assertTraversing: graph from: 7 visitsInOrder: #(7). 
]

{ #category : #tests }
BreadthFirstTraversalTest >> testTraverseDisconnectedUndirectedGraph [ 
	
	| graph | 
	
	graph := self disconnectedUndirectedGraph. 
	
	self assertTraversing: graph from: 1 visitsInOrder: #(1 2 3).
	self assertTraversing: graph from: 4 visitsInOrder: #(4 5 6).
	self assertTraversing: graph from: 7 visitsInOrder: #(7). 
]

{ #category : #tests }
BreadthFirstTraversalTest >> testTraverseGraphFromNotIncludedVertex [

	| graph |

	graph := self directedTree.
	
	self assertTraversing: graph from: 99 visitsInOrder: #()
]

{ #category : #tests }
BreadthFirstTraversalTest >> testTraverseUndirectedGraph [

	| graph |

	graph := self undirectedGraph.
	
	self assertTraversing: graph from: 0 visitsInOrder: #(0 1 2 3 4)
]
