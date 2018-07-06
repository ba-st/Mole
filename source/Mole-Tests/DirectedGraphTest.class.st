"
I'm a test case for DirectedGraph
"
Class {
	#name : #DirectedGraphTest,
	#superclass : #GraphTest,
	#category : #'Mole-Tests'
}

{ #category : #private }
DirectedGraphTest >> cyclicGraph [

	^ self graphBuilder
		addVertex: 1;
		connect: 2 to: 3;
		connect: 3 to: 4;
		connect: 3 to: 6;
		connect: 4 to: 2;
		buildDirected
]

{ #category : #private }
DirectedGraphTest >> edgeOfInvalidType [

	^ UndirectedEdge relating: #('a' 'b')
]

{ #category : #private }
DirectedGraphTest >> edgelessGraphWith: vertices [

	^ self graphBuilder
		addVertices: vertices;
		buildDirected
]

{ #category : #private }
DirectedGraphTest >> graphWithFiveVerticesAndTwoEdges [

	^ self graphBuilder
		connect: 2 to: 3;
		connect: 4 to: 3;
		addVertices: #(1 5);
		buildDirected
]

{ #category : #private }
DirectedGraphTest >> graphWithSelfLoop [

	^ self graphBuilder
		loopOn: 2;
		connect: 3 to: 4;
		connect: 3 to: 5;
		addVertices: #(1);
		buildDirected
]

{ #category : #private }
DirectedGraphTest >> invalidEdge [

	^ DirectedEdge from: 'a' to: 'z'
]

{ #category : #private }
DirectedGraphTest >> labeledGraph [

	^ self graphBuilder
		connect: 1 to: 2 labeled: 'W12';
		connect: 1 to: 3 labeled: 'W13';
		buildDirected
]

{ #category : #'tests - instance creation' }
DirectedGraphTest >> testCreateGraphWithInvalidEdge [

	| vertices edges |

	vertices := #('a' 'b' 'c') asSet.
	edges := Set with: self validEdge with: self invalidEdge.

	self
		should: [ DirectedGraph withVertices: vertices andEdges: edges ]
		raise: InstanceCreationFailed
		withExceptionDo: [ :error | 
			self
				assert: error messageText
				equals: 'Some edge has endpoints not included in the vertices.' ]
]

{ #category : #'tests - instance creation' }
DirectedGraphTest >> testCreateGraphWithInvalidEdgeType [

	| vertices edges |

	vertices := #('a' 'b' 'c') asSet.
	edges := Set with: self edgeOfInvalidType.

	self
		should: [ DirectedGraph withVertices: vertices andEdges: edges ]
		raise: InstanceCreationFailed
		withExceptionDo:
			[ :error | self assert: error messageText equals: 'Some edge is incompatible with this type of graph.' ]
]

{ #category : #'tests - accessing' }
DirectedGraphTest >> testIncomingDegreeOf [

	| vertices graph |

	vertices := #(1 2 3 4).

	graph := self edgelessGraphWith: vertices.

	vertices do: [ :vertex | self assert: (graph incomingDegreeOf: vertex) equals: 0 ].

	graph := self graphWithFiveVerticesAndTwoEdges.

	self
		assert: (graph incomingDegreeOf: 1) equals: 0;
		assert: (graph incomingDegreeOf: 2) equals: 0;
		assert: (graph incomingDegreeOf: 3) equals: 2;
		assert: (graph incomingDegreeOf: 4) equals: 0
]

{ #category : #'tests - testing' }
DirectedGraphTest >> testIsCyclicWhenAcyclic [

	self
		assert: (self edgelessGraphWith: #(1 2 3 4)) isAcyclic;
		deny: (self edgelessGraphWith: #(1 2 3 4)) isCyclic;
		assert: self graphWithFiveVerticesAndTwoEdges isAcyclic;
		deny: self graphWithFiveVerticesAndTwoEdges isCyclic
]

{ #category : #'tests - testing' }
DirectedGraphTest >> testIsCyclicWhenCyclic [

	self
		assert: self cyclicGraph isCyclic;
		deny: self cyclicGraph isAcyclic
]

{ #category : #'tests - instance creation' }
DirectedGraphTest >> testLabeledGraph [

	| graph |

	graph := self labeledGraph.

	self
		assertCollection: (graph neighborsOf: 1) hasSameElements: #(2 3);
		assertCollection: (graph neighborsOf: 2) hasSameElements: #(1);
		assertCollection: (graph neighborsOf: 3) hasSameElements: #(1).

	self
		assertEdgesIncidentTo: 1
			in: graph
			match:
			(Dictionary new
				at: '1 -> 2' put: 'W12';
				at: '1 -> 3' put: 'W13';
				yourself);
		assertEdgesIncidentTo: 2
			in: graph
			match:
			(Dictionary new
				at: '1 -> 2' put: 'W12';
				yourself);
		assertEdgesIncidentTo: 3
			in: graph
			match:
			(Dictionary new
				at: '1 -> 3' put: 'W13';
				yourself)
]

{ #category : #'tests - accessing' }
DirectedGraphTest >> testOutgoingDegreeOf [

	| vertices graph |

	vertices := #(1 2 3 4).

	graph := self edgelessGraphWith: vertices.

	vertices do: [ :vertex | self assert: (graph outgoingDegreeOf: vertex) equals: 0 ].

	graph := self graphWithFiveVerticesAndTwoEdges.

	self
		assert: (graph outgoingDegreeOf: 1) equals: 0;
		assert: (graph outgoingDegreeOf: 2) equals: 1;
		assert: (graph outgoingDegreeOf: 3) equals: 0;
		assert: (graph outgoingDegreeOf: 4) equals: 1
]

{ #category : #'tests - accessing' }
DirectedGraphTest >> testSelfLoops [

	| graph selfLoops |

	graph := self graphBuilder
		connect: 1 to: 2;
		loopOn: 1;
		loopOn: 4;
		buildDirected.

	selfLoops := graph selfLoops.
	self assert: selfLoops size equals: 2.
	selfLoops
		do: [ :selfLoop | self assert: ((selfLoop isIncidentTo: 1) or: [ selfLoop isIncidentTo: 4 ]) ]
]

{ #category : #'tests - topological sort' }
DirectedGraphTest >> testTopologicalSort [

	| graph topologicalOrder validTopologicalOrders |

	graph := self graphBuilder
		addVertex: 1;
		connect: 2 to: 3;
		connect: 3 to: 4;
		connect: 3 to: 6;
		buildDirected..

	topologicalOrder := graph topologicalSort.
	self assert: topologicalOrder size equals: 5.

	validTopologicalOrders := {#(1 2 3 4 6). #(1 2 3 6 4). 	#(2 3 4 6 1). #(2 3 6 4 1)}.

	self assert: (validTopologicalOrders includes: topologicalOrder)
]

{ #category : #'tests - topological sort' }
DirectedGraphTest >> testTopologicalSortFSUExample [

	| graph sort |

	graph := self graphBuilder
		addVertex: 'watch';
		connect: 'undershorts' to: 'pants';
		connect: 'undershorts' to: 'shoes';
		connect: 'pants' to: 'shoes';
		connect: 'pants' to: 'shoes';
		connect: 'pants' to: 'belt';
		connect: 'socks' to: 'shoes';
		connect: 'shirt' to: 'belt';
		connect: 'shirt' to: 'tie';
		connect: 'tie' to: 'jacket';
		buildDirected..

	sort := graph topologicalSort.

	self
		assert: (sort indexOf: 'undershorts') < (sort indexOf: 'pants');
		assert: (sort indexOf: 'undershorts') < (sort indexOf: 'belt');
		assert: (sort indexOf: 'undershorts') < (sort indexOf: 'jacket');
		assert: (sort indexOf: 'undershorts') < (sort indexOf: 'shoes');
		assert: (sort indexOf: 'shirt') < (sort indexOf: 'belt');
		assert: (sort indexOf: 'shirt') < (sort indexOf: 'tie');
		assert: (sort indexOf: 'shirt') < (sort indexOf: 'jacket');
		assert: (sort indexOf: 'pants') < (sort indexOf: 'shoes')
]

{ #category : #'tests - topological sort' }
DirectedGraphTest >> testTopologicalSortFailsWhenTheGraphIsCyclic [

	| cyclicGraph |

	cyclicGraph := self graphBuilder
		addVertex: 1;
		connect: 2 to: 3;
		connect: 3 to: 4;
		connect: 3 to: 6;
		connect: 4 to: 2;
		buildDirected.

	self
		should: [ cyclicGraph topologicalSort ]
		raise: AssertionFailed
		withExceptionDo: [ :error | self assert: error messageText equals: 'Cannot get a topological sort on a cyclic graph.' ]
]

{ #category : #'tests - topological sort' }
DirectedGraphTest >> testTopologicalSortWikipediaExample [

	"Example from http://en.wikipedia.org/wiki/Topological_sorting"

	| graph expectedResults |

	graph := self graphBuilder
		connect: 7 to: 11;
		connect: 7 to: 8;
		connect: 11 to: 2;
		connect: 11 to: 9;
		connect: 11 to: 10;
		connect: 5 to: 11;
		connect: 3 to: 8;
		connect: 3 to: 10;
		connect: 8 to: 9;
		buildDirected..

	"Anyone of this is a valid topological sort"
	expectedResults := 
		{#(3 5 7 11 8 2 9 10).
		#(7 5 11 2 3 10 8 9).
		#(3 7 8 5 11 10 9 2).
		#(3 7 5 8 11 9 10 2).
		#(3 5 7 8 11 9 2 10).
		#(7 3 5 11 8 9 10 2).
		#(5 7 3 11 8 10 2 9)}.

	self assert: (expectedResults includes: graph topologicalSort)
]

{ #category : #'tests - topological sort' }
DirectedGraphTest >> testTopologicalSortWithoutEdges [

	| graph expectedResults |

	graph := self edgelessGraphWith: #(6 1).
 
	expectedResults := {#(6 1). #(1 6)}.

	self assert: (expectedResults includes: graph topologicalSort)
]

{ #category : #'tests - accessing' }
DirectedGraphTest >> testVerticesReachableFrom [

	| graph vertices |

	graph := self graphBuilder
		connect: 1 to: 2;
		loopOn: 1;
		loopOn: 4;
		buildDirected.

	vertices := graph verticesReachableFrom: 1.
	self
		assert: vertices size equals: 2;
		assert: (vertices includes: 2);
		assert: (vertices includes: 1).

	vertices := graph verticesReachableFrom: 4.
	self
		assert: vertices size equals: 1;
		assert: (vertices includes: 4).

	vertices := graph verticesReachableFrom: 2.
	self assert: vertices isEmpty
]

{ #category : #private }
DirectedGraphTest >> validEdge [

	^ DirectedEdge from: 'a' to: 'b'
]
