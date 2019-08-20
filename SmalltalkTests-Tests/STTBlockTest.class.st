Class {
	#name : #STTBlockTest,
	#superclass : #TestCase,
	#category : #'SmalltalkTests-Tests'
}

{ #category : #testing }
STTBlockTest >> testBlockShouldCreatesSTTShould [
	| s |
	s := [ 1 + 1 ] should.
	self assert: s class equals: STTShould.
	s := [ 1 + 1 ] must.
	self assert: s class equals: STTShould.
	s := [ 1 + 1 ] should not.
	self assert: s class equals: STTShouldNot
]
