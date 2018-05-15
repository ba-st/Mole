accessing - private
apply: aOneArgBlock usingDepthFirstSearchFrom: aNode ignoring: aSet ifCycleEncounteredDo: aBlock

	| nonVisitedNodes adjacentNodes |

	aOneArgBlock value: aNode.

	aSet add: aNode.

	adjacentNodes := self nodesAdjacentTo: aNode.
	nonVisitedNodes := adjacentNodes reject: [:adjacentNode | aSet includes: adjacentNode].

	(adjacentNodes size = nonVisitedNodes size) ifFalse: [aBlock].

	nonVisitedNodes do: [:nonVisitedNode |
		self
			apply: aOneArgBlock
			usingDepthFirstSearchFrom: nonVisitedNode
			ignoring: aSet
			ifCycleEncounteredDo: aBlock]