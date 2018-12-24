"
I'm an abstract class for the graph traversal algorithm; a process of visiting each vertex in a graph, allowing to do something with them.
"
Class {
	#name : #GraphTraversalAlgorithm,
	#superclass : #Object,
	#category : #'Mole-Traversal'
}

{ #category : #traverse }
GraphTraversalAlgorithm >> traverse: aGraph from: aSourceVertex doing: aBlock [

	self subclassResponsibility
]
