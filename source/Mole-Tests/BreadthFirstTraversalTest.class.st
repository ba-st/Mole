"
I'm a test case for BreadthFirstTraversal
"
Class {
	#name : #BreadthFirstTraversalTest,
	#superclass : #GraphTraversalAlgorithmTest,
	#category : #'Mole-Tests-Traversal'
}

{ #category : #private }
BreadthFirstTraversalTest >> directedGraphExpectedNodesTraversed [

	^ #(0 1 3 4 2)
]

{ #category : #private }
BreadthFirstTraversalTest >> directedTreeExpectedNodesTraversed [

	^ #(0 1 2 4 3 5)
]

{ #category : #private }
BreadthFirstTraversalTest >> graphTraversalAlgorithm [

	^ BreadthFirstTraversal new
]

{ #category : #private }
BreadthFirstTraversalTest >> undirectedGraphExpectedNodesTraversed [

	^ #(0 1 2 3 4)
]
