"
I'm a test case for UndirectedEdge
"
Class {
	#name : #UndirectedEdgeTest,
	#superclass : #TestCase,
	#category : #'Mole-Tests-Graph'
}

{ #category : #tests }
UndirectedEdgeTest >> testEquals [

	| edge equivalentEdge differentEdge |

	edge := UndirectedEdge relating: #(1 2).
	equivalentEdge := UndirectedEdge relating: #(2 1).
	differentEdge := UndirectedEdge relating: #(2 3).
	self
		assert: edge equals: edge;
		assert: edge equals: equivalentEdge;
		assert: equivalentEdge equals: edge;
		deny: edge = differentEdge;
		deny: differentEdge = edge.

	edge := UndirectedEdge relating: #(1 2) labeled: 'Some labeling object'.
	equivalentEdge := UndirectedEdge relating: #(2 1) labeled: 'Some labeling object'.
	differentEdge := UndirectedEdge relating: #(1 2) labeled: 'A different labeling object'.
	self
		assert: edge equals: edge;
		assert: edge equals: equivalentEdge;
		assert: equivalentEdge equals: edge;
		deny: edge = differentEdge;
		deny: differentEdge = edge
]

{ #category : #tests }
UndirectedEdgeTest >> testHash [

	| edge equivalentEdge differentEdge |

	edge := UndirectedEdge relating: #(1 2).
	equivalentEdge := UndirectedEdge relating: #(2 1).
	differentEdge := UndirectedEdge relating: #(2 3).
	self
		assert: edge hash equals: equivalentEdge hash;
		deny: edge hash = differentEdge hash.

	edge := UndirectedEdge relating: #(1 2) labeled: 'Some labeling object'.
	equivalentEdge := UndirectedEdge relating: #(2 1) labeled: 'A different labeling object'.
	differentEdge := UndirectedEdge relating: #(1 3) labeled: 'A different labeling object'.
	self
		assert: edge hash equals: equivalentEdge hash;
		deny: edge hash = differentEdge hash
]

{ #category : #tests }
UndirectedEdgeTest >> testInvalidCreation [

	self
		should: [ UndirectedEdge relating: #() ]
		raise: InstanceCreationFailed
		withExceptionDo: [ :exception | 
			self
				assert: exception messageText
				equals: 'Undirected edges must specify exactly 2 vertices' ].

	self
		should: [ UndirectedEdge relating: #(1 2 3) ]
		raise: InstanceCreationFailed
		withExceptionDo: [ :exception | 
			self
				assert: exception messageText
				equals: 'Undirected edges must specify exactly 2 vertices' ]
]

{ #category : #tests }
UndirectedEdgeTest >> testIsDirected [

	self deny: (UndirectedEdge relating: #(1 2)) isDirected
]

{ #category : #tests }
UndirectedEdgeTest >> testIsIncidentTo [

	| edge |

	edge := UndirectedEdge relating: #(1 2).

	self
		assert: (edge isIncidentTo: 1);
		assert: (edge isIncidentTo: 2);
		deny: (edge isIncidentTo: 3)
]

{ #category : #tests }
UndirectedEdgeTest >> testIsSelfLoop [

	self deny: (UndirectedEdge relating: #(1 2)) isSelfLoop.

	self assert: (UndirectedEdge relating: #(1 1)) isSelfLoop
]

{ #category : #tests }
UndirectedEdgeTest >> testPrintOn [

	self
		assert: (#('{1, 2}' '{2, 1}') includes: (UndirectedEdge relating: #(1 2)) printString);
		assert: (UndirectedEdge relating: #(1 1)) printString equals: '{1, 1}'
]

{ #category : #tests }
UndirectedEdgeTest >> testRelating [

	| edge isUnlabeled |

	edge := UndirectedEdge relating: #(1 2).
	isUnlabeled := false.

	edge withLabelDo: [ :label | self fail ] ifUnlabeled: [ isUnlabeled := true ].
	self assert: isUnlabeled
]

{ #category : #tests }
UndirectedEdgeTest >> testRelatingLabeled [

	| edge |

	edge := UndirectedEdge
		relating: #(1 2)
		labeled: 'I could be a complext function, it''s not just for text'.

	edge
		withLabelDo:
			[ :label | self assert: label equals: 'I could be a complext function, it''s not just for text' ]
		ifUnlabeled: [ self fail ]
]

{ #category : #tests }
UndirectedEdgeTest >> testWithLabelDoIfUnlabeled [

	| edges stream edgeFunction |

	stream := WriteStream on: String new.
	edgeFunction := [ :edge | 
	stream
		nextPutAll:
			(edge isSelfLoop
				ifTrue: [ 'LOOP' ]
				ifFalse: [ 'dup' ]) ].
	edges := OrderedCollection new
		add: (UndirectedEdge relating: #(a b) labeled: edgeFunction);
		add: (UndirectedEdge relating: #(b a) labeled: edgeFunction);
		add: (UndirectedEdge relating: #(a a) labeled: edgeFunction);
		add: (UndirectedEdge relating: #(b d) labeled: edgeFunction);
		yourself.

	edges
		do:
			[ :edge | edge withLabelDo: [ :function | function value: edge ] ifUnlabeled: [ self fail ] ].
	self assert: stream contents equals: 'dupdupLOOPdup'
]
