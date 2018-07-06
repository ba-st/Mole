"
I'm an undirected edge, represented as the set of my vertices.
"
Class {
	#name : #UndirectedEdge,
	#superclass : #Edge,
	#instVars : [
		'relatedVertices',
		'labelOptional'
	],
	#category : #Mole
}

{ #category : #'instance creation' }
UndirectedEdge class >> relating: aVertexCollection [

	^ self relating: aVertexCollection asSet labeledAccordingTo: Optional unused
]

{ #category : #'instance creation' }
UndirectedEdge class >> relating: aVertexCollection labeled: aLabel [

	^ self relating: aVertexCollection asSet labeledAccordingTo: (Optional containing: aLabel)
]

{ #category : #'private - instance creation' }
UndirectedEdge class >> relating: aVertexCollection labeledAccordingTo: anOptional [

	AssertionChecker
		enforce: [ aVertexCollection size between: 1 and: 2 ]
		because: 'Undirected edges can only be self-loops or connect exactly 2 vertices'
		raising: InstanceCreationFailed.

	^ self new intializeRelating: aVertexCollection asSet labeledAccordingTo: anOptional
]

{ #category : #comparing }
UndirectedEdge >> = anObject [

	^ self == anObject
		or: [ (anObject isA: self class)
				and: [ self relatedVertices = anObject relatedVertices and: [ self isLabeledLike: anObject ] ] ]
]

{ #category : #comparing }
UndirectedEdge >> hash [

	| hashWithoutLabel |

	"Not all instances of unused optional will return the same hash"
	hashWithoutLabel := relatedVertices hash.
	^ self
		withLabelDo: [ :label | hashWithoutLabel bitXor: label hash ]
		ifUnlabeled: [ hashWithoutLabel ]
]

{ #category : #initialization }
UndirectedEdge >> intializeRelating: aVertexCollection labeledAccordingTo: anOptional [

	relatedVertices := aVertexCollection.
	labelOptional := anOptional
]

{ #category : #testing }
UndirectedEdge >> isDirected [

	^ false
]

{ #category : #testing }
UndirectedEdge >> isIncidentTo: aVertex [

	^ relatedVertices includes: aVertex
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
	relatedVertices
		do: [ :vertex | aStream print: vertex ]
		separatedBy: [ aStream
				nextPut: $,;
				space ].
	aStream nextPut: $}
]

{ #category : #private }
UndirectedEdge >> relatedVertices [

	^ relatedVertices
]

{ #category : #accessing }
UndirectedEdge >> withLabelDo: aBlock ifUnlabeled: anUnlabeledBlock [

	^ labelOptional withContentDo: aBlock ifUnused: anUnlabeledBlock
]
