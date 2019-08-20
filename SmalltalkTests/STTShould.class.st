"
I represent testable values. My methods provide access to all the ways that values can be tested. Instances are created by sending the method ""should"" to a block.

Values to test are stored in blocks so that they are not evaluated until they need to be tested. Methods either return a Matcher which must be sent a message to invoke a test, or they invoke a test directly. Tests do not return a useful result. Failed tests raise a TestFailedException exception.
"
Class {
	#name : #STTShould,
	#superclass : #Object,
	#instVars : [
		'evaluationBlock'
	],
	#category : #SmalltalkTests
}

{ #category : #private }
STTShould class >> classForFailure [
	^ TestFailure
]

{ #category : #private }
STTShould class >> with: aBlock [
	"Create an instance where aBlock provides the value under test. This method should not be called outside this library. Send 'should' to a block, instead."
	^self new with: aBlock; yourself
]

{ #category : #testing }
STTShould >> < aValue [
	"Tests if the contained value is less than aValue."
	| actualValue failureString |
	actualValue := self value.
	failureString := actualValue printString , ' was not less than ' , aValue printString.
	actualValue < aValue
		ifFalse: [ self classForFailure signal: failureString ].
	^ true
]

{ #category : #testing }
STTShould >> <= aValue [
	"Tests if the contained value is less than or equal to aValue."
	| actualValue failureString |
	actualValue := self value.
	failureString := actualValue printString , ' was not less than or equal to ' , aValue printString.
	actualValue <= aValue
		ifFalse: [ self classForFailure signal: failureString ].
	^ true
]

{ #category : #testing }
STTShould >> === expectation [
	"Test that the contained value is equal to (according to =) aValue using a BeMatcher (as in: [ 3 + 4 ] should equal: 7)"
	| actualValue failureString |
	actualValue := self value.
	failureString := actualValue printString , ' did not equal ' , expectation printString.
	actualValue = expectation
		ifFalse: [ self classForFailure signal: failureString ].
	^ true
]

{ #category : #testing }
STTShould >> > aValue [
	"Tests if the contained value is greater than aValue."
	| actualValue failureString |
	actualValue := self value.
	failureString := actualValue printString , ' was not greater than ' , aValue printString.
	actualValue > aValue
		ifFalse: [ self classForFailure signal: failureString ].
	^ true
]

{ #category : #testing }
STTShould >> >= aValue [
	"Tests if the contained value is greater than or equal to aValue."
	| actualValue failureString |
	actualValue := self value.
	failureString := actualValue printString , ' was not greater than or equal to ' , aValue printString.
	actualValue >= aValue
		ifFalse: [ self classForFailure signal: failureString ].
	^ true
]

{ #category : #testing }
STTShould >> a: expectation [
	"If value is a Class, check that the contained value conforms to the class, otherwise, check that a boolean property is true (as in: [ #hello ] should be a: Symbol). If value is not recognised by the value under test as a method, try adding is and capitalising (as in: [ 4.5 ] should be a: #float)."
	| actualValue failureString |
	actualValue := self value.
	failureString := actualValue printString , ' was not a ' , expectation printString.
	expectation isSymbol ifTrue: [ | isMethod |
		(actualValue respondsTo: expectation)
			ifTrue: [
				(actualValue perform: expectation)
					ifTrue: [ ^ true ]
					ifFalse: [ self classForFailure signal: failureString ]
			].
		isMethod := ('is' , expectation first asUppercase asString , expectation allButFirst) asSymbol.
		(actualValue respondsTo: isMethod)
			ifTrue: [
				(actualValue perform: isMethod)
					ifTrue: [ ^ true ]
					ifFalse: [ self classForFailure signal: failureString ]
			]
	].
	"If not a property, it should be a class"
	(actualValue isKindOf: expectation)
		ifFalse: [ self classForFailure signal: failureString ].
	^ true
]

{ #category : #testing }
STTShould >> allOf: aCollection [
	"Test that the value contains all of the elements of aCollection."
	| actualValue expectedSet occurrences failureString |
	actualValue := self value.
	expectedSet := aCollection asSet.
	failureString := actualValue printString , ' did not contain all of ' , aCollection printString.
	occurrences := (expectedSet select: [ :item | actualValue includes: item]) size.
	occurrences = expectedSet size
		ifFalse: [ self classForFailure signal: failureString ].
	^ true
]

{ #category : #testing }
STTShould >> an: expectation [
	"If value is a Class, check that the contained value conforms to the class, otherwise, check that a boolean property is true (as in: [ #hello ] should be a: Symbol). If value is not recognised by the value under test as a method, try adding is and capitalising (as in: [ 4.5 ] should be a: #float)."
	| actualValue failureString |
	actualValue := self value.
	failureString := actualValue printString , ' was not an ' , expectation printString.
	expectation isSymbol ifTrue: [ | isMethod |
		(actualValue respondsTo: expectation)
			ifTrue: [
				(actualValue perform: expectation)
					ifTrue: [ ^ true ]
					ifFalse: [ self classForFailure signal: failureString ]
			].
		isMethod := ('is' , expectation first asUppercase asString , expectation allButFirst) asSymbol.
		(actualValue respondsTo: isMethod)
			ifTrue: [
				(actualValue perform: isMethod)
					ifTrue: [ ^ true ]
					ifFalse: [ self classForFailure signal: failureString ]
			]
	].
	"If not a property, it should be a class"
	(actualValue isKindOf: expectation)
		ifFalse: [ self classForFailure signal: failureString ].
	^ true
]

{ #category : #testing }
STTShould >> atLeastOneOf: aCollection [
	"Test that the value contains at least one of the elements of aCollection."
	| actualValue occurrences failureString |
	actualValue := self value.
	failureString := actualValue printString , ' did not contain at least one of ' , aCollection printString.
	occurrences := (aCollection asSet select: [ :item | actualValue includes: item]) size.
	occurrences >= 1
		ifFalse: [ self classForFailure signal: failureString ].
	^ true
]

{ #category : #testing }
STTShould >> atMostOneOf: aCollection [
	"Test that the value contains at most one of the elements of aCollection."
	| actualValue occurrences failureString |
	actualValue := self value.
	failureString := actualValue printString , ' did not contain at most one of ' , aCollection printString.
	occurrences := (aCollection asSet select: [ :item | actualValue includes: item]) size.
	occurrences <= 1
		ifFalse: [ self classForFailure signal: failureString ].
	^ true
]

{ #category : #testing }
STTShould >> be [
	"Utility."
	^ self
]

{ #category : #testing }
STTShould >> be: expectation [
	"Test the contained value against expectation. expectation should be a Symbol or a Range, otherwise the values will be tested for equality. If it is a Symbol, I will look for a method of that name (or one with 'is' prepended after being capitalised) and expect the result to be a boolean (as in: [ Array new ] should be: #empty). If expectation is a Range, I will check that the contained value is in the given Range, inclusive (as in: [ 5.4 ] should be: 5.5 +- 0.1) which can be used to test values where there is some tolerance in the allowed value. To test a Symbol for equality, use equals: "
	| actualValue failureString |
	actualValue := self value.
	failureString := actualValue printString , ' was not ' , expectation printString.
	expectation isSymbol ifTrue: [ | isMethod |
		(actualValue respondsTo: expectation)
			ifTrue: [
				(actualValue perform: expectation)
					ifTrue: [ ^ true ]
					ifFalse: [ self classForFailure signal: failureString ]
			].
		isMethod := ('is' , expectation first asUppercase asString , expectation allButFirst) asSymbol.
		(actualValue perform: isMethod)
			ifTrue: [ ^ true ]
			ifFalse: [ self classForFailure signal: failureString ]
	].
	expectation isRange ifTrue: [
		(expectation contains: actualValue)
			ifTrue: [ ^ true ]
			ifFalse: [ self classForFailure signal: failureString ]
	].
	"Otherwise, just test equality."
	actualValue = expectation
		ifFalse: [ self classForFailure signal: failureString ].
	^ true
]

{ #category : #private }
STTShould >> classForFailure [
	^ self class classForFailure
]

{ #category : #testing }
STTShould >> contain [
	"Utility."
	^ self
]

{ #category : #testing }
STTShould >> contain: aValue [
	"Test that the contained collection includes aValue as an element."
	| actualValue failureString |
	actualValue := self value.
	failureString := actualValue printString , ' did not contain ' , aValue printString.
	(actualValue includes: aValue)
		ifFalse: [ self classForFailure signal: failureString ].
	^ true
]

{ #category : #testing }
STTShould >> empty [
	"Tests if the contained value is empty. The value must respond to either #empty or #isEmpty for this test to work."
	| actualValue failureString |
	actualValue := self value.
	failureString := actualValue printString , ' was not empty'.
	actualValue isEmpty
		ifFalse: [ self classForFailure signal: failureString ].
	^ true
]

{ #category : #testing }
STTShould >> endWith: aString [
	"Test that the contained string ends with aString."
	| actualValue failureString |
	actualValue := self value.
	failureString := actualValue printString , ' did not end with ' , aString printString.
	(actualValue endsWith: aString)
		ifFalse: [ self classForFailure signal: failureString ].
	^ true
]

{ #category : #testing }
STTShould >> endWithRegex: aPattern [
	"Test that the regular expression aPattern matches at the end of the contained string."
	| actualValue anchoredPattern failureString |
	actualValue := self value.
	anchoredPattern := '.*' , aPattern , '$'.
	failureString := actualValue printString , ' did not end with a match of ' , aPattern printString.
	(anchoredPattern asRegex matches: actualValue)
		ifFalse: [ self classForFailure signal: failureString ].
	^ true
]

{ #category : #testing }
STTShould >> endWithRegex: aPattern withGroups: groups [
	"Test that the regular expression aPattern matches at the end of the contained string and that the array groups contains any captured groups in aPattern (as in: [ 'Hello, world' ] should endWithRegex: '(W.*d)' withGroups: #('World')). NOTE: due to the greedy RE implementation, it is not possible to get a longest wildcard match at the start of an endsWith match."
	| actualValue regex groupsMatch failureString |
	actualValue := self value.
	regex := ('.*' , aPattern , '$') asRegex.
	groupsMatch := [
		regex subexpressionCount - 1 = groups size and: [
			(1 to: groups size) allSatisfy: [ :i | (regex subexpression: i + 1) = (groups at: i) ]
		]
	].
	failureString := actualValue printString , ' did not end with a match of ' , aPattern printString , ' with groups ' , groups printString.
	((regex matches: actualValue) and: groupsMatch)
		ifFalse: [ self classForFailure signal: failureString ].
	^ true
]

{ #category : #testing }
STTShould >> equal: expectation [
	"Test that the contained value is equal to (according to =) aValue using a BeMatcher (as in: [ 3 + 4 ] should equal: 7)"
	| actualValue failureString |
	actualValue := self value.
	failureString := actualValue printString , ' did not equal ' , expectation printString.
	actualValue = expectation
		ifFalse: [ self classForFailure signal: failureString ].
	^ true
]

{ #category : #testing }
STTShould >> fullyMatch: aPattern [
	"Test that the regular expression aPattern exactly matches the contained string."
	| actualValue failureString |
	actualValue := self value.
	failureString := actualValue printString , ' did not fully match ' , aPattern printString.
	(aPattern asRegex matches: actualValue)
		ifFalse: [ self classForFailure signal: failureString ].
	^ true
]

{ #category : #testing }
STTShould >> fullyMatch: aPattern withGroups: groups [
	"Test that the regular expression aPattern exactly matches the contained string and that the array groups contains any captured groups in aPattern (as in: [ 'Hello, world' ] should fullyMatch: '(\w+), (\w+)' withGroups: #('Hello' 'world'))."
	| actualValue regex groupsMatch failureString |
	actualValue := self value.
	regex := aPattern  asRegex.
	groupsMatch := [
		regex subexpressionCount - 1 = groups size and: [
			(1 to: groups size) allSatisfy: [ :i | (regex subexpression: i + 1) = (groups at: i) ]
		]
	].
	failureString := actualValue printString , ' did not fully match ' , aPattern printString , ' with groups ' , groups printString.
	((regex matches: actualValue) and: groupsMatch)
		ifFalse: [ self classForFailure signal: failureString ].
	^ true
]

{ #category : #testing }
STTShould >> have [
	"Utility."
	^ self
]

{ #category : #testing }
STTShould >> have: properties [
	"Test that some properties of the contained value have specified values. The properties should be a collection of Associations, or a Dictionary where the keys are Symbols representing properties of the value under test and the values are the expected values of those properties (as in: [ #(1 2 3) ] should have: { #size->3 . #isEmpty->false }"
	| testObject propertyMap failedKeys failedValues expectedValues |
	testObject := self value.
	propertyMap := properties asDictionary.
	failedKeys := OrderedCollection new.
	failedValues := OrderedCollection new.
	expectedValues := OrderedCollection new.
	propertyMap keysAndValuesDo: [ :property :expectedValue | | actualValue |
		actualValue := testObject perform: property.
		actualValue = expectedValue
			ifFalse: [
				failedKeys add: property.
				failedValues add: actualValue.
				expectedValues add: expectedValue
			]
	].
	failedKeys isEmpty
		ifFalse: [ | failureString |
			failureString := 'Failed keys: ' , failedKeys asArray printString , ' had values: ' , failedValues asArray printString , ' but expected: ' , expectedValues asArray printString.
			self classForFailure signal: failureString
		].
	^ true
]

{ #category : #testing }
STTShould >> include: aString [
	"Test that the contained string includes aString."
	| actualValue failureString |
	actualValue := self value.
	failureString := actualValue printString , ' did not include ' , aString printString.
	(actualValue indexOfSubCollection: aString) > 0
		ifFalse: [ self classForFailure signal: failureString ].
	^ true
]

{ #category : #testing }
STTShould >> includeRegex: aPattern [
	"Test that the regular expression aPattern matches the contained string."
	| actualValue anchoredPattern failureString |
	actualValue := self value.
	anchoredPattern := '.*' , aPattern , '.*'.
	failureString := actualValue printString , ' did not include a match of ' , aPattern printString.
	(anchoredPattern asRegex matches: actualValue)
		ifFalse: [ self classForFailure signal: failureString ].
	^ true
]

{ #category : #testing }
STTShould >> includeRegex: aPattern withGroups: groups [
	"Test that the regular expression aPattern matches the contained string and that the array groups contains any captured groups in aPattern (as in: [ 'Hello, world' ] should includeRegex: '(l+o)' withGroups: #('llo')). NOTE: due to the greedy RE implementation, it is not possible to get a longest wildcard match at the start of an includes match."
	| actualValue regex groupsMatch failureString |
	actualValue := self value.
	regex := ('.*' , aPattern , '.*') asRegex.
	groupsMatch := [
		regex subexpressionCount - 1 = groups size and: [
			(1 to: groups size) allSatisfy: [ :i | (regex subexpression: i + 1) = (groups at: i) ]
		]
	].
	failureString := actualValue printString , ' did not include a match of ' , aPattern printString , ' with groups ' , groups printString.
	((regex matches: actualValue) and: groupsMatch)
		ifFalse: [ self classForFailure signal: failureString ].
	^ true
]

{ #category : #testing }
STTShould >> key: aKey [
	"Test that the value contains the key aKey."
	| actualValue failureString |
	actualValue := self value.
	failureString := actualValue printString , ' did not contain key ' , aKey printString.
	(actualValue includesKey: aKey)
		ifFalse: [ self classForFailure signal: failureString ].
	^ true
]

{ #category : #testing }
STTShould >> noneOf: aCollection [
	"Test that the value contains none of the elements of aCollection."
	| actualValue occurrences failureString |
	actualValue := self value.
	failureString := actualValue printString , ' did not contain none of ' , aCollection printString.
	occurrences := (aCollection asSet select: [ :item | actualValue includes: item]) size.
	occurrences = 0
		ifFalse: [ self classForFailure signal: failureString ].
	^ true
]

{ #category : #testing }
STTShould >> not [
	"Negate the sense of any test that is applied to the contained value."
	^ STTShouldNot new with: evaluationBlock; yourself
]

{ #category : #testing }
STTShould >> oneOf: aCollection [
	"Test that the value contains exactly one of the elements of aCollection."
	| actualValue occurrences failureString |
	actualValue := self value.
	failureString := actualValue printString , ' did not contain one of ' , aCollection printString.
	occurrences := (aCollection asSet select: [ :item | actualValue includes: item]) size.
	occurrences = 1
		ifFalse: [ self classForFailure signal: failureString ].
	^ true
]

{ #category : #testing }
STTShould >> only: aCollection [
	"Test that the value only contains elements of aCollection, though it may contain more than one of each."
	| actualValue expectedSet occurrences failureString |
	actualValue := self value.
	expectedSet := aCollection asSet.
	failureString := actualValue printString , ' did not contain only ' , aCollection printString.
	occurrences := (expectedSet select: [ :item | actualValue includes: item]) size.
	(occurrences = expectedSet size and: [ occurrences = actualValue asSet size ])
		ifFalse: [ self classForFailure signal: failureString ].
	^ true
]

{ #category : #testing }
STTShould >> size: expectation [
	"Tests that the contained value has size expectation. I will use the #size method to check this."
	| actualValue actualSize failureString |
	actualValue := self value.
	actualSize := actualValue size.
	failureString := actualValue printString , ' had size ' , actualSize printString , ' instead of ' , expectation printString.
	actualSize = expectation
		ifFalse: [ self classForFailure signal: failureString ].
	^ true
]

{ #category : #testing }
STTShould >> startWith: aString [
	"Test that the contained string starts with aString."
	| actualValue failureString |
	actualValue := self value.
	failureString := actualValue printString , ' did not start with ' , aString printString.
	(actualValue beginsWith: aString)
		ifFalse: [ self classForFailure signal: failureString ].
	^ true
]

{ #category : #testing }
STTShould >> startWithRegex: aPattern [
	"Test that the regular expression aPattern matches at the start of the contained string."
	| actualValue failureString |
	actualValue := self value.
	failureString := actualValue printString , ' did not start with a match of ' , aPattern printString.
	(aPattern asRegex matchesPrefix: actualValue)
		ifFalse: [ self classForFailure signal: failureString ].
	^ true
]

{ #category : #testing }
STTShould >> startWithRegex: aPattern withGroups: groups [
	"Test that the regular expression aPattern matches at the start of the contained string and that the array groups contains any captured groups in aPattern (as in: [ 'Hello, world' ] should startWithRegex: '(Hel+)' withGroups: #('Hell'))."
	| actualValue regex groupsMatch failureString |
	actualValue := self value.
	regex := aPattern asRegex.
	groupsMatch := [
		regex subexpressionCount - 1 = groups size and: [
			(1 to: groups size) allSatisfy: [ :i | (regex subexpression: i + 1) = (groups at: i) ]
		]
	].
	failureString := actualValue printString , ' did not start with a match of ' , aPattern printString , ' with groups ' , groups printString.
	((regex matchesPrefix: actualValue) and: groupsMatch)
		ifFalse: [ self classForFailure signal: failureString ].
	^ true
]

{ #category : #testing }
STTShould >> theSameElementsAs: aCollection [
	"Test that the value contains the same elements as aCollection."
	| actualValue failureString |
	actualValue := self value.
	failureString := actualValue printString , ' did not contain the same elements as ' , aCollection printString.
	actualValue asArray sorted = aCollection asArray sorted
		ifFalse: [ self classForFailure signal: failureString ].
	^ true
]

{ #category : #testing }
STTShould >> theSameElementsInOrderAs: aCollection [
	"Test that the value contains the same elements as aCollection and that they are in the same order."
	| actualValue failureString |
	actualValue := self value.
	failureString := actualValue printString , ' did not contain the same elements in order as ' , aCollection printString.
	actualValue asArray = aCollection asArray
		ifFalse: [ self classForFailure signal: failureString ].
	^ true
]

{ #category : #testing }
STTShould >> theSameInstanceAs: expectation [
	"Tests if the contained value is exactly the same object as the expected value. This test uses == to perform the check, so any objects that show as == to each other will be considered to be the same instance for this test."
	| actualValue failureString |
	actualValue := self value.
	failureString := actualValue printString , ' was not the same instance as ' , expectation printString.
	actualValue == expectation
		ifFalse: [ self classForFailure signal: failureString ].
	^ true
]

{ #category : #testing }
STTShould >> throw: anException [
	"Tests if the contained value is exactly the same object as the expected value. This test uses == to perform the check, so any objects that show as == to each other will be considered to be the same instance for this test."
	| result noExceptionFailureString |
	noExceptionFailureString := 'Expected exception ' , anException printString , ' to be thrown, but no exception was thrown.'.
	result := [ self value. false ]
		on: Exception
		do: [ :sig |
			(sig isKindOf: anException)
				ifTrue: [ sig return: true ]
				ifFalse: [ | wrongExceptionFailureString |
					wrongExceptionFailureString := 'Expected exception ' , anException printString , ' to be thrown, but ' , sig class printString , ' was thrown.'.
					self classForFailure signal: wrongExceptionFailureString
				]
		].
	result
		ifFalse: [ self classForFailure signal: noExceptionFailureString ].
	^ true
]

{ #category : #private }
STTShould >> value [
	"Evaluates and returns the value under test."
	^ evaluationBlock value
]

{ #category : #testing }
STTShould >> value: aValue [
	"Test that the value contains the value aValue."
	| actualValue failureString |
	actualValue := self value.
	failureString := actualValue printString , ' did not contain value ' , aValue printString.
	(actualValue includes: aValue)
		ifFalse: [ self classForFailure signal: failureString ].
	^ true
]

{ #category : #private }
STTShould >> with: aBlock [
	"Initialise this instance with the value under test."
	evaluationBlock := aBlock
]
