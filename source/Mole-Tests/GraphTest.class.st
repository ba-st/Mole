Class {
	#name : #GraphTest,
	#superclass : #TestCase,
	#category : #'Mole-Tests'
}

{ #category : #test }
GraphTest >> testAccessImmutability [

	| graph edges edgesPreviousAdd nodesPreviousAdd |

	edges := OrderedCollection new
		add: (Edge from: 1 to: 2);
		add: (Edge from: 2 to: 3);
		add: (Edge from: 3 to: 4);
		add: (Edge from: 1 to: 4);
		add: (Edge from: 4 to: 4);
		yourself.
	
	graph := Graph edges: edges.		

	edgesPreviousAdd := graph edges.
	nodesPreviousAdd := graph nodes.

	edges := graph edges.
	edges add: (Edge from: 4 to: 5).

	self assert: ((edges copy removeAll: graph edges; yourself) includes: (Edge from: 4 to: 5)).
	self assert: (edgesPreviousAdd copy removeAll: graph edges; yourself) isEmpty.	
	self assert: (graph edges removeAll: edgesPreviousAdd; yourself) isEmpty.	
	
	self assert: (nodesPreviousAdd copy removeAll: graph nodes; yourself) isEmpty.	
	self assert: (graph nodes removeAll:  nodesPreviousAdd; yourself) isEmpty

]

{ #category : #test }
GraphTest >> testApplyUsingDepthFistSearch [

	| collectedNodes expectedCollectedNodes graph |

	collectedNodes := OrderedCollection new.

	graph :=
		Graph edges: (
			OrderedCollection new
				add: (Edge from: 1 to: 2);
				add: (Edge from: 2 to: 3);
				add: (Edge from: 3 to: 4);
				add: (Edge from: 4 to: 5);
				add: (Edge from: 1 to: 6);
				add: (Edge from: 1 to: 7);
				yourself).

	graph apply: [:node | collectedNodes add: node] usingDepthFirstSearchFrom: 1.

	expectedCollectedNodes := #(1 2 3 4 5 6 7).

	self assert: collectedNodes asOrderedCollection = expectedCollectedNodes asOrderedCollection
]

{ #category : #test }
GraphTest >> testConvergingEdges [

	| graph edges |
	
	edges := OrderedCollection new
		add: (Edge from: 1 to: 2);
		add: (Edge from: 2 to: 3);
		add: (Edge from: 3 to: 4);
		add: (Edge from: 1 to: 4);
		add: (Edge from: 4 to: 4);
		yourself.
	
	graph := Graph edges: edges.
	
	self assert: (graph edgesConvergingTo: 1) isEmpty.
	self assert: (graph edgesConvergingTo: 2) size = 1.
	self assert: ((graph edgesConvergingTo: 2) copyWithout: (Edge from: 1 to: 2)) isEmpty.
	
	self assert: (graph edgesConvergingTo: 3) size = 1.
	self assert: ((graph edgesConvergingTo: 3) copyWithout: (Edge from: 2 to: 3)) isEmpty.

	self assert: (graph edgesConvergingTo: 4) size = 3.
	self assert: ((graph edgesConvergingTo: 4) removeAll: (OrderedCollection 
		with: (Edge from: 3 to: 4)
		with: (Edge from: 4 to: 4)
		with: (Edge from: 1 to: 4)); yourself) isEmpty.
	
	self assert: (graph edgesConvergingTo: 5) isEmpty
]

{ #category : #test }
GraphTest >> testCreateGraphWithInvalidEdge [

	| nodes invalidEdge edges |

	nodes := Set with: 'a' with: 'b' with: 'c'.
	invalidEdge := Edge from: 'c' to: 'd'.
	edges := Set with: (Edge from: 'a' to: 'b') with: invalidEdge.

	self
		should: [Graph edges: edges nodes: nodes]
		raise: EdgeEndpointNotIncludedInNodesException
		withExceptionDo: [ :anException |
			self
				assert: anException description notEmpty;
				assert: anException invalidEdge = invalidEdge;
				assert: anException edges = edges;
				assert: anException nodes = nodes]
]

{ #category : #test }
GraphTest >> testCreateGraphWithUnconnectedNodes [

	| nodes graph edge |

	nodes := Set with: 'a' with: 'b' with: 'c'.
	edge := Edge from: 'a' to: 'b'.

	graph := Graph edges: (Set with: edge) nodes: nodes.

	self
		assert: graph nodes size = nodes size;
		assert: (graph nodes includesAllOf: nodes);
		assert: (graph edges allSatisfy: [:each | each = edge]);
		assert: (graph nodesWithoutConvergingEdges includes: 'a');
		assert: (graph nodesWithoutConvergingEdges includes: 'c');
		assert: (graph nodesWithoutStartingEdges includes: 'c')
]

{ #category : #test }
GraphTest >> testCreateGraphWithoutEdges [

	| nodes graph |

	nodes := (Set with: 'a' with: 'b' with: 'c').
	graph := Graph edges: #() nodes: nodes.

	self
		assert: graph nodes size = 3;
		assert: (graph nodes includesAllOf: nodes);
		assert: graph nodesWithoutStartingEdges size = nodes size;
		assert: graph nodesWithoutConvergingEdges size = nodes size;
		assert: (graph nodesWithoutStartingEdges includesAllOf: nodes);
		assert: (graph nodesWithoutConvergingEdges includesAllOf: nodes)
]

{ #category : #test }
GraphTest >> testCreationImmutability [

	| graph edges |

	edges := OrderedCollection new
		add: (Edge from: 1 to: 2);
		add: (Edge from: 2 to: 3);
		add: (Edge from: 3 to: 4);
		add: (Edge from: 1 to: 4);
		add: (Edge from: 4 to: 4);
		yourself.
	
	graph := Graph edges: edges.		

	"Verify if modifying the entrance collection the graph follows immutable"
	edges add: (Edge from: 4 to: 5).
	self assert: graph edges size = 5.
	self deny: (graph edges includes: (Edge from: 4 to: 5))
]

{ #category : #test }
GraphTest >> testEdgesConvergingToSelf [

	| graph edges |
	
	edges := OrderedCollection new
		add: (Edge from: 1 to: 2);
		add: (Edge from: 2 to: 3);
		add: (Edge from: 3 to: 4);
		add: (Edge from: 1 to: 4);
		add: (Edge from: 4 to: 4);
		yourself.
	
	graph := Graph edges: edges.	
	self assert: (graph edgesConvergingToSelf) size = 1.
	self assert: ((graph edgesConvergingToSelf) copyWithout: (Edge from: 4 to:4)) isEmpty
]

{ #category : #test }
GraphTest >> testEqual [

	| graph1 graph2 |
	
	graph1 := Graph edges: (Array 
		with: (Edge from: 1 to: 2)
		with: (Edge from: 2 to: 3) ).
		
	graph2 := Graph edges: (Array 
		with: (Edge from: 2 to: 3) 
		with: (Edge from: 1 to: 2) ).
	
	self assert: graph1 = graph2
]

{ #category : #test }
GraphTest >> testEqualsDifferentGraphs [

	| graph1 graph2 |

	graph1 := Graph edges: (Array with: (Edge from: 1 to: 2) with: (Edge from: 4 to: 5)).
	graph2 := Graph edges: (Array with: (Edge from: 2 to: 3) with: (Edge from: 1 to: 2)).

	self deny: graph1 = graph2
]

{ #category : #test }
GraphTest >> testGraphCreation [

	| graph edges |

	edges :=
		OrderedCollection new
			add: (Edge from: 1 to: 2);
			add: (Edge from: 2 to: 3);
			yourself.

	graph := Graph edges: edges.

	self assert: graph edges size = 2.
	self assert: (graph edges includes: (Edge from: 1 to: 2)).
	self assert: (graph edges includes: (Edge from: 2 to: 3)).

	self assert: (graph nodes size = 3).
	self assert: (graph nodes includes: 1).
	self assert: (graph nodes includes: 2).
	self assert: (graph nodes includes: 3)
]

{ #category : #test }
GraphTest >> testHash [

	| graph1 graph2 |
	
	graph1 := Graph edges: (Array 
		with: (Edge from: 1 to: 2)
		with: (Edge from: 2 to: 3) ).
		
	graph2 := Graph edges: (Array 
		with: (Edge from: 2 to: 3) 
		with: (Edge from: 1 to: 2) ).
	
	self assert: graph1 hash = graph2 hash
]

{ #category : #test }
GraphTest >> testIncludesNode [

	| graph edges |
	
	edges := OrderedCollection new
		add: (Edge from: 1 to: 2);
		add: (Edge from: 2 to: 3);
		yourself.
	
	graph := Graph edges: edges.
	
	self assert: (graph includesNode: 1).
	self assert: (graph includesNode: 2).
	self assert: (graph includesNode: 3).
	self deny: (graph includesNode: 4)
]

{ #category : #test }
GraphTest >> testIsAcyclicWhenGraphIsAcyclic [

	| acyclicGraph |

	acyclicGraph :=
		Graph edges: (Array with: (Edge from: 'a' to: 'b') with: (Edge from: 'b' to: 'c')).


	self assert: acyclicGraph isAcyclic
]

{ #category : #test }
GraphTest >> testIsAcyclicWhenGraphIsCyclic [

	| cyclicGraph |

	cyclicGraph :=
		Graph edges: (
			Array
				with: (Edge from: 'a' to: 'b')
				with: (Edge from: 'b' to: 'c')
				with: (Edge from: 'c' to: 'a')).

	self deny: cyclicGraph isAcyclic.

	cyclicGraph :=
		Graph edges: (
			Array
				with: (Edge from: 'a' to: 'b')
				with: (Edge from: 'b' to: 'c')
				with: (Edge from: 'c' to: 'b')).

	self deny: cyclicGraph isAcyclic
]

{ #category : #test }
GraphTest >> testIsEmpty [

	| graph |

	graph := Graph edges: #() nodes: #().

	self assert: graph isEmpty
]

{ #category : #test }
GraphTest >> testNodesAdjacentTo [

	| graph adjacentNodes |

	graph :=
		Graph edges: (
			OrderedCollection new
				add: (Edge from: 1 to: 2);
				add: (Edge from: 2 to: 3);
				add: (Edge from: 4 to: 5);
				add: (Edge from: 1 to: 6);
				add: (Edge from: 1 to: 7);
				yourself).

	adjacentNodes := #(2 6 7).

	self assert: (graph nodesAdjacentTo: 1) asOrderedCollection = adjacentNodes asOrderedCollection
]

{ #category : #test }
GraphTest >> testNodesWithoutEdges [

	| graph edges |

	edges :=
		OrderedCollection new
			add: (Edge from: 1 to: 2);
			add: (Edge from: 2 to: 3);
			yourself.

	graph := Graph edges: edges.

	self assert: (graph nodesWithoutStartingEdges size = 1).
	self assert: (graph nodesWithoutStartingEdges includes: 3).
	self assert: (graph nodesWithoutConvergingEdges size = 1).
	self assert: (graph nodesWithoutConvergingEdges includes: 1)
]

{ #category : #test }
GraphTest >> testNotEmpty [

	| graph |

	graph := Graph edges: #() nodes: (Set with: 'a').

	self
		assert: graph notEmpty;
		deny: graph isEmpty.

	graph := Graph edges: (Array with: (Edge from: 'a' to: 'b')).

	self
		assert: graph notEmpty;
		deny: graph isEmpty
]

{ #category : #test }
GraphTest >> testRemoveNode [

	| nodes nodeToRemove edge edgeToRemove edges graph modifiedGraph |

	nodeToRemove := 'c'.
	nodes := Set with: 'a' with: 'b' with: nodeToRemove.
	edge := Edge from: 'a' to: 'b'.
	edgeToRemove := Edge from: 'b' to: nodeToRemove.

	edges := Set with: edge with: edgeToRemove.
	graph := Graph edges: edges nodes: nodes.

	modifiedGraph := graph removeNode: nodeToRemove.

	self
		assert: graph = (Graph edges: edges nodes: nodes)
			description: 'El grafo el inmutable, eliminar un nodo crea otro grafo';
		assert: modifiedGraph edges size = (edges size - 1);
		deny: (modifiedGraph edges includes: (edgeToRemove));
		assert: (modifiedGraph edges includes: edge);
		deny: (modifiedGraph nodes includes: nodeToRemove);
		assert: (modifiedGraph nodes includes: 'a');
		assert: (modifiedGraph nodes includes: 'b')
]

{ #category : #test }
GraphTest >> testRemoveNodeWithInvalidNode [

	| graph |

	graph := Graph edges: (Array with: (Edge from: 'a' to: 'b')).

	self
		should: [graph removeNode: 'd']
		raise: NodeNotFoundException
		withExceptionDo: [ :anException |
			self
				assert: anException description notEmpty;
				assert: anException node = 'd';
				assert: anException graph = graph]
]

{ #category : #test }
GraphTest >> testRemoveNodes [

	| nodes nodeToRemove edge edgeToRemove edges graph modifiedGraph anotherNodeToRemove
	  anotherEdgeToRemove |

	nodeToRemove := 'c'.
	anotherNodeToRemove := 'd'.
	nodes := Set with: 'a' with: 'b' with: nodeToRemove with: anotherNodeToRemove.
	edge := Edge from: 'a' to: 'b'.
	edgeToRemove := Edge from: 'b' to: nodeToRemove.
	anotherEdgeToRemove := Edge from: 'a' to: anotherNodeToRemove.

	edges := Set with: edge with: edgeToRemove with: anotherEdgeToRemove.
	graph := Graph edges: edges nodes: nodes.

	modifiedGraph := graph removeNodes: (Array with: nodeToRemove with: anotherNodeToRemove).

	self
		assert: graph = (Graph edges: edges nodes: nodes)
			description: 'The graph is immutable, to eliminate a node creates another graph';
		assert: modifiedGraph edges size = (edges size - 2);
		deny: (modifiedGraph edges includes: edgeToRemove);
		deny: (modifiedGraph edges includes: anotherEdgeToRemove);
		assert: (modifiedGraph edges includes: edge);
		deny: (modifiedGraph nodes includes: nodeToRemove);
		deny: (modifiedGraph nodes includes: anotherNodeToRemove);
		assert: (modifiedGraph nodes includes: 'a');
		assert: (modifiedGraph nodes includes: 'b')
]

{ #category : #test }
GraphTest >> testSameNodesAs [

	| graph anotherGraph nodes |

	nodes := Set with: 'a' with: 'b'.
	graph := Graph edges: #() nodes: nodes.
	anotherGraph := Graph edges: #() nodes: nodes.

	self assert: (graph sameNodesAs: anotherGraph)
]

{ #category : #test }
GraphTest >> testStartingEdges [

	| graph edges |
	
	edges := OrderedCollection new
		add: (Edge from: 1 to: 2);
		add: (Edge from: 2 to: 3);
		add: (Edge from: 3 to: 4);
		add: (Edge from: 1 to: 4);
		add: (Edge from: 4 to: 4);
		yourself.
	
	graph := Graph edges: edges.	
	
	self assert: (graph edgesStartingOn: 1) size = 2.
	self assert: ((graph edgesStartingOn: 1) removeAll: (OrderedCollection 
		with: (Edge from: 1 to: 2)
		with: (Edge from: 1 to: 4)); yourself ) isEmpty.
		
	self assert: (graph edgesStartingOn: 2) size = 1.
	self assert: ((graph edgesStartingOn: 2) copyWithout: (Edge from: 2 to: 3)) isEmpty.
	
	self assert: (graph edgesStartingOn: 3) size = 1.
	self assert: ((graph edgesStartingOn: 3) copyWithout: (Edge from: 3 to: 4)) isEmpty.

	self assert: (graph edgesStartingOn: 4) size = 1.
	self assert: ((graph edgesStartingOn: 4) copyWithout: (Edge from: 4 to: 4)) isEmpty.
	
	self assert: (graph edgesStartingOn: 5) isEmpty
]
