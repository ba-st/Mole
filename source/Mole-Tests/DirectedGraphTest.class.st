"
I'm a test case for DirectedGraph
"
Class {
	#name : #DirectedGraphTest,
	#superclass : #GraphTest,
	#category : #'Mole-Tests'
}

{ #category : #private }
DirectedGraphTest >> graphBuilder [

	^ DirectedGraphBuilder new
]

{ #category : #private }
DirectedGraphTest >> graphWithFiveVerticesAndTwoEdges [

	^ self graphBuilder
		addVertices: #(1 2 3 4 5);
		connect: 2 to: 3;
		connect: 4 to: 3;
		build
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
