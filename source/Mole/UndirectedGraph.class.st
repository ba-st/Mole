"
I'm an undirected graph, a graph in which the two endpoints of each edge are not distinguished from each other.
"
Class {
	#name : #UndirectedGraph,
	#superclass : #Graph,
	#instVars : [
		'vertices',
		'edges'
	],
	#category : #Mole
}

{ #category : #'Instance creation' }
UndirectedGraph class >> withVertices: aVertexCollection andEdges: anEdgeCollection [

	^ self new initializeWithVertices: aVertexCollection asSet andEdges: anEdgeCollection asSet
]

{ #category : #accessing }
UndirectedGraph >> degreeOf: aVertex [

	"The degree (or valency) of a vertex is the number of edges incident to the vertex"

	^ edges count: [ :edge | edge isIncidentTo: aVertex ]
]

{ #category : #'private - accessing' }
UndirectedGraph >> edges [

	^ edges
]

{ #category : #initialization }
UndirectedGraph >> initializeWithVertices: aVertexCollection andEdges: anEdgeCollection [

	vertices := aVertexCollection.
	edges := anEdgeCollection
]

{ #category : #'private - accessing' }
UndirectedGraph >> vertices [

	^ vertices
]
