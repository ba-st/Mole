"
I'm a directed graph: a graph where all the edges are directed from one vertex to another. A directed graph is sometimes called a digraph or a directed network.
"
Class {
	#name : #DirectedGraph,
	#superclass : #Graph,
	#instVars : [
		'vertices',
		'edges',
		'isAcyclic'
	],
	#category : #'Mole-Graph'
}

{ #category : #'private - testing' }
DirectedGraph class >> isCompatible: anEdge [

	^ anEdge isDirected
]

{ #category : #'Instance creation' }
DirectedGraph class >> withValidVertices: aVertexCollection andEdges: anEdgeCollection [

	^ self new initializeWithVertices: aVertexCollection asSet andEdges: anEdgeCollection asSet
]

{ #category : #accessing }
DirectedGraph >> directSuccessorsOf: aSourceVertex [

	^ (self edgesOutgoingFrom: aSourceVertex) collect: #target
]

{ #category : #'private - accessing' }
DirectedGraph >> edges [

	^ edges
]

{ #category : #accessing }
DirectedGraph >> edgesIncomingTo: aVertex [

	^ edges select: [ :directedEdge | directedEdge convergesTo: aVertex ]
]

{ #category : #accessing }
DirectedGraph >> edgesOutgoingFrom: aVertex [

	^ edges select: [ :directedEdge | directedEdge startsOn: aVertex ]
]

{ #category : #accessing }
DirectedGraph >> incomingDegreeOf: aVertex [

	^ (self edgesIncomingTo: aVertex) size
]

{ #category : #initialization }
DirectedGraph >> initializeWithVertices: aVertexCollection andEdges: anEdgeCollection [

	vertices := aVertexCollection.
	edges := anEdgeCollection
]

{ #category : #testing }
DirectedGraph >> isAcyclic [

	isAcyclic
		ifNil: [ | currentGraph verticesSurelyNotInCycles |

			currentGraph := self.
			[ verticesSurelyNotInCycles := currentGraph verticesWithoutIncomingEdges.
			verticesSurelyNotInCycles notEmpty ] whileTrue: [ currentGraph := currentGraph withoutVertices: verticesSurelyNotInCycles ].
			isAcyclic := currentGraph order = 0 ].
	^ isAcyclic
]

{ #category : #testing }
DirectedGraph >> isCyclic [

	^ self isAcyclic not
]

{ #category : #accessing }
DirectedGraph >> outgoingDegreeOf: aVertex [

	^ (self edgesOutgoingFrom: aVertex) size
]

{ #category : #accessing }
DirectedGraph >> topologicalSort [

	"If the graph is acyclic returns a topological sort of its vertices."

	| topologicalSort currentGraph |

	topologicalSort := OrderedCollection new: self order.
	currentGraph := self.

	[ currentGraph order strictlyPositive ]
		whileTrue: [ | currentVertices |

			currentVertices := currentGraph verticesWithoutIncomingEdges.
			AssertionChecker enforce: [ currentVertices notEmpty ] because: 'Cannot get a topological sort on a cyclic graph.'.
			topologicalSort addAll: currentVertices.
			currentGraph := currentGraph withoutVertices: currentVertices ].
	^ topologicalSort asArray
]

{ #category : #'private - accessing' }
DirectedGraph >> vertices [

	^ vertices
]

{ #category : #accessing }
DirectedGraph >> verticesReachableFrom: aSourceVertex [

	| reachableVertices |

	reachableVertices := Set new.
	self verticesReachableFrom: aSourceVertex collectedOn: reachableVertices.
	^ reachableVertices
]

{ #category : #'private - accessing' }
DirectedGraph >> verticesReachableFrom: aSourceVertex collectedOn: reachableVertices [

	| successors successorsNotVisited |

	successors := self directSuccessorsOf: aSourceVertex.
	successorsNotVisited := successors
		reject: [ :vertex | reachableVertices includes: vertex ].

	reachableVertices addAll: successors.

	successorsNotVisited
		do:
			[ :successor | self verticesReachableFrom: successor collectedOn: reachableVertices ]
]

{ #category : #'private - accessing' }
DirectedGraph >> verticesWithoutIncomingEdges [

	^ vertices select: [ :vertex | (self incomingDegreeOf: vertex) = 0 ]
]
