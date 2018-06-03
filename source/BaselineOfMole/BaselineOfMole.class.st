"
I'm the baseline of Mole
"
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
			self setUpDependencies: spec.
			spec
				package: 'Mole' with: [ spec requires: 'Buoy' ];
				package: 'Mole-Tests' with: [ spec requires: 'Mole' ].
			spec
				group: 'Deployment' with: #('Mole');
				group: 'Development' with: #('Mole-Tests');
				group: 'default' with: #('Deployment') ]
]

{ #category : #initialization }
BaselineOfMole >> setUpDependencies: spec [

	spec
		baseline: 'Buoy' with: [ spec repository: 'github://ba-st/Buoy:v4/source' ];
		import: 'Buoy'
]
