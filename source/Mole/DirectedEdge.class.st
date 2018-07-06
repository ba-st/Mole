"
I'm a directed edge. I connect one vertex to another in a graph.
"
Class {
	#name : #DirectedEdge,
	#superclass : #Edge,
	#instVars : [
		'source',
		'target',
		'labelOptional'
	],
	#category : #Mole
}

{ #category : #'instance creation' }
DirectedEdge class >> from: aSource to: aTarget [

	^ self from: aSource to: aTarget labeledAccordingTo: Optional unused
]

{ #category : #'instance creation' }
DirectedEdge class >> from: aSource to: aTarget labeled: aLabel [

	^ self from: aSource to: aTarget labeledAccordingTo: (Optional containing: aLabel)
]

{ #category : #'private - instance creation' }
DirectedEdge class >> from: aSource to: aTarget labeledAccordingTo: anOptional [

	^ self new initializeWithFrom: aSource to: aTarget labeledAccordingTo: anOptional
]

{ #category : #comparing }
DirectedEdge >> = anObject [

	^ self == anObject
		or: [ (anObject isA: self class)
				and: [ (anObject goesFrom: source to: target) and: [ self isLabeledLike: anObject ] ] ]
]

{ #category : #testing }
DirectedEdge >> convergesTo: anObject [

	^target = anObject
]

{ #category : #testing }
DirectedEdge >> goesFrom: aSourceVertex to: aTargetVertex [

	^ (self startsOn: aSourceVertex) and: [ self convergesTo: aTargetVertex ]
]

{ #category : #comparing }
DirectedEdge >> hash [

	| hashWithoutLabel |

	"Not all instances of unused optional will return the same hash"
	hashWithoutLabel := source hash bitXor: target hash.
	^ self
		withLabelDo: [ :label | hashWithoutLabel bitXor: label hash ]
		ifUnlabeled: [ hashWithoutLabel ]
]

{ #category : #initialization }
DirectedEdge >> initializeWithFrom: aSource to: aTarget labeledAccordingTo: anOptional [

	source := aSource.
	target := aTarget.
	labelOptional := anOptional
]

{ #category : #testing }
DirectedEdge >> isDirected [

	^ true
]

{ #category : #testing }
DirectedEdge >> isIncidentTo: aVertex [

	^ (self startsOn: aVertex) or: [ self convergesTo: aVertex ]
]

{ #category : #private }
DirectedEdge >> isLabeledLike: anEdge [

	^ self
		withLabelDo: [ :label | anEdge withLabelDo: [ :edgeLabel | label = edgeLabel ] ifUnlabeled: [ false ] ]
		ifUnlabeled: [ anEdge withLabelDo: [ false ] ifUnlabeled: [ true ] ]
]

{ #category : #printing }
DirectedEdge >> printOn: aStream [

	source printOn: aStream.
	aStream nextPutAll: ' -> '.
	target printOn: aStream
]

{ #category : #private }
DirectedEdge >> relatedVertices [

	^ {source. target} asSet
]

{ #category : #accessing }
DirectedEdge >> source [

	^source
]

{ #category : #testing }
DirectedEdge >> startsOn: anObject [

	^source = anObject
]

{ #category : #accessing }
DirectedEdge >> target [

	^target
]

{ #category : #accessing }
DirectedEdge >> withLabelDo: aBlock ifUnlabeled: anUnlabeledBlock [

	^ labelOptional withContentDo: aBlock ifUnused: anUnlabeledBlock
]
