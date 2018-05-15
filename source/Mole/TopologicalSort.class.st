Class {
	#name : #TopologicalSort,
	#superclass : #Object,
	#instVars : [
		'graph'
	],
	#category : #Mole
}

{ #category : #preconditions }
TopologicalSort class >> assertAcyclic: aGraph [

	aGraph isAcyclic ifTrue: [^self].

	CannotApplyTopologicalSortToACyclicGraphException signalGraph: aGraph
]

{ #category : #'instance creation' }
TopologicalSort class >> for: aGraph [

	self assertAcyclic: aGraph.

	^self new initializeFor: aGraph
]

{ #category : #initialization }
TopologicalSort >> initializeFor: aGraph [ 

	graph := aGraph

]

{ #category : #evaluating }
TopologicalSort >> value [

	| tempGraph result |

	tempGraph := graph copy.
	result := OrderedCollection new.

	[tempGraph notEmpty] whileTrue: [| startingNodes |
		startingNodes := tempGraph nodesWithoutConvergingEdges.
		result addAll: startingNodes.
		tempGraph := tempGraph removeNodes: startingNodes].

	^result
]
