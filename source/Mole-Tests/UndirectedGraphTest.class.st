"
I'm a test case for UndirectedGraph
"
Class {
	#name : #UndirectedGraphTest,
	#superclass : #GraphTest,
	#category : #'Mole-Tests'
}

{ #category : #private }
UndirectedGraphTest >> graphBuilder [

	^ UndirectedGraphBuilder new
]

{ #category : #private }
UndirectedGraphTest >> graphWithFiveVerticesAndTwoEdges [

	^ self graphBuilder
		addVertices: #(1 2 3 4 5);
		relate: 2 to: 3;
		relate: 4 to: 3;
		build
]

{ #category : #tests }
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
		assert: (graph degreeOf: 4) equals: 1
]
