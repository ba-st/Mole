Class {
	#name : #EdgeInterface,
	#superclass : #Object,
	#category : #Mole
}

{ #category : #testing }
EdgeInterface >> convergesTo: anObject [

	self subclassResponsibility
]

{ #category : #testing }
EdgeInterface >> convergesToSelf [

	self subclassResponsibility
]

{ #category : #testing }
EdgeInterface >> goesFrom: aSource to: aTarget [

	self subclassResponsibility
]

{ #category : #accessing }
EdgeInterface >> source [

	self subclassResponsibility
]

{ #category : #testing }
EdgeInterface >> startsOn: anObject [

	self subclassResponsibility
]

{ #category : #accessing }
EdgeInterface >> target [

	self subclassResponsibility
]
