Class {
	#name : #GraphPathFinderTest,
	#superclass : #TestCase,
	#instVars : [
		'finder',
		'graph'
	],
	#category : #'Mole-Tests'
}

{ #category : #initialization }
GraphPathFinderTest >> initializeFinder [

	finder := GraphPathFinder on: graph
]

{ #category : #initialization }
GraphPathFinderTest >> initializeGraph [

	| edges |
	
	edges := OrderedCollection new
		add: (Edge from: 1 to: 1);
		add: (Edge from: 1 to: 2);
		add: (Edge from: 2 to: 3);
		add: (Edge from: 3 to: 4);
		add: (Edge from: 1 to: 5);
		yourself.
		
	graph := Graph edges: edges

]

{ #category : #initialization }
GraphPathFinderTest >> setUp [

	self initializeGraph.
	self initializeFinder
]

{ #category : #testing }
GraphPathFinderTest >> testGraphPathNotFoundException [

	[ finder pathFrom: 1 to: 6.
	self assert: false. ]
		on: GraphPathNotFoundException
		do: [ :aSignal |
			self assert: aSignal source = 1.
			self assert: aSignal target = 6.
			aSignal return: nil ]
]

{ #category : #testing }
GraphPathFinderTest >> testInvalidPath [

	#(#(3 1) #(5 1) #(4 1) #(4 2) #(3 2)) do: [ :anArray |
		self 
			should: [ finder pathFrom: anArray first to: anArray last ] 
			raise: GraphPathNotFoundException
			withExceptionDo: [ :anException |
				self assert: anException description notNil.
				self assert: anException source = anArray first.
				self assert: anException target = anArray last ]]
]

{ #category : #testing }
GraphPathFinderTest >> testPathToFarAwayPlaces [

	| path |

	path := finder pathFrom: 1 to: 3.
	self assert: path = (Graph edges: (OrderedCollection 
		with: (Edge from: 1 to: 2)
		with: (Edge from: 2 to: 3))).

	path := finder pathFrom: 1 to: 4.
	self assert: path = (Graph edges: (OrderedCollection 
		with: (Edge from: 1 to: 2)
		with: (Edge from: 2 to: 3)
		with: (Edge from: 3 to: 4))).
	
	path := finder pathFrom: 2 to: 4.
	self assert: path = (Graph edges: (OrderedCollection 
		with: (Edge from: 2 to: 3)
		with: (Edge from: 3 to: 4)))
]

{ #category : #testing }
GraphPathFinderTest >> testPathToNeighborPlace [

	| path |

	path := finder pathFrom: 1 to: 2.
	self assert: path = (Graph edges: (OrderedCollection 
		with: (Edge from: 1 to: 2))).

	path := finder pathFrom: 1 to: 5.
	self assert: path = (Graph edges: (OrderedCollection 
		with: (Edge from: 1 to: 5))).

	path := finder pathFrom: 2 to: 3.
	self assert: path = (Graph edges: (OrderedCollection 
		with: (Edge from: 2 to: 3))).
	
	path := finder pathFrom: 3 to: 4.
	self assert: path = (Graph edges: (OrderedCollection 
		with: (Edge from: 3 to: 4)))
]

{ #category : #testing }
GraphPathFinderTest >> testSamePlace [

	| path |

	path := finder pathFrom: 1 to: 1.
	self assert: path = (Graph edges: (OrderedCollection 
		with: (Edge from: 1 to: 1)))
]

{ #category : #testing }
GraphPathFinderTest >> testWithLoops [

	| path newGraph newFinder edges |

	"Add a cycle from 2 to 2"
	edges := graph edges.
	edges add: (Edge from: 2 to: 2).
	newGraph := Graph edges: edges.
	newFinder := GraphPathFinder on: newGraph.
	
	path := newFinder pathFrom: 1 to: 2.
	self assert: path = (Graph edges: (OrderedCollection 
		with: (Edge from: 1 to: 2))).

	path := newFinder pathFrom: 1 to: 3.
	self assert: path = (Graph edges: (OrderedCollection 
		with: (Edge from: 1 to: 2)
		with: (Edge from: 2 to: 3))).
		
	path := newFinder pathFrom: 2 to: 2.
	self assert: path = (Graph edges: (OrderedCollection 
		with: (Edge from: 2 to: 2))).

	"To the new graph, add a cycle from 3 to 3"	
	edges := graph edges.
	edges add: (Edge from: 3 to: 3).
	newGraph := Graph edges: edges.
	newFinder := GraphPathFinder on: newGraph.

	path := newFinder pathFrom: 1 to: 3.
	self assert: path = (Graph edges: (OrderedCollection 
		with: (Edge from: 1 to: 2)
		with: (Edge from: 2 to: 3))).
		
	path := newFinder pathFrom: 1 to: 4.
	self assert: path = (Graph edges: (OrderedCollection 
		with: (Edge from: 1 to: 2)
		with: (Edge from: 2 to: 3)
		with: (Edge from: 3 to: 4))).
		
	path := newFinder pathFrom: 3 to: 3.
	self assert: path = (Graph edges: (OrderedCollection 
		with: (Edge from: 3 to: 3))).
		
	path := newFinder pathFrom: 2 to: 4.
	self assert: path = (Graph edges: (OrderedCollection 
		with: (Edge from: 2 to: 3)
		with: (Edge from: 3 to: 4))).
		
	path := newFinder pathFrom: 3 to: 4.
	self assert: path = (Graph edges: (OrderedCollection 
		with: (Edge from: 3 to: 4)))
]
