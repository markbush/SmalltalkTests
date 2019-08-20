"
This class contains tests
"
Class {
	#name : #STTStackTest,
	#superclass : #TestCase,
	#category : #SmalltalkTestsExample
}

{ #category : #testing }
STTStackTest >> testEmptyStack [
	| s |
	s := STTStack new.
	[ s ] should be empty.
	[ s ] should have size: 0.
	[ s ] should not be: #full.
	[ s pop ] should throw: STTStackEmptyException
]

{ #category : #testing }
STTStackTest >> testFullStack [
	| s |
	s := STTStack withCapacity: 3.
	s push: 1; push: 2; push: 3.
	[ s ] should be: #full.
	[ s ] should not be empty.
	[ s ] should have size: 3.
	[ s push: 4 ] should throw: STTStackFullException
]

{ #category : #testing }
STTStackTest >> testPartFullStack [
	| s |
	s := STTStack new.
	s push: 1; push: 2.
	[ s ] should not be empty.
	[ s ] should have size: 2.
	[ s ] should not be: #full
]

{ #category : #testing }
STTStackTest >> testStackIsLastInFirstOut [
	| s |
	s := STTStack new.
	s push: 1; push: 2.
	[ s ] should have size: 2.
	[ s pop ] should equal: 2.
	[ s ] should have size: 1.
	[ s pop ] should equal: 1.
	[ s ] should be: #empty
]

{ #category : #testing }
STTStackTest >> testStackShouldPeekLastItem [
	| s |
	s := STTStack new.
	s push: 1; push: 2.
	[ s ] should have size: 2.
	[ s peek ] should equal: 2.
	[ s ] should have size: 2.
	[ s pop ] should equal: 2
]
