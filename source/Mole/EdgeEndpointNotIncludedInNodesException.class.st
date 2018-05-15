Class {
	#name : #EdgeEndpointNotIncludedInNodesException,
	#superclass : #Error,
	#instVars : [
		'invalidEdge',
		'edges',
		'nodes'
	],
	#category : #Mole
}

{ #category : #'instance creation' }
EdgeEndpointNotIncludedInNodesException class >> invalidEdge: anInvalidEdge edges: anEdges nodes: aNodes [

	^self new initializeInvalidEdge: anInvalidEdge edges: anEdges nodes: aNodes
]

{ #category : #signaling }
EdgeEndpointNotIncludedInNodesException class >> signalInvalidEdge: anInvalidEdge edges: anEdges nodes: aNodes [

	(self invalidEdge: anInvalidEdge edges: anEdges nodes: aNodes) signal
]

{ #category : #accessing }
EdgeEndpointNotIncludedInNodesException >> description [

	^'Some of the ends of the axis <1p> is not including in the set of nodes '
		expandMacrosWith: invalidEdge
]

{ #category : #accessing }
EdgeEndpointNotIncludedInNodesException >> edges [

	^edges
]

{ #category : #initialization }
EdgeEndpointNotIncludedInNodesException >> initializeInvalidEdge: anInvalidEdge edges: anEdges nodes: aNodes [

	invalidEdge := anInvalidEdge.
	edges := anEdges.
	nodes := aNodes
]

{ #category : #accessing }
EdgeEndpointNotIncludedInNodesException >> invalidEdge [

	^invalidEdge
]

{ #category : #accessing }
EdgeEndpointNotIncludedInNodesException >> nodes [

	^nodes
]
