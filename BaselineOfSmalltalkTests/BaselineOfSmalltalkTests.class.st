Class {
	#name : #BaselineOfSmalltalkTests,
	#superclass : #BaselineOf,
	#category : #BaselineOfSmalltalkTests
}

{ #category : #baselines }
BaselineOfSmalltalkTests >> baseline: spec [
	<baseline>
	spec for: #common do: [
		spec
			package: 'SmalltalkTests';
			package: 'SmalltalkTests-Tests' with: [ spec requires: #('SmalltalkTests')];
			package: 'SmalltalkTestsExample' with: [ spec requires: #('SmalltalkTests')].
		spec
			group: 'Core' with: #('SmalltalkTests');
			group: 'Tests' with: #('SmalltalkTests-Tests');
			group: 'Examples' with: #('SmalltalkTestsExample');
			group: 'default' with: #('Core' 'Tests');
			group: 'full' with: #('default' 'Examples')
	]
]
