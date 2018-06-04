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
		build
]

{ #category : #private }
DirectedGraphTest >> edgeOfInvalidType [

	^ UndirectedEdge relating: #('a' 'b')
]

{ #category : #private }
DirectedGraphTest >> graphBuilder [

	^ DirectedGraphBuilder new
]

{ #category : #private }
DirectedGraphTest >> graphWithFiveVerticesAndTwoEdges [

	^ self graphBuilder
		connect: 2 to: 3;
		connect: 4 to: 3;
		addVertices: #(1 5);
		build
]

{ #category : #private }
DirectedGraphTest >> invalidEdge [

	^ DirectedEdge from: 'a' to: 'z'
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
		connect: 1 to: 1;
		connect: 4 to: 4;
		build.

	selfLoops := graph selfLoops.
	self assert: selfLoops size equals: 2.
	selfLoops do: [ :selfLoop | self assert: ((selfLoop isIncidentTo: 1) or: [ selfLoop isIncidentTo: 4 ]) ]
]

{ #category : #'test - topological sort' }
DirectedGraphTest >> testTopologicalSort [

	| graph topologicalOrder validTopologicalOrders |

	graph := self graphBuilder
		addVertex: 1;
		connect: 2 to: 3;
		connect: 3 to: 4;
		connect: 3 to: 6;
		build.

	topologicalOrder := graph topologicalSort.
	self assert: topologicalOrder size equals: 5.

	validTopologicalOrders := {#(1 2 3 4 6). #(1 2 3 6 4). 	#(2 3 4 6 1). #(2 3 6 4 1)}.

	self assert: (validTopologicalOrders includes: topologicalOrder)
]

{ #category : #'test - topological sort' }
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
		build.

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

{ #category : #'test - topological sort' }
DirectedGraphTest >> testTopologicalSortFailsWhenTheGraphIsCyclic [

	| cyclicGraph |

	cyclicGraph := self graphBuilder
		addVertex: 1;
		connect: 2 to: 3;
		connect: 3 to: 4;
		connect: 3 to: 6;
		connect: 4 to: 2;
		build.

	self
		should: [ cyclicGraph topologicalSort ]
		raise: AssertionFailed
		withExceptionDo: [ :error | self assert: error messageText equals: 'Cannot get a topological sort on a cyclic graph.' ]
]

{ #category : #'test - topological sort' }
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
		build.

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

{ #category : #'test - topological sort' }
DirectedGraphTest >> testTopologicalSortWithoutEdges [

	| graph expectedResults |

	graph := self edgelessGraphWith: #(6 1).
 
	expectedResults := {#(6 1). #(1 6)}.

	self assert: (expectedResults includes: graph topologicalSort)
]

{ #category : #private }
DirectedGraphTest >> validEdge [

	^ DirectedEdge from: 'a' to: 'b'
]
