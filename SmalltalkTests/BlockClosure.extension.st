Extension { #name : #BlockClosure }

{ #category : #'*SmalltalkTests' }
BlockClosure >> must [
	"Allow blocks to generate test cases."
	^ STTShould with: self
]

{ #category : #'*SmalltalkTests' }
BlockClosure >> should [
	"Allow blocks to generate test cases."
	^ STTShould with: self
]
