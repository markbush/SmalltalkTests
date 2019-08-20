Extension { #name : #Number }

{ #category : #'*SmalltalkTests' }
Number >> +- delta [
	^ STTRange value: self delta: delta
]
