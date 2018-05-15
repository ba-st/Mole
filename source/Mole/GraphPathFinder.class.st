Class {
	#name : #GraphPathFinder,
	#superclass : #Object,
	#instVars : [
		'graph',
		'passedByEdges'
	],
	#category : #Mole
}

{ #category : #'instance creation' }
GraphPathFinder class >> on: aGraph [

	^self new initializeWith: aGraph.
]

{ #category : #'path finding - private' }
GraphPathFinder >> createEdgeFrom: source to: target [

	^Edge from: source to: target
]

{ #category : #'path finding - private' }
GraphPathFinder >> createGraphWith: edges [

	^Graph edges: edges.

]

{ #category : #'path finding - private' }
GraphPathFinder >> emptyCollection [
	
	^#()

]

{ #category : #'path finding - private' }
GraphPathFinder >> findEdgesCheckingCyclesFrom: source to: target [ 

	| edges edgeToFind |
		
	edgeToFind := self createEdgeFrom: source to: target.
	edges := (self hasBeenPassedBy: edgeToFind)
				ifTrue: [ self emptyCollection ]	
				ifFalse: [
					self passedBy: edgeToFind.
					self findEdgesFrom: source to: target ].
					
	^edges.

]

{ #category : #'path finding - private' }
GraphPathFinder >> findEdgesFrom: source to: target [

	| convergingEdges matchingEdge |

	convergingEdges := graph edgesConvergingTo: target.
	matchingEdge := convergingEdges detect: [ :anEdge | anEdge goesFrom: source to: target ] ifNone: [ nil ].
		
	^matchingEdge isNil 
		ifTrue: [ self findEdgesFrom: source toAnyEdgeOf: convergingEdges ]
		ifFalse: [ OrderedCollection with: matchingEdge ].
				


]

{ #category : #'path finding - private' }
GraphPathFinder >> findEdgesFrom: source toAnyEdgeOf: convergingEdges [
	
	| path |

	convergingEdges do: [ :anEdge |
		path := self findEdgesCheckingCyclesFrom: source to: anEdge source.
		path notEmpty ifTrue: [ ^path add: anEdge;yourself. ] ].
		
	^self emptyCollection
]

{ #category : #'path finding - private' }
GraphPathFinder >> hasBeenPassedBy: anEdge [

	^passedByEdges includes: anEdge

]

{ #category : #initialization }
GraphPathFinder >> initializePassedByEdges [

	passedByEdges := Set new.


]

{ #category : #initialization }
GraphPathFinder >> initializeWith: aGraph [

	graph := aGraph.
]

{ #category : #'path finding - private' }
GraphPathFinder >> passedBy: anEdge [

	passedByEdges add: anEdge
]

{ #category : #'path finding' }
GraphPathFinder >> pathFrom: source to: target [ 

	| edges |
		
	self initializePassedByEdges.
	edges := self findEdgesCheckingCyclesFrom: source to: target.
	edges isEmpty ifTrue: [ GraphPathNotFoundException signalWithSource: source target: target ].

	^self createGraphWith: edges
]
