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

{ #category : #'private - testing' }
Graph class >> endpointsOf: edges areIncludedIn: vertices [

	^ edges allSatisfy: [ :edge | vertices includesAll: edge relatedVertices ]
]

{ #category : #'private - testing' }
Graph class >> isCompatible: anEdge [

	"Returns if the edge is compatible with this kind of graph"

	^ self subclassResponsibility
]

{ #category : #'Instance creation' }
Graph class >> withValidVertices: aVertexCollection andEdges: anEdgeCollection [

	"This instance creation method will skip the assertions and it's not intended to be use used by code external to the package"

	^ self subclassResponsibility
]

{ #category : #'Instance creation' }
Graph class >> withVertices: aVertexCollection andEdges: anEdgeCollection [

	AssertionCheckerBuilder new
		raising: InstanceCreationFailed;
		checking: [ :asserter | 
			asserter
				enforce: [ self endpointsOf: anEdgeCollection areIncludedIn: aVertexCollection ] because: 'Some edge has endpoints not included in the vertices.';
				enforce: [ anEdgeCollection allSatisfy: [ :edge | self isCompatible: edge ] ] because: 'Some edge is incompatible with this type of graph.' ];
		buildAndCheck.

	^ self withValidVertices: aVertexCollection andEdges: anEdgeCollection
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
Graph >> selfLoops [

	^ self edges select: [ :edge | edge isSelfLoop ]
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

	^ self class withValidVertices: (self vertices copyWithout: aVertex) andEdges: (self edges reject: [ :edge | edge isIncidentTo: aVertex ])
]

{ #category : #converting }
Graph >> withoutVertices: aVertexCollection [

	"Returns a new graph excluding the vertices and all it's incident edges"

	^ self class withValidVertices: (self vertices copyWithoutAll: aVertexCollection) andEdges: (self edges reject: [ :edge | aVertexCollection anySatisfy: [ :vertex | edge isIncidentTo: vertex ] ])
]
