"
I'm a directed edge. I connect one vertex to another in a graph.
"
Class {
	#name : #DirectedEdge,
	#superclass : #Edge,
	#instVars : [
		'source',
		'target'
	],
	#category : #Mole
}

{ #category : #'instance creation' }
DirectedEdge class >> from: from to: to [ 
	
	^self new initializeWithFrom: from to: to
]

{ #category : #comparing }
DirectedEdge >> = anObject [

	^ self class = anObject class and: [ anObject goesFrom: source to: target ]
]

{ #category : #testing }
DirectedEdge >> convergesTo: anObject [

	^target = anObject
]

{ #category : #testing }
DirectedEdge >> goesFrom: aSourceVertex to: aTargetVertex [

	^ (self startsOn: aSourceVertex) and: [ self convergesTo: aTargetVertex ]
]

{ #category : #comparing }
DirectedEdge >> hash [

	^source hash bitXor: target hash
]

{ #category : #initialization }
DirectedEdge >> initializeWithFrom: from to: to [ 

	source := from.
	target := to
]

{ #category : #testing }
DirectedEdge >> isDirected [

	^ true
]

{ #category : #testing }
DirectedEdge >> isIncidentTo: aVertex [

	^ (self startsOn: aVertex) or: [ self convergesTo: aVertex ]
]

{ #category : #printing }
DirectedEdge >> printOn: aStream [

	source printOn: aStream.
	aStream nextPutAll: ' -> '.
	target printOn: aStream
]

{ #category : #private }
DirectedEdge >> relatedVertices [

	^ {source. target} asSet
]

{ #category : #accessing }
DirectedEdge >> source [

	^source
]

{ #category : #testing }
DirectedEdge >> startsOn: anObject [

	^source = anObject
]

{ #category : #accessing }
DirectedEdge >> target [

	^target
]
