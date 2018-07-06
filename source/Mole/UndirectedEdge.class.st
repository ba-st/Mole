"
I'm an undirected edge, represented as the set of my vertices.
"
Class {
	#name : #UndirectedEdge,
	#superclass : #Edge,
	#instVars : [
		'labelOptional',
		'endpoints'
	],
	#category : #Mole
}

{ #category : #'instance creation' }
UndirectedEdge class >> relating: aVertexCollection [

	^ self relating: aVertexCollection labeledAccordingTo: Optional unused
]

{ #category : #'instance creation' }
UndirectedEdge class >> relating: aVertexCollection labeled: aLabel [

	^ self relating: aVertexCollection labeledAccordingTo: (Optional containing: aLabel)
]

{ #category : #'private - instance creation' }
UndirectedEdge class >> relating: aVertexCollection labeledAccordingTo: anOptional [

	AssertionChecker
		enforce: [ aVertexCollection size = 2 ]
		because: 'Undirected edges must specify exactly 2 vertices'
		raising: InstanceCreationFailed.

	^ self new intializeRelating: aVertexCollection asBag labeledAccordingTo: anOptional
]

{ #category : #comparing }
UndirectedEdge >> = anObject [

	^ self == anObject
		or: [ (anObject isA: self class)
				and: [ self endpoints = anObject endpoints and: [ self isLabeledLike: anObject ] ] ]
]

{ #category : #private }
UndirectedEdge >> endpoints [

	^ endpoints
]

{ #category : #comparing }
UndirectedEdge >> hash [

	^ endpoints hash
]

{ #category : #initialization }
UndirectedEdge >> intializeRelating: aVertexCollection labeledAccordingTo: anOptional [

	endpoints := aVertexCollection.
	labelOptional := anOptional
]

{ #category : #testing }
UndirectedEdge >> isDirected [

	^ false
]

{ #category : #testing }
UndirectedEdge >> isIncidentTo: aVertex [

	^ endpoints includes: aVertex
]

{ #category : #private }
UndirectedEdge >> isLabeledLike: anEdge [

	^ self
		withLabelDo: [ :label | anEdge withLabelDo: [ :edgeLabel | label = edgeLabel ] ifUnlabeled: [ false ] ]
		ifUnlabeled: [ anEdge withLabelDo: [ false ] ifUnlabeled: [ true ] ]
]

{ #category : #printing }
UndirectedEdge >> printOn: aStream [

	aStream nextPut: ${.
	endpoints
		do: [ :vertex | aStream print: vertex ]
		separatedBy: [ aStream
				nextPut: $,;
				space ].
	aStream nextPut: $}
]

{ #category : #accessing }
UndirectedEdge >> withLabelDo: aBlock ifUnlabeled: anUnlabeledBlock [

	^ labelOptional withContentDo: aBlock ifUnused: anUnlabeledBlock
]
