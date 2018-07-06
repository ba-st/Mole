# Installation

## Basic Installation

You can load **Mole** evaluating:
```smalltalk
Metacello new
	baseline: 'Mole';
	repository: 'github://ba-st/Mole:master/repository';
	load.
```
>  Change `master` to some released version if you want a pinned version

## Using as dependency

In order to include **Mole** as part of your project, you should reference the package in your product baseline:

```smalltalk
setUpDependencies: spec

	spec
		baseline: 'Mole'
			with: [ spec
				repository: 'github://ba-st/Mole:v{XX}/source';
				loads: #('Deployment') ];
		import: 'Mole'.
```
> Replace `{XX}` with the version you want to depend on

```smalltalk
baseline: spec

	<baseline>
	spec
		for: #common
		do: [ self setUpDependencies: spec.
			spec package: 'My-Package' with: [ spec requires: #('Mole') ] ]
```
