"
I'm a test case for UndirectedGraph
"
Class {
	#name : #UndirectedGraphTest,
	#superclass : #GraphTest,
	#category : #'Mole-Tests-Graph'
}

{ #category : #private }
UndirectedGraphTest >> edgeOfInvalidType [

	^ DirectedEdge from: 'a' to: 'b'
]

{ #category : #private }
UndirectedGraphTest >> edgelessGraphWith: vertices [

	^ self graphBuilder
		addVertices: vertices;
		buildUndirected
]

{ #category : #private }
UndirectedGraphTest >> graphWithFiveVerticesAndTwoEdges [

	^ self graphBuilder
		connect: 2 to: 3;
		connect: 4 to: 3;
		addVertices: #(1 5);
		buildUndirected
]

{ #category : #private }
UndirectedGraphTest >> graphWithSelfLoop [

	^ self graphBuilder
		loopOn: 2;
		connect: 3 to: 4;
		connect: 3 to: 5;
		addVertices: #(1);
		buildUndirected
]

{ #category : #private }
UndirectedGraphTest >> invalidEdge [

	^ UndirectedEdge relating: #('a' 'z')
]

{ #category : #private }
UndirectedGraphTest >> labeledGraph [

	^ self graphBuilder
		connect: 1 to: 2 labeled: 'W12';
		connect: 1 to: 3 labeled: 'W13';
		loopOn: 4 labeled: 'W44';
		buildUndirected
]

{ #category : #'tests - instance creation' }
UndirectedGraphTest >> testCreateGraphWithInvalidEdge [

	| vertices edges |

	vertices := #('a' 'b' 'c') asSet.
	edges := Set with: self validEdge with: self invalidEdge.

	self
		should: [ UndirectedGraph withVertices: vertices andEdges: edges ]
		raise: InstanceCreationFailed
		withMessageText: 'Some edge has endpoints not included in the vertices.'
]

{ #category : #'tests - instance creation' }
UndirectedGraphTest >> testCreateGraphWithInvalidEdgeType [

	| vertices edges |

	vertices := #('a' 'b' 'c') asSet.
	edges := Set with: self edgeOfInvalidType.

	self
		should: [ UndirectedGraph withVertices: vertices andEdges: edges ]
		raise: InstanceCreationFailed
		withMessageText: 'Some edge is incompatible with this type of graph.'
]

{ #category : #'tests - accessing' }
UndirectedGraphTest >> testDegreeOf [

	| vertices graph |

	vertices := #(1 2 3 4).

	graph := self edgelessGraphWith: vertices.

	vertices do: [ :vertex | self assert: (graph degreeOf: vertex) equals: 0 ].

	graph := self graphWithFiveVerticesAndTwoEdges.

	self
		assert: (graph degreeOf: 1) equals: 0;
		assert: (graph degreeOf: 2) equals: 1;
		assert: (graph degreeOf: 3) equals: 2;
		assert: (graph degreeOf: 4) equals: 1.

	graph := self graphBuilder
		loopOn: 1;
		buildUndirected.

	self assert: (graph degreeOf: 1) equals: 2
]

{ #category : #'tests - accessing' }
UndirectedGraphTest >> testDirectSuccessorsOf [

	| graph vertices |

	graph := self graphBuilder
		connect: 1 to: 2;
		loopOn: 1;
		loopOn: 4;
		connect: 2 to: 3;
		buildUndirected.

	vertices := graph directSuccessorsOf: 1.
	self
		assert: vertices size equals: 2;
		assert: (vertices includes: 2);
		assert: (vertices includes: 1).

	vertices := graph directSuccessorsOf: 4.
	self
		assert: vertices size equals: 1;
		assert: (vertices includes: 4).

	vertices := graph directSuccessorsOf: 2.
	self 
		assert: vertices size equals: 2;
		assert: (vertices includes: 3);
		assert: (vertices includes: 1)
]

{ #category : #'tests - accessing' }
UndirectedGraphTest >> testEdgesIncidentTo [

	| graph edges |

	graph := self graphBuilder
		connect: 1 to: 2;
		loopOn: 1;
		loopOn: 4;
		buildUndirected.

	edges := graph edgesIncidentTo: 1.
	self assert: edges size equals: 2
]

{ #category : #'tests - accessing' }
UndirectedGraphTest >> testSelfLoops [

	| graph selfLoops |

	graph := self graphBuilder
		connect: 1 to: 2;
		loopOn: 1;
		loopOn: 4;
		buildUndirected.

	selfLoops := graph selfLoops.
	self assert: selfLoops size equals: 2.
	selfLoops
		do: [ :selfLoop | self assert: ((selfLoop isIncidentTo: 1) or: [ selfLoop isIncidentTo: 4 ]) ]
]

{ #category : #private }
UndirectedGraphTest >> validEdge [

	^ UndirectedEdge relating: #('a' 'b')
]
