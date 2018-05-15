accessing - private
apply: aOneArgBlock usingDepthFirstSearchFrom: aNode ignoring: aSet

	^self
		apply: aOneArgBlock
		usingDepthFirstSearchFrom: aNode
		ignoring: aSet
		ifCycleEncounteredDo: []