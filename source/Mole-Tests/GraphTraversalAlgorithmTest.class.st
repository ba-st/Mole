"
I'm an abstract test case for GraphTraversalAlgorithmTest
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

{ #category : #assertions }
GraphTraversalAlgorithmTest >> assertTraversing: aGraph from: aSourceVertex visitsInOrder: aVertexCollection [ 
	
	| path | 
	
	path := OrderedCollection new. 
	self graphTraversalAlgorithm traverse: aGraph from: aSourceVertex doing: [ :node | path add: node ].
	self assert: path asArray equals: aVertexCollection.
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
GraphTraversalAlgorithmTest >> disconnectedDirectedGraph [

	^ self graphBuilder
		connect: 1 to: 2;
		connect: 1 to: 3;
		connect: 3 to: 2;
		connect: 6 to: 4;
		connect: 4 to: 5;
		loopOn: 7;
		buildDirected
]

{ #category : #private }
GraphTraversalAlgorithmTest >> disconnectedUndirectedGraph [

	^ self graphBuilder
		connect: 1 to: 2;
		connect: 1 to: 3;
		connect: 3 to: 2;
		connect: 6 to: 4;
		connect: 4 to: 5;
		loopOn: 7;
		buildUndirected
]

{ #category : #private }
GraphTraversalAlgorithmTest >> graphBuilder [

	^ GraphBuilder new
]

{ #category : #private }
GraphTraversalAlgorithmTest >> graphTraversalAlgorithm [

	^ self subclassResponsibility
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
