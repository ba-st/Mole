"
I'm a test case for DepthFirstTraversal
"
Class {
	#name : #DepthFirstTraversalTest,
	#superclass : #GraphTraversalAlgorithmTest,
	#category : #'Mole-Tests-Traversal'
}

{ #category : #private }
DepthFirstTraversalTest >> directedGraphExpectedNodesTraversed [

	^ #(0 1 3 4 2)
]

{ #category : #private }
DepthFirstTraversalTest >> directedTreeExpectedNodesTraversed [

	^ #(0 1 2 3 4 5)
]

{ #category : #private }
DepthFirstTraversalTest >> graphTraversalAlgorithm [

	^ DepthFirstTraversal new
]

{ #category : #private }
DepthFirstTraversalTest >> undirectedGraphExpectedNodesTraversed [

	^ #(0 1 2 4 3)
]
