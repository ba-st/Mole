"
I'm an abstract class for the graph traversal algorithm; a process of visiting each vertex in a graph, allowing to do something with them.
"
Class {
	#name : #GraphTraversal,
	#superclass : #Object,
	#category : #'Mole-Traversal'
}

{ #category : #traverse }
GraphTraversal >> traverse: aGraph from: aSourceVertex doing: aBlock [

	self subclassResponsibility
]
