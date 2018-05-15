Class {
	#name : #CannotApplyTopologicalSortToACyclicGraphException,
	#superclass : #Error,
	#instVars : [
		'graph'
	],
	#category : #Mole
}

{ #category : #'instance creation' }
CannotApplyTopologicalSortToACyclicGraphException class >> graph: aGraph [

	^self new initializeGraph: aGraph
]

{ #category : #signaling }
CannotApplyTopologicalSortToACyclicGraphException class >> signalGraph: aGraph [

	(self graph: aGraph) signal
]

{ #category : #accessing }
CannotApplyTopologicalSortToACyclicGraphException >> description [

	^'The algorithm of topological sort cannot be applied to a graph with cycles'
]

{ #category : #accessing }
CannotApplyTopologicalSortToACyclicGraphException >> graph [

	^graph
]

{ #category : #initialization }
CannotApplyTopologicalSortToACyclicGraphException >> initializeGraph: aGraph [

	graph := aGraph.
]
