Class {
	#name : #EdgeTest,
	#superclass : #TestCase,
	#category : #'Mole-Tests'
}

{ #category : #test }
EdgeTest >> testAccessing [

	| edge |
	
	edge := Edge from: 1 to: 2.
	self assert: edge source = 1 description: 'source'.
	self assert: edge target = 2 description: 'target'
]

{ #category : #test }
EdgeTest >> testConverging [

	| edge |
	
	edge := Edge from: 1 to: 2.
	self assert: (edge convergesTo: 2).
	self deny: (edge convergesTo: 1).
	self deny: (edge convergesTo: 3)

]

{ #category : #test }
EdgeTest >> testEqual [

	self assert: (Edge from: 1 to: 2) = (Edge from:1 to:2).
	self deny: (Edge from: 1 to: 2) = (Edge from:2 to:1)

]

{ #category : #test }
EdgeTest >> testGoing [

	| edge |
	
	edge := Edge from: 1 to: 2.
	self assert: (edge goesFrom: 1 to: 2).
	self deny: (edge goesFrom: 2 to: 1).
	self deny: (edge goesFrom: 1 to: 3)
]

{ #category : #test }
EdgeTest >> testHash [

	self assert: (Edge from: 1 to: 2) = (Edge from:1 to:2).
	self assert: (Edge from: 1 to: 2) hash =( Edge from:1 to:2) hash
]

{ #category : #test }
EdgeTest >> testIsIncidentTo [

	| edge |

	edge := Edge from: 'a' to: 'b'.

	self
		assert: (edge isIncidentTo: 'a');
		assert: (edge isIncidentTo: 'b');
		deny: (edge isIncidentTo: 'c')
]

{ #category : #test }
EdgeTest >> testPrintString [

	self assert: (Edge from: 1 to: 2) printString = '1 -> 2'

]

{ #category : #test }
EdgeTest >> testStarting [

	| edge |
	
	edge := Edge from: 1 to: 2.
	self assert: (edge startsOn: 1 ).
	self deny: (edge startsOn: 2).
	self deny: (edge startsOn: 0)
]
