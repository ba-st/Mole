Class {
	#name : #GraphPathNotFoundException,
	#superclass : #Error,
	#instVars : [
		'source',
		'target'
	],
	#category : #Mole
}

{ #category : #signaling }
GraphPathNotFoundException class >> signalWithSource: aSourceNode target: aTargetNode [

	(self source: aSourceNode target: aTargetNode) signal
]

{ #category : #'instance creation' }
GraphPathNotFoundException class >> source: aSourceNode target: aTargetNode [

	^self new initializeWithSource: aSourceNode target: aTargetNode
]

{ #category : #accessing }
GraphPathNotFoundException >> description [

	^'A way was not from <1p> to <2p>'
		expandMacrosWith: source
		with: target
]

{ #category : #initialization }
GraphPathNotFoundException >> initializeWithSource: aSourceNode target: aTargetNode [

	source := aSourceNode.
	target := aTargetNode
]

{ #category : #accessing }
GraphPathNotFoundException >> source [ 

	^source
]

{ #category : #accessing }
GraphPathNotFoundException >> target [

	^target
]
