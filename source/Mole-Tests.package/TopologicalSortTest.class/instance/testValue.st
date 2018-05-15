test
testValue

	"Example from http://en.wikipedia.org/wiki/Topological_sorting"

	| graph result expectedResults |

	graph :=
		Graph edges: (
			OrderedCollection new
				add: (Edge from: 7 to: 11);
				add: (Edge from: 7 to: 8);
				add: (Edge from: 11 to: 2);
				add: (Edge from: 11 to: 9);
				add: (Edge from: 11 to: 10);
				add: (Edge from: 5 to: 11);
				add: (Edge from: 3 to: 8);
				add: (Edge from: 3 to: 10);
				add: (Edge from: 8 to: 9);
				yourself).

	"Anyone of this is a valid topological sort"
	expectedResults :=
		OrderedCollection new
			add: #(3 5 7 11 8 2 9 10) asOrderedCollection;
			add: #(7 5 11 2 3 10 8 9) asOrderedCollection;
			add: #(3 7 8 5 11 10 9 2) asOrderedCollection;
			add: #(3 7 5 8 11 9 10 2) asOrderedCollection;
			add: #(3 5 7 8 11 9 2 10) asOrderedCollection;
			add: #(7 3 5 11 8 9 10 2) asOrderedCollection;
			add: #(5 7 3 11 8 10 2 9) asOrderedCollection;
			yourself.

	result := (TopologicalSort for: graph) value asOrderedCollection.

	self assert: (expectedResults anySatisfy: [:expected | expected = result])