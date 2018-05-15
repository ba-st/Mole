Class {
	#name : #Edge,
	#superclass : #EdgeInterface,
	#instVars : [
		'source',
		'target'
	],
	#category : #Mole
}

{ #category : #'instance creation' }
Edge class >> from: from to: to [ 
	
	^self new initializeWithFrom: from to: to
]

{ #category : #comparing }
Edge >> = anotherEdge [

	^self class = anotherEdge class 
		ifTrue: [ source = anotherEdge source and: [ target = anotherEdge target ]]
		ifFalse: [ false ]
]

{ #category : #testing }
Edge >> convergesTo: anObject [

	^target = anObject
]

{ #category : #testing }
Edge >> convergesToSelf [
	
	^source = target
]

{ #category : #testing }
Edge >> goesFrom: aSource to: aTarget [

	^source = aSource and: [ target = aTarget ]
]

{ #category : #accessing }
Edge >> hash [

	^source hash bitXor: target hash
]

{ #category : #initialization }
Edge >> initializeWithFrom: from to: to [ 

	source := from.
	target := to
]

{ #category : #testing }
Edge >> isIncidentTo: anObject [

	^source = anObject or: [target = anObject]


]

{ #category : #printing }
Edge >> printOn: aStream [

	source printOn: aStream.
	aStream nextPutAll: ' -> '.
	target printOn: aStream
]

{ #category : #accessing }
Edge >> source [

	^source
]

{ #category : #testing }
Edge >> startsOn: anObject [

	^source = anObject
]

{ #category : #accessing }
Edge >> target [

	^target
]
