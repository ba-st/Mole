"
I'm a test case for DirectedEdge
"
Class {
	#name : #DirectedEdgeTest,
	#superclass : #TestCase,
	#category : #'Mole-Tests'
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
		deny: edge = differentEdge;
		deny: differentEdge = edge
]

{ #category : #tests }
DirectedEdgeTest >> testFromTo [

	| edge |

	edge := DirectedEdge from: 1 to: 2.
	self
		assert: edge source equals: 1;
		assert: edge target equals: 2
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
		deny: edge hash = differentEdge hash
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
