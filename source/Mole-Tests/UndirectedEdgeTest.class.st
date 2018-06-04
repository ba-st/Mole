"
I'm a test case for UndirectedEdge
"
Class {
	#name : #UndirectedEdgeTest,
	#superclass : #TestCase,
	#category : #'Mole-Tests'
}

{ #category : #tests }
UndirectedEdgeTest >> testPrintString [

	self
		assert: (#('{1, 2}' '{2, 1}') includes: (UndirectedEdge relating: #(1 2)) printString);
		assert: (UndirectedEdge relating: #(1)) printString equals: '{1}'
]
