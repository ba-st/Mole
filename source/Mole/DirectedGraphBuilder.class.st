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

	^ DirectedGraph withVertices: vertices andEdges: edges
]

{ #category : #adding }
DirectedGraphBuilder >> connect: aSourceVertex to: aTargetVertex [

	edges add: (DirectedEdge from: aSourceVertex to: aTargetVertex)
]

{ #category : #initialization }
DirectedGraphBuilder >> initialize [

	super initialize .
	vertices := Set new.
	edges := OrderedCollection new
]
