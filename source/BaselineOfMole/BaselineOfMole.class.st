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
		for: #pharo
		do: [ self
				setUpDependencies: spec;
				baselineMole: spec.
			spec
				group: 'CI' with: 'Tests';
				group: 'Tools' with: 'Buoy-Tools';
				group: 'Development' with: #('Tests' 'Tools')
			]
]

{ #category : #baselines }
BaselineOfMole >> baselineMole: spec [

	spec
		package: 'Mole' with: [ spec requires: 'Buoy-Deployment' ];
		group: 'Deployment' with: #('Mole');
		package: 'Mole-Tests' with: [ spec requires: #('Mole' 'Buoy-SUnit') ];
		group: 'Tests' with: #('Mole-Tests')
]

{ #category : #baselines }
BaselineOfMole >> projectClass [

	^ MetacelloCypressBaselineProject
]

{ #category : #initialization }
BaselineOfMole >> setUpDependencies: spec [

	spec
		baseline: 'Buoy' with: [ spec repository: 'github://ba-st/Buoy:v5/source' ];
		project: 'Buoy-Deployment' copyFrom: 'Buoy' with: [ spec loads: 'Deployment' ];
		project: 'Buoy-SUnit' copyFrom: 'Buoy' with: [ spec loads: 'Dependent-SUnit-Extensions' ];
		project: 'Buoy-Tools' copyFrom: 'Buoy' with: [ spec loads: 'Tools' ].
]
