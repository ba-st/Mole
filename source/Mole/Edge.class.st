"
I'm an edge, one of the two basic units out of which graphs are constructed. 
Each edge has two vertices to which it is attached, called its endpoints. 
Edges may be directed or undirected; undirected edges are also called lines and directed edges are also called arcs or arrows. 
In an undirected simple graph, an edge may be represented as the set of its vertices, and in a directed simple graph it may be represented as an ordered pair of its vertices.
"
Class {
	#name : #Edge,
	#superclass : #Object,
	#category : #'Mole-Graph'
}

{ #category : #private }
Edge >> endpoints [

	self subclassResponsibility
]

{ #category : #testing }
Edge >> isDirected [

	self subclassResponsibility
]

{ #category : #testing }
Edge >> isIncidentTo: aVertex [

	self subclassResponsibility
]

{ #category : #testing }
Edge >> isSelfLoop [

	^ self endpoints asSet size = 1
]

{ #category : #accessing }
Edge >> vertexRelatedTo: aVertex [

	^ Bag new
		addAll: self endpoints;
		remove: aVertex;
		anyOne
]

{ #category : #accessing }
Edge >> withLabelDo: aBlock ifUnlabeled: anUnlabeledBlock [

	self subclassResponsibility
]
