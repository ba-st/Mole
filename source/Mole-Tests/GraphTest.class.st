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
GraphTest >> assertEdgesIncidentTo: aVertex in: aGraph match: aDictionary [

	| labelByEdge edges |

	labelByEdge := Dictionary new.
	edges := aGraph edgesIncidentTo: aVertex.
	edges
		do: [ :edge | 
			edge
				withLabelDo: [ :label | labelByEdge at: edge endpoints sorted asString put: label ]
				ifUnlabeled: [ self fail ] ].
	self assertCollection: labelByEdge keys hasSameElements: aDictionary keys.
	aDictionary
		keysAndValuesDo: [ :edgeString :weight | self assert: (labelByEdge at: edgeString) equals: weight ]
]

{ #category : #private }
GraphTest >> edgelessGraphWith: vertices [

	self subclassResponsibility
]

{ #category : #private }
GraphTest >> graphBuilder [

	^ GraphBuilder new
]

{ #category : #private }
GraphTest >> graphWithFiveVerticesAndTwoEdges [

	"G(V,E) / V = {1 2 3 4 5} E = { <2,3> <4,3> }"

	self subclassResponsibility
]

{ #category : #private }
GraphTest >> graphWithSelfLoop [

	"G(V,E) / V = {1 2 3} E = { <2,2> <3,4> <3,5> }"

	self subclassResponsibility
]

{ #category : #private }
GraphTest >> labeledGraph [

	self subclassResponsibility
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
GraphTest >> testIsAdjacentTo [

	| graph |

	graph := self graphWithFiveVerticesAndTwoEdges.

	self
		deny: (graph is: 1 adjacentTo: 1);
		deny: (graph is: 1 adjacentTo: 2);
		assert: (graph is: 2 adjacentTo: 3);
		assert: (graph is: 3 adjacentTo: 2);
		assert: (graph is: 3 adjacentTo: 4)
]

{ #category : #'tests - instance creation' }
GraphTest >> testLabeledGraph [

	| graph |

	graph := self labeledGraph.

	self
		assertCollection: graph vertices hasSameElements: #(1 2 3 4);
		assertCollection: (graph neighborsOf: 1) hasSameElements: #(2 3);
		assertCollection: (graph neighborsOf: 2) hasSameElements: #(1);
		assertCollection: (graph neighborsOf: 3) hasSameElements: #(1);
		assertCollection: (graph neighborsOf: 4) hasSameElements: #(4).

	self
		assertEdgesIncidentTo: 1
			in: graph
			match:
			(Dictionary new
				at: '#(1 2)' put: 'W12';
				at: '#(1 3)' put: 'W13';
				yourself);
		assertEdgesIncidentTo: 2
			in: graph
			match:
			(Dictionary new
				at: '#(1 2)' put: 'W12';
				yourself);
		assertEdgesIncidentTo: 3
			in: graph
			match:
			(Dictionary new
				at: '#(1 3)' put: 'W13';
				yourself);
		assertEdgesIncidentTo: 4
			in: graph
			match:
			(Dictionary new
				at: '#(4 4)' put: 'W44';
				yourself)
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

{ #category : #'tests - converting' }
GraphTest >> testNeighborsOfForVertexWithSelfLoop [

	| graph |

	graph := self graphWithSelfLoop.

	self
		assert: (graph neighborsOf: 1) isEmpty;
		assertCollection: (graph neighborsOf: 2) equals: #(2) asSet;
		assertCollection: (graph neighborsOf: 3) equals: #(4 5) asSet;
		assertCollection: (graph neighborsOf: 4) equals: #(3) asSet;
		assertCollection: (graph neighborsOf: 5) equals: #(3) asSet
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

{ #category : #'tests - converting' }
GraphTest >> testWithoutVertices [

	| graph newGraph |

	graph := self graphWithFiveVerticesAndTwoEdges.

	newGraph := graph withoutVertices: #(3 5).
	self
		assert: newGraph order equals: 3;
		assert: newGraph size equals: 0.

	newGraph := graph withoutVertices: #(2 1 5).
	self
		assert: newGraph order equals: 2;
		assert: newGraph size equals: 1
]
