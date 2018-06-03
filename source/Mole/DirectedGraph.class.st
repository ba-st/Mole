"
I'm a directed graph: a graph where all the edges are directed from one vertex to another. A directed graph is sometimes called a digraph or a directed network.
"
Class {
	#name : #DirectedGraph,
	#superclass : #Graph,
	#instVars : [
		'vertices',
		'edges'
	],
	#category : #Mole
}

{ #category : #'Instance creation' }
DirectedGraph class >> withVertices: aVertexCollection andEdges: anEdgeCollection [

	^ self new initializeWithVertices: aVertexCollection asSet andEdges: anEdgeCollection asSet
]

{ #category : #'private - accessing' }
DirectedGraph >> edges [

	^ edges
]

{ #category : #accessing }
DirectedGraph >> edgesIncomingTo: aVertex [

	^ edges select: [ :directedEdge | directedEdge convergesTo: aVertex ]
]

{ #category : #accessing }
DirectedGraph >> edgesOutgoingFrom: aVertex [

	^ edges select: [ :directedEdge | directedEdge startsOn: aVertex ]
]

{ #category : #accessing }
DirectedGraph >> incomingDegreeOf: aVertex [

	^ (self edgesIncomingTo: aVertex) size
]

{ #category : #initialization }
DirectedGraph >> initializeWithVertices: aVertexCollection andEdges: anEdgeCollection [

	vertices := aVertexCollection.
	edges := anEdgeCollection
]

{ #category : #testing }
DirectedGraph >> isCyclic [

	self halt
]

{ #category : #accessing }
DirectedGraph >> outgoingDegreeOf: aVertex [

	^ (self edgesOutgoingFrom: aVertex) size
]

{ #category : #'private - accessing' }
DirectedGraph >> vertices [

	^ vertices
]
