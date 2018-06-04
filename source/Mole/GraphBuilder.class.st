"
I'm an abstract class aiding with the creation of graphs.
"
Class {
	#name : #GraphBuilder,
	#superclass : #Object,
	#category : #Mole
}

{ #category : #adding }
GraphBuilder >> addVertex: aVertex [

	self subclassResponsibility
]

{ #category : #adding }
GraphBuilder >> addVertices: aVertexCollection [

	aVertexCollection do: [ :vertex | self addVertex: vertex ]
]

{ #category : #building }
GraphBuilder >> build [

	^ self subclassResponsibility
]

{ #category : #accessing }
GraphBuilder >> graphClass [

	^ self subclassResponsibility
]
