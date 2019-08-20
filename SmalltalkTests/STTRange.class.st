"
I am a range of values representing an approximation to a number.
"
Class {
	#name : #STTRange,
	#superclass : #Object,
	#instVars : [
		'value',
		'delta'
	],
	#category : #SmalltalkTests
}

{ #category : #accessing }
STTRange class >> defaultPrecisionsForCloseToComparison [
	"This is to allow for precision of Float values."
	^ 0.0000000001
]

{ #category : #'instance creation' }
STTRange class >> value: aNumber delta: aDelta [
	^ self new value: aNumber delta: aDelta; yourself
]

{ #category : #testing }
STTRange >> contains: aValue [
	^ aValue between: self start and: self end
]

{ #category : #accessing }
STTRange >> end [
	^ value + delta
]

{ #category : #testing }
STTRange >> isRange [
	^ true
]

{ #category : #printing }
STTRange >> printOn: aStream [
	value printOn: aStream.
	aStream << '+-'.
	delta printOn: aStream
]

{ #category : #accessing }
STTRange >> start [
	^ value - delta
]

{ #category : #'instance creation' }
STTRange >> value: aNumber delta: aDelta [
	value := aNumber.
	delta := aDelta + self class defaultPrecisionsForCloseToComparison
]
