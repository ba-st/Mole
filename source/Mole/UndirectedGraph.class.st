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
	#category : #'Mole-Graph'
}

{ #category : #'private - testing' }
UndirectedGraph class >> isCompatible: anEdge [

	^ anEdge isDirected not
]

{ #category : #'Instance creation' }
UndirectedGraph class >> withValidVertices: aVertexCollection andEdges: anEdgeCollection [

	^ self new initializeWithVertices: aVertexCollection asSet andEdges: anEdgeCollection asSet
]

{ #category : #accessing }
UndirectedGraph >> degreeOf: aVertex [

	"The degree (or valency) of a vertex is the number of edges incident to the vertex.
	A special case is a loop, which adds two to the degree."

	^ edges
		inject: 0
		into: [ :sum :edge | 
			(edge isIncidentTo: aVertex)
				ifTrue: [ edge isSelfLoop
						ifTrue: [ sum + 2 ]
						ifFalse: [ sum + 1 ] ]
				ifFalse: [ sum ] ]
]

{ #category : #accessing }
UndirectedGraph >> directSuccessorsOf: aVertex [

	^ (self edgesIncidentTo: aVertex) flatCollect: [ :undirectedEdge |
		undirectedEdge isSelfLoop
			ifTrue: [ Array with: aVertex ]
			ifFalse: [ undirectedEdge endpoints copyWithout: aVertex ] ]
]

{ #category : #'private - accessing' }
UndirectedGraph >> edges [

	^ edges
]

{ #category : #accessing }
UndirectedGraph >> edgesIncidentTo: aVertex [

	^ edges select: [ :undirectedEdge | undirectedEdge isIncidentTo: aVertex ]
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
