"
I'm a test case for DirectedEdge
"
Class {
	#name : #DirectedEdgeTest,
	#superclass : #TestCase,
	#category : #'Mole-Tests-Graph'
}

{ #category : #tests }
DirectedEdgeTest >> testConvergesTo [

	| edge |

	edge := DirectedEdge from: 1 to: 2.
	
	self
		assert: (edge convergesTo: 2);
		deny: (edge convergesTo: 1);
		deny: (edge convergesTo: 3)
]

{ #category : #tests }
DirectedEdgeTest >> testEquals [

	| edge equivalentEdge differentEdge |

	edge := DirectedEdge from: 1 to: 2.
	equivalentEdge := DirectedEdge from: 1 to: 2.
	differentEdge := DirectedEdge from: 2 to: 1.
	self
		assert: edge equals: edge;
		assert: edge equals: equivalentEdge;
		assert: equivalentEdge equals: edge;
		deny: edge equals: differentEdge;
		deny: differentEdge equals: edge.

	edge := DirectedEdge from: 1 to: 2 labeled: 'Some labeling object'.
	equivalentEdge := DirectedEdge from: 1 to: 2 labeled: 'Some labeling object'.
	differentEdge := DirectedEdge from: 1 to: 2 labeled: 'A different labeling object'.
	self
		assert: edge equals: edge;
		assert: edge equals: equivalentEdge;
		assert: equivalentEdge equals: edge;
		deny: edge equals: differentEdge;
		deny: differentEdge equals: edge
]

{ #category : #tests }
DirectedEdgeTest >> testFromTo [

	| edge isUnlabeled |

	edge := DirectedEdge from: 1 to: 2.
	isUnlabeled := false.
	self
		assert: edge source equals: 1;
		assert: edge target equals: 2.

	edge withLabelDo: [ :label | self fail ] ifUnlabeled: [ isUnlabeled := true ].
	self assert: isUnlabeled
]

{ #category : #tests }
DirectedEdgeTest >> testFromToLabeled [

	| edge |

	edge := DirectedEdge
		from: 1
		to: 2
		labeled: 'I could be a complext function, it''s not just for text'.
	self
		assert: edge source equals: 1;
		assert: edge target equals: 2.

	edge
		withLabelDo:
			[ :label | self assert: label equals: 'I could be a complext function, it''s not just for text' ]
		ifUnlabeled: [ self fail ]
]

{ #category : #tests }
DirectedEdgeTest >> testGoesFromTo [

	| edge |

	edge := DirectedEdge from: 1 to: 2.

	self
		assert: (edge goesFrom: 1 to: 2);
		deny: (edge goesFrom: 2 to: 1);
		deny: (edge goesFrom: 1 to: 3);
		deny: (edge goesFrom: 3 to: 2)
]

{ #category : #tests }
DirectedEdgeTest >> testHash [

	| edge equivalentEdge differentEdge |

	edge := DirectedEdge from: 1 to: 2.
	equivalentEdge := DirectedEdge from: 1 to: 2.
	differentEdge := DirectedEdge from: 1 to: 3.
	self
		assert: edge hash equals: equivalentEdge hash;
		deny: edge hash equals: differentEdge hash.

	edge := DirectedEdge from: 1 to: 2 labeled: 'Some labeling object'.
	equivalentEdge := DirectedEdge from: 1 to: 2 labeled: 'A different labeling object'.
	differentEdge := DirectedEdge from: 1 to: 3 labeled: 'A different labeling object'.
	self
		assert: edge hash equals: equivalentEdge hash;
		deny: edge hash equals: differentEdge hash
]

{ #category : #tests }
DirectedEdgeTest >> testIsDirected [

	self assert: (DirectedEdge from: 1 to: 2) isDirected
]

{ #category : #tests }
DirectedEdgeTest >> testIsIncidentTo [

	| edge |

	edge := DirectedEdge from: 1 to: 2.

	self
		assert: (edge isIncidentTo: 1);
		assert: (edge isIncidentTo: 2);
		deny: (edge isIncidentTo: 3)
]

{ #category : #tests }
DirectedEdgeTest >> testIsSelfLoop [

	self deny: (DirectedEdge from: 1 to: 2) isSelfLoop.

	self assert: (DirectedEdge from: 1 to: 1) isSelfLoop
]

{ #category : #tests }
DirectedEdgeTest >> testPrintOn [

	self
		assert: (DirectedEdge from: 1 to: 2) printString equals: '1 -> 2';
		assert: (DirectedEdge from: 1 to: 1) printString equals: '1 -> 1'
]

{ #category : #tests }
DirectedEdgeTest >> testSource [

	self assert: (DirectedEdge from: 1 to: 2) source equals: 1
]

{ #category : #tests }
DirectedEdgeTest >> testStartsOn [

	| edge |

	edge := DirectedEdge from: 1 to: 2.
	
	self
		assert: (edge startsOn: 1);
		deny: (edge startsOn: 2);
		deny: (edge startsOn: 3)
]

{ #category : #tests }
DirectedEdgeTest >> testTarget [

	self assert: (DirectedEdge from: 1 to: 2) target equals: 2
]

{ #category : #tests }
DirectedEdgeTest >> testWithLabelDoIfUnlabeled [

	| edges contents edgeFunction |

	contents := String
		streamContents: [ :stream | 
			edgeFunction := [ :source :target | 
			stream
				nextPutAll: ( 'From <1s> to <2s>' expandMacrosWith: source with: target );
				cr
			].
			edges := OrderedCollection new
				add: ( DirectedEdge from: 'Home' to: 'Work' labeled: edgeFunction );
				add: ( DirectedEdge from: 'Work' to: 'Party' labeled: edgeFunction );
				yourself.

			edges
				do: [ :edge | 
					edge
						withLabelDo: [ :function | function value: edge source value: edge target ]
						ifUnlabeled: [ self fail ]
					]
			].
	self
		assert: contents
		equals:
			'From Home to Work
From Work to Party
'
]
