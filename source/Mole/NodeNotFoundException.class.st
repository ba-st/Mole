Class {
	#name : #NodeNotFoundException,
	#superclass : #Error,
	#instVars : [
		'node',
		'graph'
	],
	#category : #Mole
}

{ #category : #'instance creation' }
NodeNotFoundException class >> node: aNode graph: aGraph [

	^self new initializeNode: aNode graph: aGraph
]

{ #category : #signaling }
NodeNotFoundException class >> signalNode: aNode graph: aGraph [

	(self node: aNode graph: aGraph) signal
]

{ #category : #accessing }
NodeNotFoundException >> description [

	^'The graph does not contain the node <1s>' expandMacrosWith: node
]

{ #category : #accessing }
NodeNotFoundException >> graph [

	^graph
]

{ #category : #initialization }
NodeNotFoundException >> initializeNode: aNode graph: aGraph [

	node := aNode.
	graph := aGraph
]

{ #category : #accessing }
NodeNotFoundException >> node [

	^node
]
