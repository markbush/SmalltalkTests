"
My instances represent last-in first-out collections.

Public API and Key Messages

- push
- pop
- peek
- isEmpty
- isNotEmpty
- isFull
- isNotFull

"
Class {
	#name : #STTStack,
	#superclass : #Object,
	#instVars : [
		'stack',
		'capacity'
	],
	#category : #SmalltalkTestsExample
}

{ #category : #defaults }
STTStack class >> defaultStackSize [
	^ 10
]

{ #category : #'instance creation' }
STTStack class >> withCapacity: anInteger [
	^ self new withCapacity: anInteger; yourself
]

{ #category : #initialization }
STTStack >> initialize [
	self withCapacity: self class defaultStackSize
]

{ #category : #testing }
STTStack >> isEmpty [
	"Answer if the Stack is empty."
	^ stack isEmpty
]

{ #category : #testing }
STTStack >> isFull [
	"Answer if the Stack is full."
	^ stack size = capacity
]

{ #category : #accessing }
STTStack >> peek [
	"Return the object on the top of the Stack without removing it."
	^ stack last
]

{ #category : #removing }
STTStack >> pop [
	"Remove the top object from the Stack and return it."
	^ self isEmpty
		ifTrue: [ STTStackEmptyException signal: 'cannot pop from empty Stack' ]
		ifFalse: [ stack removeLast ]
]

{ #category : #printing }
STTStack >> printOn: aStream [
	aStream << 'STTStack('.
	stack do: [ :each | each printOn: aStream ] separatedBy: [ aStream << ', ' ].
	aStream << ')'
]

{ #category : #adding }
STTStack >> push: anObject [
	"Add anObject to the top of the Stack.  If the Stack is already full, raise an exception."
	self isFull
		ifTrue: [ STTStackFullException signal: 'cannot add to full Stack' ]
		ifFalse: [ stack addLast: anObject ]
]

{ #category : #testing }
STTStack >> size [
	"Answer how many items are in the Stack"
	^ stack size
]

{ #category : #'instance creation' }
STTStack >> withCapacity: anInteger [
	"Set the capacity of this stack and reset the stack contents."
	capacity := anInteger.
	stack := OrderedCollection new
]
