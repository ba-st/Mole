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

	^ UndirectedGraph withVertices: vertices andEdges: edges
]

{ #category : #initialization }
UndirectedGraphBuilder >> initialize [

	super initialize .
	vertices := Set new.
	edges := OrderedCollection new
]

{ #category : #adding }
UndirectedGraphBuilder >> relate: aVertex to: anotherVertex [

	edges
		add:
			(UndirectedEdge
				relating:
					{aVertex.
					anotherVertex})
]

{ #category : #adding }
UndirectedGraphBuilder >> selfRelate: aVertex [

	edges add: (UndirectedEdge relating: {aVertex})
]
