"
I'm a test case for UndirectedEdge
"
Class {
	#name : #UndirectedEdgeTest,
	#superclass : #TestCase,
	#category : #'Mole-Tests'
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
		deny: edge hash = differentEdge hash
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
UndirectedEdgeTest >> testPrintOn [

	self
		assert: (#('{1, 2}' '{2, 1}') includes: (UndirectedEdge relating: #(1 2)) printString);
		assert: (UndirectedEdge relating: #(1)) printString equals: '{1}'
]

{ #category : #tests }
UndirectedEdgeTest >> testRelating [

	self
		should: [ UndirectedEdge relating: #() ]
		raise: InstanceCreationFailed
		withExceptionDo: [ :exception | 
			self
				assert: exception messageText
				equals: 'Undirected edges can only be self-loops or connect exactly 2 vertices' ].

	self
		should: [ UndirectedEdge relating: #(1 2 3) ]
		raise: InstanceCreationFailed
		withExceptionDo: [ :exception | 
			self
				assert: exception messageText
				equals: 'Undirected edges can only be self-loops or connect exactly 2 vertices' ]
]
