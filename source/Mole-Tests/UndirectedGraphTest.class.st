"
I'm a test case for UndirectedGraph
"
Class {
	#name : #UndirectedGraphTest,
	#superclass : #GraphTest,
	#category : #'Mole-Tests'
}

{ #category : #private }
UndirectedGraphTest >> edgeOfInvalidType [

	^ DirectedEdge from: 'a' to: 'b'
]

{ #category : #private }
UndirectedGraphTest >> graphBuilder [

	^ UndirectedGraphBuilder new
]

{ #category : #private }
UndirectedGraphTest >> graphWithFiveVerticesAndTwoEdges [

	^ self graphBuilder
		relate: 2 to: 3;
		relate: 4 to: 3;
		addVertices: #(1 5);
		build
]

{ #category : #private }
UndirectedGraphTest >> invalidEdge [

	^ UndirectedEdge relating: #('a' 'z')
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
		relate: 1 to: 1;
		build.

	self assert: (graph degreeOf: 1) equals: 2
]

{ #category : #'tests - accessing' }
UndirectedGraphTest >> testEdgesIncidentTo [

	| graph edges |

	graph := self graphBuilder
		relate: 1 to: 2;
		selfRelate: 1;
		selfRelate: 4;
		build.

	edges := graph edgesIncidentTo: 1.
	self assert: edges size equals: 2
]

{ #category : #'tests - accessing' }
UndirectedGraphTest >> testSelfLoops [

	| graph selfLoops |

	graph := self graphBuilder
		relate: 1 to: 2;
		selfRelate: 1;
		selfRelate: 4;
		build.

	selfLoops := graph selfLoops.
	self assert: selfLoops size equals: 2.
	selfLoops do: [ :selfLoop | self assert: ((selfLoop isIncidentTo: 1) or: [ selfLoop isIncidentTo: 4 ]) ]
]

{ #category : #private }
UndirectedGraphTest >> validEdge [

	^ UndirectedEdge relating: #('a' 'b')
]
