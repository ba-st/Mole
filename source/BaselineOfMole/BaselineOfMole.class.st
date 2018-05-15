Class {
	#name : #BaselineOfMole,
	#superclass : #BaselineOf,
	#category : #BaselineOfMole
}

{ #category : #baselines }
BaselineOfMole >> baseline: spec [

	<baseline>
	spec
		for: #common
		do: [ spec blessing: #baseline.
			spec
				package: 'Mole';
				package: 'Mole-Tests' with: [ spec requires: 'Mole' ].
			spec
				group: 'Deployment' with: #('Mole');
				group: 'Development' with: #('Mole-Tests');
				group: 'default' with: #('Deployment') ]
]
