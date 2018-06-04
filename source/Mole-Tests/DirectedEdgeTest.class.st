"
I'm a test case for DirectedEdge
"
Class {
	#name : #DirectedEdgeTest,
	#superclass : #TestCase,
	#category : #'Mole-Tests'
}

{ #category : #tests }
DirectedEdgeTest >> testAccessing [

	self
		assert: (DirectedEdge from: 1 to: 2) source equals: 1;
		assert: (DirectedEdge from: 1 to: 2) target equals: 2
]

{ #category : #tests }
DirectedEdgeTest >> testComparing [

	self
		assert: (DirectedEdge from: 1 to: 2) equals: (DirectedEdge from: 1 to: 2);
		assert: (DirectedEdge from: 1 to: 2) hash equals: (DirectedEdge from: 1 to: 2) hash;
		deny: (DirectedEdge from: 1 to: 2) equals: (DirectedEdge from: 2 to: 1)
]

{ #category : #tests }
DirectedEdgeTest >> testPrintString [

	self assert: (DirectedEdge from: 1 to: 2) printString equals: '1 -> 2'
]
