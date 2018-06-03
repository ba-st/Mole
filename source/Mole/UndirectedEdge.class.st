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

{ #category : #private }
UndirectedEdge >> relatedVertices [

	^ relatedVertices
]
