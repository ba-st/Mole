"
I'm a builder of undirected graphs
"
Class {
	#name : #UndirectedGraphBuilder,
	#superclass : #GraphBuilder,
	#instVars : [
		'vertices',
		'edges'
	],
	#category : #Mole
}

{ #category : #adding }
UndirectedGraphBuilder >> addVertex: aVertex [

	vertices add: aVertex
]

{ #category : #building }
UndirectedGraphBuilder >> build [

	^ self graphClass withValidVertices: vertices andEdges: edges
]

{ #category : #acccessing }
UndirectedGraphBuilder >> graphClass [

	^ UndirectedGraph
]

{ #category : #initialization }
UndirectedGraphBuilder >> initialize [

	super initialize .
	vertices := Set new.
	edges := OrderedCollection new
]

{ #category : #adding }
UndirectedGraphBuilder >> relate: aVertex to: anotherVertex [

	self
		addVertex: aVertex;
		addVertex: anotherVertex.
	edges add: (UndirectedEdge relating: {aVertex. anotherVertex})
]

{ #category : #adding }
UndirectedGraphBuilder >> selfRelate: aVertex [

	self addVertex: aVertex.
	edges add: (UndirectedEdge relating: {aVertex})
]
