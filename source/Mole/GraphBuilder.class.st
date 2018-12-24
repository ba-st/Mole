"
I'm a builder of graphs, both directed and undirected. Connections are declared and then directionality is defined when requesting the built instance.
"
Class {
	#name : #GraphBuilder,
	#superclass : #Object,
	#instVars : [
		'vertices',
		'labelByEdgeArray'
	],
	#category : #'Mole-Graph'
}

{ #category : #configuring }
GraphBuilder >> addVertex: aVertex [

	vertices add: aVertex
]

{ #category : #configuring }
GraphBuilder >> addVertices: aVertexCollection [

	aVertexCollection do: [ :vertex | self addVertex: vertex ]
]

{ #category : #building }
GraphBuilder >> buildDirected [

	| directedEdges |

	directedEdges := Set new.
	labelByEdgeArray
		keysAndValuesDo:
			[ :edgeArray :labelOptional | directedEdges add: (self directedEdgeFrom: edgeArray labeledAccordingTo: labelOptional) ].

	^ DirectedGraph withValidVertices: vertices andEdges: directedEdges
]

{ #category : #building }
GraphBuilder >> buildUndirected [

	| undirectedEdges |

	undirectedEdges := Set new.
	labelByEdgeArray
		keysAndValuesDo: [ :edgeArray :labelOptional | 
			undirectedEdges
				add: (self undirectedEdgeFrom: edgeArray labeledAccordingTo: labelOptional) ].

	^ UndirectedGraph
		withValidVertices: vertices
		andEdges: undirectedEdges
]

{ #category : #configuring }
GraphBuilder >> connect: aSourceVertex to: aTargetVertex [

	self connect: aSourceVertex to: aTargetVertex labeledAccordingTo: Optional unused
]

{ #category : #configuring }
GraphBuilder >> connect: aSourceVertex to: aTargetVertex labeled: aLabel [

	"In graph theory, the edge label can be any element attached to it. It is possible to label an edge with a name, a color, a weight or even an object."

	self
		connect: aSourceVertex
		to: aTargetVertex
		labeledAccordingTo: (Optional containing: aLabel)
]

{ #category : #'private - configuring' }
GraphBuilder >> connect: aSourceVertex to: aTargetVertex labeledAccordingTo: aLabelOptional [

	self
		addVertex: aSourceVertex;
		addVertex: aTargetVertex.
	labelByEdgeArray
		at:
			{aSourceVertex.
			aTargetVertex}
		put: aLabelOptional
]

{ #category : #'private - accessing' }
GraphBuilder >> directedEdgeFrom: edgeArray labeledAccordingTo: labelOptional [

	^ DirectedEdge
		from: edgeArray first
		to: edgeArray last
		labeledAccordingTo: labelOptional
]

{ #category : #initialization }
GraphBuilder >> initialize [

	super initialize.
	vertices := Set new.
	labelByEdgeArray := Dictionary new
]

{ #category : #configuring }
GraphBuilder >> loopOn: aVertex [

	self connect: aVertex to: aVertex
]

{ #category : #configuring }
GraphBuilder >> loopOn: aVertex labeled: aLabel [

	self connect: aVertex to: aVertex labeled: aLabel
]

{ #category : #'private - accessing' }
GraphBuilder >> undirectedEdgeFrom: edgeArray labeledAccordingTo: labelOptional [

	^ UndirectedEdge
		relating: edgeArray asBag
		labeledAccordingTo: labelOptional
]
