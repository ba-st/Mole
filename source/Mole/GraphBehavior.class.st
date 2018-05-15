Class {
	#name : #GraphBehavior,
	#superclass : #Object,
	#category : #Mole
}

{ #category : #accessing }
GraphBehavior >> edges [

	self subclassResponsibility
]

{ #category : #accessing }
GraphBehavior >> edgesConvergingTo: aNode [

	self subclassResponsibility
]

{ #category : #accessing }
GraphBehavior >> edgesStartingOn: aNode [

	self subclassResponsibility
]

{ #category : #testing }
GraphBehavior >> includesNode: aNode [

	self subclassResponsibility
]

{ #category : #testing }
GraphBehavior >> isAcyclic [

	self subclassResponsibility
]

{ #category : #accessing }
GraphBehavior >> nodes [

	self subclassResponsibility
]

{ #category : #accessing }
GraphBehavior >> nodesAdjacentTo: aNode [

	^(self edgesStartingOn: aNode) collect: [:edge | edge target]
]

{ #category : #accessing }
GraphBehavior >> nodesWithoutConvergingEdges [

	self subclassResponsibility
]

{ #category : #accessing }
GraphBehavior >> nodesWithoutStartingEdges [

	self subclassResponsibility
]

{ #category : #'removing nodes' }
GraphBehavior >> removeNode: anObject [

	^self removeNode: anObject ifAbsent: [NodeNotFoundException signalNode: anObject graph: self]
]

{ #category : #'removing nodes' }
GraphBehavior >> removeNode: anObject ifAbsent: aBlock [

	self subclassResponsibility
]

{ #category : #'removing nodes' }
GraphBehavior >> removeNodes: aCollectionOfNodes [

	self subclassResponsibility
]
