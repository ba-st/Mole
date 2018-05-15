test
testCreateGraphWithoutEdges

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