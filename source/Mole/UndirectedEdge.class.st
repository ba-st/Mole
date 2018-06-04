"
I'm an undirected edge, represented as the set of my vertices.
"
Class {
	#name : #UndirectedEdge,
	#superclass : #Edge,
	#instVars : [
		'relatedVertices'
	],
	#category : #Mole
}

{ #category : #'instance creation' }
UndirectedEdge class >> relating: aVertexCollection [

	^ self new intializeRelating: aVertexCollection asSet
]

{ #category : #comparing }
UndirectedEdge >> = anObject [

	^ self class = anObject class and: [ relatedVertices = anObject relatedVertices ]
]

{ #category : #comparing }
UndirectedEdge >> hash [

	^ relatedVertices hash
]

{ #category : #initialization }
UndirectedEdge >> intializeRelating: aVertexCollection [

	relatedVertices := aVertexCollection
]

{ #category : #testing }
UndirectedEdge >> isDirected [

	^ false
]

{ #category : #testing }
UndirectedEdge >> isIncidentTo: aVertex [

	^ relatedVertices includes: aVertex
]

{ #category : #printing }
UndirectedEdge >> printOn: aStream [

	aStream nextPut: ${.
	relatedVertices
		do: [ :vertex | aStream print: vertex ]
		separatedBy: [ aStream
				nextPut: $,;
				space ].
	aStream nextPut: $}
]

{ #category : #private }
UndirectedEdge >> relatedVertices [

	^ relatedVertices
]
