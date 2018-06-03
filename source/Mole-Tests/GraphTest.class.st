"
I'm an abstract test case for Graph behavior
"
Class {
	#name : #GraphTest,
	#superclass : #TestCase,
	#category : #'Mole-Tests'
}

{ #category : #testing }
GraphTest class >> isAbstract [

	^ self name = #GraphTest
]

{ #category : #private }
GraphTest >> edgelessGraphWith: vertices [

	^ self graphBuilder
		addVertices: vertices;
		build
]

{ #category : #private }
GraphTest >> graphBuilder [

	^ self subclassResponsibility
]

{ #category : #private }
GraphTest >> graphWithFiveVerticesAndTwoEdges [

	"G(V,E) / V = {1 2 3 4 5} E = { <2,3> <4,3> }"

	^ self subclassResponsibility
]

{ #category : #'tests - testing' }
GraphTest >> testIncludesVertex [

	| vertices graph |

	vertices := #(1 2 3 4).
	graph := self edgelessGraphWith: vertices.

	vertices do: [ :vertex | self assert: (graph includesVertex: vertex) ].

	self deny: (graph includesVertex: 5)
]

{ #category : #'tests - converting' }
GraphTest >> testNeighborsOf [

	| graph |

	graph := self graphWithFiveVerticesAndTwoEdges.

	self
		assert: (graph neighborsOf: 1) isEmpty;
		assertCollection: (graph neighborsOf: 2) equals: #(3) asSet;
		assertCollection: (graph neighborsOf: 3) equals: #(2 4) asSet;
		assertCollection: (graph neighborsOf: 4) equals: #(3) asSet;
		assert: (graph neighborsOf: 5) isEmpty
]

{ #category : #'tests - accessing' }
GraphTest >> testOrder [

	self
		assert: (self edgelessGraphWith: #()) order equals: 0;
		assert: (self edgelessGraphWith: #(1 2 3 4)) order equals: 4;
		assert: self graphWithFiveVerticesAndTwoEdges order equals: 5
]

{ #category : #'tests - accessing' }
GraphTest >> testSize [

	self
		assert: (self edgelessGraphWith: #()) size equals: 0;
		assert: (self edgelessGraphWith: #(1 2 3 4)) size equals: 0;
		assert: self graphWithFiveVerticesAndTwoEdges size equals: 2
]

{ #category : #'tests - converting' }
GraphTest >> testWithoutVertex [

	| graph newGraph |

	graph := self graphWithFiveVerticesAndTwoEdges.

	self
		assert: graph order equals: 5;
		assert: graph size equals: 2.

	newGraph := graph withoutVertex: 3.
	self
		assert: newGraph order equals: 4;
		assert: newGraph size equals: 0.

	newGraph := graph withoutVertex: 2.
	self
		assert: newGraph order equals: 4;
		assert: newGraph size equals: 1.

	newGraph := graph withoutVertex: 1.
	self
		assert: newGraph order equals: 4;
		assert: newGraph size equals: 2
]
