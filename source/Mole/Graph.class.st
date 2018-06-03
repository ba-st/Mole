"
I'm an abstract class representing a graph consisting of a set of vertices (also called nodes) and a set of edges (also called links, or arcs); each edge connects nodes to each other. 

Implementation details

- I'm an immutable representation
"
Class {
	#name : #Graph,
	#superclass : #Object,
	#category : #Mole
}

{ #category : #'Instance creation' }
Graph class >> withVertices: aVertexCollection andEdges: anEdgeCollection [

	^ self subclassResponsibility
]

{ #category : #'private - accessing' }
Graph >> edges [

	^ self subclassResponsibility
]

{ #category : #testing }
Graph >> includesVertex: aVertex [

	^ self vertices includes: aVertex
]

{ #category : #testing }
Graph >> is: aVertex adjacentTo: anotherVertex [

	^ self edges anySatisfy: [ :edge | (edge isIncidentTo: aVertex) and: [ edge isIncidentTo: anotherVertex ] ]
]

{ #category : #accessing }
Graph >> neighborsOf: aVertex [

	"Returns the vertices that are connected to aVertex"

	^ self edges select: [ :edge | edge isIncidentTo: aVertex ] thenCollect: [ :edge | edge vertexRelatedTo: aVertex ]
]

{ #category : #accessing }
Graph >> order [

	"The number of vertices"

	^ self vertices size
]

{ #category : #accessing }
Graph >> size [

	"The number of edges"

	^ self edges  size
]

{ #category : #'private - accessing' }
Graph >> vertices [

	^ self subclassResponsibility
]

{ #category : #converting }
Graph >> withoutVertex: aVertex [

	"Returns a new graph excluding the vertex and all it's incident edges"

	^ self class withVertices: (self vertices copyWithout: aVertex) andEdges: (self edges reject: [ :edge | edge isIncidentTo: aVertex ])
]
