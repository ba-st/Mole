"
I'm a builder of directed graphs
"
Class {
	#name : #DirectedGraphBuilder,
	#superclass : #GraphBuilder,
	#instVars : [
		'vertices',
		'edges'
	],
	#category : #Mole
}

{ #category : #adding }
DirectedGraphBuilder >> addVertex: aVertex [

	vertices add: aVertex
]

{ #category : #building }
DirectedGraphBuilder >> build [

	^ self graphClass withValidVertices: vertices andEdges: edges
]

{ #category : #adding }
DirectedGraphBuilder >> connect: aSourceVertex to: aTargetVertex [

	self
		addVertex: aSourceVertex;
		addVertex: aTargetVertex.
	edges add: (DirectedEdge from: aSourceVertex to: aTargetVertex)
]

{ #category : #acccessing }
DirectedGraphBuilder >> graphClass [

	^ DirectedGraph
]

{ #category : #initialization }
DirectedGraphBuilder >> initialize [

	super initialize .
	vertices := Set new.
	edges := OrderedCollection new
]
