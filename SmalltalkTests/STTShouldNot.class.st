"
I represent negated test values.  Not matching causes a test pass.
"
Class {
	#name : #STTShouldNot,
	#superclass : #STTShould,
	#category : #SmalltalkTests
}

{ #category : #testing }
STTShouldNot >> < aValue [
	"Tests if the contained value is not less than aValue."
	| actualValue failureString |
	actualValue := self value.
	failureString := actualValue printString , ' was less than ' , aValue printString.
	actualValue < aValue
		ifTrue: [ self classForFailure signal: failureString ].
	^ true
]

{ #category : #testing }
STTShouldNot >> <= aValue [
	"Tests if the contained value is not less than or equal to aValue."
	| actualValue failureString |
	actualValue := self value.
	failureString := actualValue printString , ' was less than or equal to ' , aValue printString.
	actualValue <= aValue
		ifTrue: [ self classForFailure signal: failureString ].
	^ true
]

{ #category : #testing }
STTShouldNot >> === expectation [
	"Test that the contained value is not equal to (according to ~=) aValue using a BeMatcher (as in: [ 3 + 4 ] should not equal: 8)"
	| actualValue failureString |
	actualValue := self value.
	failureString := actualValue printString , ' equaled ' , expectation printString.
	actualValue ~= expectation
		ifFalse: [ self classForFailure signal: failureString ].
	^ true
]

{ #category : #testing }
STTShouldNot >> > aValue [
	"Tests if the contained value is not greater than aValue."
	| actualValue failureString |
	actualValue := self value.
	failureString := actualValue printString , ' was greater than ' , aValue printString.
	actualValue > aValue
		ifTrue: [ self classForFailure signal: failureString ].
	^ true
]

{ #category : #testing }
STTShouldNot >> >= aValue [
	"Tests if the contained value is not greater than or equal to aValue."
	| actualValue failureString |
	actualValue := self value.
	failureString := actualValue printString , ' was greater than or equal to ' , aValue printString.
	actualValue >= aValue
		ifTrue: [ self classForFailure signal: failureString ].
	^ true
]

{ #category : #testing }
STTShouldNot >> a: expectation [
	"If value is a Class, check that the contained value doesn't conform to the class, otherwise, check that a boolean property is not true (as in: [ #hello ] should not be a: String). If value is not recognised by the value under test as a method, try adding is and capitalising (as in: [ 4 ] should not be a: #float)."
	| actualValue failureString |
	actualValue := self value.
	failureString := actualValue printString , ' was a ' , expectation printString.
	expectation isSymbol ifTrue: [ | isMethod |
		(actualValue respondsTo: expectation)
			ifTrue: [
				(actualValue perform: expectation) not
					ifTrue: [ ^ true ]
					ifFalse: [ self classForFailure signal: failureString ]
			].
		isMethod := ('is' , expectation first asUppercase asString , expectation allButFirst) asSymbol.
		(actualValue respondsTo: isMethod)
			ifTrue: [
				(actualValue perform: isMethod) not
					ifTrue: [ ^ true ]
					ifFalse: [ self classForFailure signal: failureString ]
			]
	].
	"If not a property, it should be a class"
	(actualValue isKindOf: expectation) not
		ifFalse: [ self classForFailure signal: failureString ].
	^ true
]

{ #category : #testing }
STTShouldNot >> allOf: aCollection [
	"Test that the value does not contain all of the elements of aCollection."
	| actualValue expectedSet occurrences failureString |
	actualValue := self value.
	expectedSet := aCollection asSet.
	failureString := actualValue printString , ' contained all of ' , aCollection printString.
	occurrences := (expectedSet select: [ :item | actualValue includes: item]) size.
	occurrences = expectedSet size
		ifTrue: [ self classForFailure signal: failureString ].
	^ true
]

{ #category : #testing }
STTShouldNot >> an: expectation [
	"If value is a Class, check that the contained value doesn't conform to the class, otherwise, check that a boolean property is not true (as in: [ #hello ] should not be a: String). If value is not recognised by the value under test as a method, try adding is and capitalising (as in: [ 4 ] should not be a: #float)."
	| actualValue failureString |
	actualValue := self value.
	failureString := actualValue printString , ' was an ' , expectation printString.
	expectation isSymbol ifTrue: [ | isMethod |
		(actualValue respondsTo: expectation)
			ifTrue: [
				(actualValue perform: expectation) not
					ifTrue: [ ^ true ]
					ifFalse: [ self classForFailure signal: failureString ]
			].
		isMethod := ('is' , expectation first asUppercase asString , expectation allButFirst) asSymbol.
		(actualValue respondsTo: isMethod)
			ifTrue: [
				(actualValue perform: isMethod) not
					ifTrue: [ ^ true ]
					ifFalse: [ self classForFailure signal: failureString ]
			]
	].
	"If not a property, it should be a class"
	(actualValue isKindOf: expectation) not
		ifFalse: [ self classForFailure signal: failureString ].
	^ true
]

{ #category : #testing }
STTShouldNot >> atLeastOneOf: aCollection [
	"Test that the value does not contain at least one of the elements of aCollection."
	| actualValue occurrences failureString |
	actualValue := self value.
	failureString := actualValue printString , ' contained at least one of ' , aCollection printString.
	occurrences := (aCollection asSet select: [ :item | actualValue includes: item]) size.
	occurrences >= 1
		ifTrue: [ self classForFailure signal: failureString ].
	^ true
]

{ #category : #testing }
STTShouldNot >> atMostOneOf: aCollection [
	"Test that the value does not contain at most one of the elements of aCollection."
	| actualValue occurrences failureString |
	actualValue := self value.
	failureString := actualValue printString , ' contained at most one of ' , aCollection printString.
	occurrences := (aCollection asSet select: [ :item | actualValue includes: item]) size.
	occurrences <= 1
		ifTrue: [ self classForFailure signal: failureString ].
	^ true
]

{ #category : #testing }
STTShouldNot >> be: expectation [
	"Test the contained value against expectation. expectation should be a Symbol or a Range, otherwise the values will be tested for inequality. If it is a Symbol, I will look for a method of that name (or one with 'is' prepended after being capitalised) and expect the result to be a boolean (as in: [ Array new ] should not be: #empty). If expectation is a Range, I will check that the contained value is in the given Range, inclusive (as in: [ 5.4 ] should not be: 5.5 +- 0.1) which can be used to test values where there is some tolerance in the allowed value. To test a Symbol for inequality, use equals: "
	| actualValue failureString |
	actualValue := self value.
	failureString := actualValue printString , ' was ' , expectation printString.
	expectation isSymbol ifTrue: [ | isMethod |
		(actualValue respondsTo: expectation)
			ifTrue: [
				(actualValue perform: expectation) not
					ifTrue: [ ^ true ]
					ifFalse: [ self classForFailure signal: failureString ]
			].
		isMethod := ('is' , expectation first asUppercase asString , expectation allButFirst) asSymbol.
		(actualValue perform: isMethod) not
			ifTrue: [ ^ true ]
			ifFalse: [ self classForFailure signal: failureString ]
	].
	expectation isRange ifTrue: [
		(expectation contains: actualValue) not
			ifTrue: [ ^ true ]
			ifFalse: [ self classForFailure signal: failureString ]
	].
	"Otherwise, just test equality."
	actualValue ~= expectation
		ifFalse: [ self classForFailure signal: failureString ].
	^ true
]

{ #category : #testing }
STTShouldNot >> contain: aValue [
	"Test that the contained collection does not include aValue as an element."
	| actualValue failureString |
	actualValue := self value.
	failureString := actualValue printString , ' contained ' , aValue printString.
	(actualValue includes: aValue)
		ifTrue: [ self classForFailure signal: failureString ].
	^ true
]

{ #category : #testing }
STTShouldNot >> empty [
	"Tests if the contained value is not empty. The value must respond to either #empty or #isEmpty for this test to work."

	| actualValue failureString |
	actualValue := self value.
	failureString := actualValue printString , ' was empty'.
	actualValue isEmpty
		ifTrue: [ self classForFailure signal: failureString ].
	^ true
]

{ #category : #testing }
STTShouldNot >> endWith: aString [
	"Test that the contained string does not end with aString."
	| actualValue failureString |
	actualValue := self value.
	failureString := actualValue printString , ' ended with ' , aString printString.
	(actualValue endsWith: aString)
		ifTrue: [ self classForFailure signal: failureString ].
	^ true
]

{ #category : #testing }
STTShouldNot >> endWithRegex: aPattern [
	"Test that the regular expression aPattern does not match at the end of the contained string."
	| actualValue anchoredPattern failureString |
	actualValue := self value.
	anchoredPattern := '.*' , aPattern , '$'.
	failureString := actualValue printString , ' ended with a match of ' , aPattern printString.
	(anchoredPattern asRegex matches: actualValue)
		ifTrue: [ self classForFailure signal: failureString ].
	^ true
]

{ #category : #testing }
STTShouldNot >> endWithRegex: aPattern withGroups: groups [
	"Test that the regular expression aPattern does not match at the end of the contained string and that the array groups does not contains all captured groups in aPattern (as in: [ 'Hello, world' ] should not endWithRegex: '(W.d)' withGroups: #('World')). NOTE: due to the greedy RE implementation, it is not possible to get a longest wildcard match at the start of an endsWith match."
	| actualValue regex groupsMatch failureString |
	actualValue := self value.
	regex := ('.*' , aPattern , '$') asRegex.
	groupsMatch := [
		regex subexpressionCount - 1 = groups size and: [
			(1 to: groups size) allSatisfy: [ :i | (regex subexpression: i + 1) = (groups at: i) ]
		]
	].
	failureString := actualValue printString , ' ended with a match of ' , aPattern printString , ' with groups ' , groups printString.
	((regex matches: actualValue) and: groupsMatch)
		ifTrue: [ self classForFailure signal: failureString ].
	^ true
]

{ #category : #testing }
STTShouldNot >> equal: expectation [
	"Test that the contained value is not equal to (according to ~=) aValue using a BeMatcher (as in: [ 3 + 4 ] should not equal: 8)"
	| actualValue failureString |
	actualValue := self value.
	failureString := actualValue printString , ' equaled ' , expectation printString.
	actualValue ~= expectation
		ifFalse: [ self classForFailure signal: failureString ].
	^ true
]

{ #category : #testing }
STTShouldNot >> fullyMatch: aPattern [
	"Test that the regular expression aPattern does not exactly match the contained string."
	| actualValue failureString |
	actualValue := self value.
	failureString := actualValue printString , ' fully matched ' , aPattern printString.
	(aPattern asRegex matches: actualValue)
		ifTrue: [ self classForFailure signal: failureString ].
	^ true
]

{ #category : #testing }
STTShouldNot >> fullyMatch: aPattern withGroups: groups [
	"Test that the regular expression aPattern does not exactly match the contained string and that the array groups do not contain all captured groups in aPattern (as in: [ 'Hello, world' ] should fullyMatch: '(\w+), (\w+)' withGroups: #('Hello' 'world'))."
	| actualValue regex groupsMatch failureString |
	actualValue := self value.
	regex := aPattern  asRegex.
	groupsMatch := [
		regex subexpressionCount - 1 = groups size and: [
			(1 to: groups size) allSatisfy: [ :i | (regex subexpression: i + 1) = (groups at: i) ]
		]
	].
	failureString := actualValue printString , ' fully matched ' , aPattern printString , ' with groups ' , groups printString.
	((regex matches: actualValue) and: groupsMatch)
		ifTrue: [ self classForFailure signal: failureString ].
	^ true
]

{ #category : #testing }
STTShouldNot >> have: properties [
	"Test that no properties of the contained value have specified values. The properties should be a collection of Associations, or a Dictionary where the keys are Symbols representing properties of the value under test and the values are the expected values of those properties (as in: [ #(1 2 3) ] should not have: { #size->2 . #isEmpty->true }"
	| testObject propertyMap failedKeys failedValues expectedValues |
	testObject := self value.
	propertyMap := properties asDictionary.
	failedKeys := OrderedCollection new.
	failedValues := OrderedCollection new.
	expectedValues := OrderedCollection new.
	propertyMap keysAndValuesDo: [ :property :expectedValue | | actualValue |
		actualValue := testObject perform: property.
		actualValue = expectedValue
			ifTrue: [
				failedKeys add: property.
				failedValues add: actualValue.
				expectedValues add: expectedValue
			]
	].
	failedKeys isEmpty
		ifFalse: [ | failureString |
			failureString := 'Failed keys: ' , failedKeys asArray printString , ' had values: ' , failedValues asArray printString.
			self classForFailure signal: failureString
		].
	^ true
]

{ #category : #testing }
STTShouldNot >> include: aString [
	"Test that the contained string does not include aString."
	| actualValue failureString |
	actualValue := self value.
	failureString := actualValue printString , ' included ' , aString printString.
	(actualValue indexOfSubCollection: aString) > 0
		ifTrue: [ self classForFailure signal: failureString ].
	^ true
]

{ #category : #testing }
STTShouldNot >> includeRegex: aPattern [
	"Test that the regular expression aPattern does not match the contained string."
	| actualValue anchoredPattern failureString |
	actualValue := self value.
	anchoredPattern := '.*' , aPattern , '.*'.
	failureString := actualValue printString , ' included a match of ' , aPattern printString.
	(anchoredPattern asRegex matches: actualValue)
		ifTrue: [ self classForFailure signal: failureString ].
	^ true
]

{ #category : #testing }
STTShouldNot >> includeRegex: aPattern withGroups: groups [
	"Test that the regular expression aPattern does not match the contained string and that the array groups do not contain all captured groups in aPattern (as in: [ 'Hello, world' ] should not includeRegex: '(l+o)' withGroups: #('ello')). NOTE: due to the greedy RE implementation, it is not possible to get a longest wildcard match at the start of an includes match."
	| actualValue regex groupsMatch failureString |
	actualValue := self value.
	regex := ('.*' , aPattern , '.*') asRegex.
	groupsMatch := [
		regex subexpressionCount - 1 = groups size and: [
			(1 to: groups size) allSatisfy: [ :i | (regex subexpression: i + 1) = (groups at: i) ]
		]
	].
	failureString := actualValue printString , ' included a match of ' , aPattern printString , ' with groups ' , groups printString.
	((regex matches: actualValue) and: groupsMatch)
		ifTrue: [ self classForFailure signal: failureString ].
	^ true
]

{ #category : #testing }
STTShouldNot >> key: aKey [
	"Test that the value does not contain the key aKey."
	| actualValue failureString |
	actualValue := self value.
	failureString := actualValue printString , ' contained key ' , aKey printString.
	(actualValue includesKey: aKey)
		ifTrue: [ self classForFailure signal: failureString ].
	^ true
]

{ #category : #testing }
STTShouldNot >> noneOf: aCollection [
	"Test that the value does not contain none of the elements of aCollection."
	| actualValue occurrences failureString |
	actualValue := self value.
	failureString := actualValue printString , ' contained none of ' , aCollection printString.
	occurrences := (aCollection asSet select: [ :item | actualValue includes: item]) size.
	occurrences = 0
		ifTrue: [ self classForFailure signal: failureString ].
	^ true
]

{ #category : #testing }
STTShouldNot >> not [
	"Negate the sense of any test that is applied to the contained value."
	^ STTShould new with: evaluationBlock; yourself
]

{ #category : #testing }
STTShouldNot >> oneOf: aCollection [
	"Test that the value does not contain exactly one of the elements of aCollection."
	| actualValue occurrences failureString |
	actualValue := self value.
	failureString := actualValue printString , ' contained one of ' , aCollection printString.
	occurrences := (aCollection asSet select: [ :item | actualValue includes: item]) size.
	occurrences = 1
		ifTrue: [ self classForFailure signal: failureString ].
	^ true
]

{ #category : #testing }
STTShouldNot >> only: aCollection [
	"Test that the value does not only contain elements of aCollection."
	| actualValue expectedSet occurrences failureString |
	actualValue := self value.
	expectedSet := aCollection asSet.
	failureString := actualValue printString , ' contained only ' , aCollection printString.
	occurrences := (expectedSet select: [ :item | actualValue includes: item]) size.
	(occurrences = expectedSet size and: [ occurrences = actualValue asSet size ])
		ifTrue: [ self classForFailure signal: failureString ].
	^ true
]

{ #category : #testing }
STTShouldNot >> size: expectation [
	"Tests that the contained value does not have size expectation. I will use the #size method to check this."
	| actualValue actualSize failureString |
	actualValue := self value.
	actualSize := actualValue size.
	failureString := actualValue printString , ' had size ' , actualSize printString.
	actualSize = expectation
		ifTrue: [ self classForFailure signal: failureString ].
	^ true
]

{ #category : #testing }
STTShouldNot >> startWith: aString [
	"Test that the contained string does not start with aString."
	| actualValue failureString |
	actualValue := self value.
	failureString := actualValue printString , ' started with ' , aString printString.
	(actualValue beginsWith: aString)
		ifTrue: [ self classForFailure signal: failureString ].
	^ true
]

{ #category : #testing }
STTShouldNot >> startWithRegex: aPattern [
	"Test that the regular expression aPattern does not matche at the start of the contained string."
	| actualValue failureString |
	actualValue := self value.
	failureString := actualValue printString , ' started with a match of ' , aPattern printString.
	(aPattern asRegex matchesPrefix: actualValue)
		ifTrue: [ self classForFailure signal: failureString ].
	^ true
]

{ #category : #testing }
STTShouldNot >> startWithRegex: aPattern withGroups: groups [
	"Test that the regular expression aPattern does not match at the start of the contained string and that the array groups does not contain all captured groups in aPattern (as in: [ 'Hello, world' ] should not startWithRegex: '(Hel+)' withGroups: #('Hel'))."
	| actualValue regex groupsMatch failureString |
	actualValue := self value.
	regex := aPattern asRegex.
	groupsMatch := [
		regex subexpressionCount - 1 = groups size and: [
			(1 to: groups size) allSatisfy: [ :i | (regex subexpression: i + 1) = (groups at: i) ]
		]
	].
	failureString := actualValue printString , ' started with a match of ' , aPattern printString , ' with groups ' , groups printString.
	((regex matchesPrefix: actualValue) and: groupsMatch)
		ifTrue: [ self classForFailure signal: failureString ].
	^ true
]

{ #category : #testing }
STTShouldNot >> theSameElementsAs: aCollection [
	"Test that the value does not contain the same elements as aCollection."
	| actualValue failureString |
	actualValue := self value.
	failureString := actualValue printString , ' contained the same elements as ' , aCollection printString.
	actualValue asArray sorted = aCollection asArray sorted
		ifTrue: [ self classForFailure signal: failureString ].
	^ true
]

{ #category : #testing }
STTShouldNot >> theSameElementsInOrderAs: aCollection [
	"Test that the value does not contain the same elements as aCollection in the same order."
	| actualValue failureString |
	actualValue := self value.
	failureString := actualValue printString , ' contained the same elements in order as ' , aCollection printString.
	actualValue asArray = aCollection asArray
		ifTrue: [ self classForFailure signal: failureString ].
	^ true
]

{ #category : #testing }
STTShouldNot >> theSameInstanceAs: expectation [
	"Tests if the contained value is not exactly the same object as the expected value. This test uses ~~ to perform the check, so any objects that show as ~~ to each other will be considered to be the same instance for this test."
	| actualValue failureString |
	actualValue := self value.
	failureString := actualValue printString , ' was the same instance as ' , expectation printString.
	actualValue ~~ expectation
		ifFalse: [ self classForFailure signal: failureString ].
	^ true
]

{ #category : #testing }
STTShouldNot >> throw: anException [
	"Test if the exception specified is not thrown when aBlock is evaluated. Any subclass of the given exception will generate a failure. If no exception is raised or a different one is raised, then the test succeeds (as in: [ 1 / 2 ] should not throw: ZeroDivide)"
	| exceptionFailureString |
	exceptionFailureString := 'Expected exception ' , anException printString , ' to not be thrown, but it was thrown.'.
	[ self value ]
		on: Exception
		do: [ :sig |
			(sig isKindOf: anException) not
				ifTrue: [ sig return: true ]
				ifFalse: [ self classForFailure signal: exceptionFailureString ]
		].
	^ true
]

{ #category : #testing }
STTShouldNot >> value: aValue [
	"Test that the value does not contain the value aValue."
	| actualValue failureString |
	actualValue := self value.
	failureString := actualValue printString , ' contained value ' , aValue printString.
	(actualValue includes: aValue)
		ifTrue: [ self classForFailure signal: failureString ].
	^ true
]
