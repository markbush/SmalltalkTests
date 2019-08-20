Class {
	#name : #STTShouldTest,
	#superclass : #TestCase,
	#category : #'SmalltalkTests-Tests'
}

{ #category : #testing }
STTShouldTest >> testCollectionContains [
	| result |
	result := [ 'some string' ] should contain: $t.
	self assert: result.
	result := [ #(1 2 3) ] should contain: 1.
	self assert: result.
	result := [ Set with: #aSymbol ] should contain: #aSymbol.
	self assert: result.
	result := [ 'some string' ] should not contain: $x.
	self assert: result.
	result := [ #(1 2 3) ] should not contain: 4.
	self assert: result.
	result := [ Set with: #aSymbol ] should not contain: #anotherSymbol.
	self assert: result
]

{ #category : #testing }
STTShouldTest >> testCollectionContainsAllOf [
	| result |
	result := [ 'some string' ] should contain allOf: 'msg'.
	self assert: result.
	result := [ #(1 2 3) ] should contain allOf: #(1 3 1).
	self assert: result.
	result := [ Set with: #aSymbol ] should contain allOf: #(#aSymbol).
	self assert: result.
	result := [ 'some string' ] should not contain allOf: 'smx'.
	self assert: result.
	result := [ #(1 2 3) ] should not contain allOf: #(2 3 4).
	self assert: result.
	result := [ Set with: #aSymbol with: #anotherSymbol ] should not contain allOf: #(#someSymbol #anotherSymbol).
	self assert: result
]

{ #category : #testing }
STTShouldTest >> testCollectionContainsAtLeastOneOf [
	| result |
	result := [ 'some string' ] should contain atLeastOneOf: 'asg'.
	self assert: result.
	result := [ #(1 2 3) ] should contain atLeastOneOf: #(3 4 5).
	self assert: result.
	result := [ Set with: #aSymbol ] should contain atLeastOneOf: #(#aSymbol #anotherSymbol).
	self assert: result.
	result := [ 'some string' ] should not contain atLeastOneOf: 'xyz'.
	self assert: result.
	result := [ #(1 2 3) ] should not contain atLeastOneOf: #(4 5 6).
	self assert: result.
	result := [ Set with: #aSymbol with: #anotherSymbol ] should not contain atLeastOneOf: #(#someSymbol #someOtherSymbol).
	self assert: result
]

{ #category : #testing }
STTShouldTest >> testCollectionContainsAtMostOneOf [
	| result |
	result := [ 'some string' ] should contain atMostOneOf: 'asx'.
	self assert: result.
	result := [ #(1 2 3) ] should contain atMostOneOf: #(4 5 6).
	self assert: result.
	result := [ Set with: #aSymbol ] should contain atMostOneOf: #(#aSymbol #anotherSymbol).
	self assert: result.
	result := [ 'some string' ] should not contain atMostOneOf: 'smx'.
	self assert: result.
	result := [ #(1 2 3) ] should not contain atMostOneOf: #(2 3 4).
	self assert: result.
	result := [ Set with: #aSymbol with: #anotherSymbol ] should not contain atMostOneOf: #(#aSymbol #anotherSymbol).
	self assert: result
]

{ #category : #testing }
STTShouldTest >> testCollectionContainsKey [
	| d result |
	d := { #one->1 . #two->2 . #three->3 } asDictionary.
	result := [ d ] should contain key: #one.
	self assert: result.
	result := [ d ] should contain key: #two.
	self assert: result.
	result := [ d ] should not contain key: #four.
	self assert: result
]

{ #category : #testing }
STTShouldTest >> testCollectionContainsNoneOf [
	| result |
	result := [ 'some string' ] should contain noneOf: 'xyz'.
	self assert: result.
	result := [ #(1 2 3) ] should contain noneOf: #(4 5 6).
	self assert: result.
	result := [ Set with: #aSymbol ] should contain noneOf: #(#someSymbol #anotherSymbol).
	self assert: result.
	result := [ 'some string' ] should not contain noneOf: 'mtg'.
	self assert: result.
	result := [ #(1 2 3) ] should not contain noneOf: #(3 4 5).
	self assert: result.
	result := [ Set with: #aSymbol with: #anotherSymbol ] should not contain noneOf: #(#aSymbol #anotherSymbol).
	self assert: result
]

{ #category : #testing }
STTShouldTest >> testCollectionContainsOneOf [
	| result |
	result := [ 'some string' ] should contain oneOf: 'asx'.
	self assert: result.
	result := [ #(1 2 3) ] should contain oneOf: #(3 4 5).
	self assert: result.
	result := [ Set with: #aSymbol ] should contain oneOf: #(#aSymbol #anotherSymbol).
	self assert: result.
	result := [ 'some string' ] should not contain oneOf: 'mtg'.
	self assert: result.
	result := [ #(1 2 3) ] should not contain oneOf: #(2 3 4).
	self assert: result.
	result := [ Set with: #aSymbol with: #anotherSymbol ] should not contain oneOf: #(#aSymbol #anotherSymbol).
	self assert: result
]

{ #category : #testing }
STTShouldTest >> testCollectionContainsOnly [
	| result |
	result := [ 'some string' ] should contain only: ' egimnorst'.
	self assert: result.
	result := [ #(1 2 3 2) ] should contain only: #(1 3 1 2).
	self assert: result.
	result := [ Set with: #aSymbol ] should contain only: #(#aSymbol).
	self assert: result.
	result := [ 'some string' ] should not contain only: 'smx'.
	self assert: result.
	result := [ #(1 2 3) ] should not contain only: #(2 3 4).
	self assert: result.
	result := [ Set with: #aSymbol with: #anotherSymbol ] should not contain only: #(#someSymbol #anotherSymbol).
	self assert: result
]

{ #category : #testing }
STTShouldTest >> testCollectionContainsTheSameElements [
	| result |
	result := [ 'some string' ] should contain theSameElementsAs: ' egimnorsst'.
	self assert: result.
	result := [ #(1 2 3 2) ] should contain theSameElementsAs: #(1 3 2 2).
	self assert: result.
	result := [ Set with: #aSymbol ] should contain theSameElementsAs: #(#aSymbol).
	self assert: result.
	result := [ 'some string' ] should not contain theSameElementsAs: 'smx'.
	self assert: result.
	result := [ #(1 2 3) ] should not contain theSameElementsAs: #(2 3 4).
	self assert: result.
	result := [ Set with: #aSymbol with: #anotherSymbol ] should not contain theSameElementsAs: #(#someSymbol #anotherSymbol).
	self assert: result
]

{ #category : #testing }
STTShouldTest >> testCollectionContainsTheSameElementsInOrder [
	| result |
	result := [ 'some string' ] should contain theSameElementsInOrderAs: 'some string'.
	self assert: result.
	result := [ #(1 2 3 2) ] should contain theSameElementsInOrderAs: #(1 2 3 2).
	self assert: result.
	result := [ Set with: #aSymbol ] should contain theSameElementsInOrderAs: #(#aSymbol).
	self assert: result.
	result := [ 'some string' ] should not contain theSameElementsInOrderAs: 'smx'.
	self assert: result.
	result := [ #(1 2 3) ] should not contain theSameElementsInOrderAs: #(3 2 1).
	self assert: result.
	result := [ Set with: #aSymbol with: #anotherSymbol ] should not contain theSameElementsInOrderAs: #(#someSymbol #anotherSymbol).
	self assert: result
]

{ #category : #testing }
STTShouldTest >> testCollectionContainsValue [
	| d a result |
	d := { #one->1 . #two->2 . #three->3 } asDictionary.
	a := #(1 $x #aSymbol).
	result := [ d ] should contain value: 1.
	self assert: result.
	result := [ d ] should contain value: 2.
	self assert: result.
	result := [ a ] should contain value: $x.
	self assert: result.
	result := [ d ] should not contain value: 4.
	self assert: result.
	result := [ a ] should not contain value: #anotherSymbol.
	self assert: result
]

{ #category : #testing }
STTShouldTest >> testEmpty [
	| result |
	result := [ #() ] should be empty.
	self assert: result.
	result := [ Set new ] should be empty.
	self assert: result.
	result := [ '' ] should be empty.
	self assert: result.
	result := [ #(1 2 3) ] should not be empty.
	self assert: result.
	result := [ Set with: 'contents' ] should not be empty.
	self assert: result.
	result := [ 'some string' ] should not be empty.
	self assert: result
]

{ #category : #testing }
STTShouldTest >> testGreaterThan [
	| result |
	result := [ 4 ] should be > 2.
	self assert: result.
	result := [ 3.7 ] should be > 3.6.
	self assert: result.
	result := [ -6 ] should not be > -4.
	self assert: result.
	result := [ 0 ] should not be > 12.5.
	self assert: result
]

{ #category : #testing }
STTShouldTest >> testGreaterThanOrEqualTo [
	| result |
	result := [ 4 ] should be >= 2.
	self assert: result.
	result := [ 3.7 ] should be >= 3.7.
	self assert: result.
	result := [ -6 ] should not be >= -4.
	self assert: result.
	result := [ 0 ] should not be >= 12.5.
	self assert: result
]

{ #category : #testing }
STTShouldTest >> testLessThan [
	| result |
	result := [ 2 ] should be < 4.
	self assert: result.
	result := [ 3.6 ] should be < 3.7.
	self assert: result.
	result := [ -4 ] should not be < -6.
	self assert: result.
	result := [ 12.5 ] should not be < 0.
	self assert: result
]

{ #category : #testing }
STTShouldTest >> testLessThanOrEqual [
	| result |
	result := [ 2 ] should be <= 4.
	self assert: result.
	result := [ 3.6 ] should be <= 3.6.
	self assert: result.
	result := [ -4 ] should not be <= -6.
	self assert: result.
	result := [ 12.5 ] should not be <= 0.
	self assert: result
]

{ #category : #testing }
STTShouldTest >> testShouldEqualAValue [
	| result |
	result := [ 1 + 1 ] should equal: 2.
	self assert: result.
	result := [ #() ] should equal: #().
	self assert: result.
	result := [ 'some string' ] should equal: 'some string'.
	self assert: result.
	result := [ $a ] should equal: $a.
	self assert: result.
	result := [ #aSymbol ] should equal: #aSymbol.
	self assert: result
]

{ #category : #testing }
STTShouldTest >> testShouldFailToMatchWrongValue [
	| test |
	test := [ [ 1 + 1 ] should be: 3 ].
	self should: test raise: TestFailure
]

{ #category : #testing }
STTShouldTest >> testShouldMatchAClass [
	| result |
	result := [ 2 ] should be an: Integer.
	self assert: result.
	result := [ 3.14 ] should be a: Float.
	self assert: result.
	result := [ 'some string' ] should be a: String.
	self assert: result.
	result := [ $a ] should be a: Character.
	self assert: result.
	result := [ #aSymbol ] should be a: #symbol.
	self assert: result.
	result := [ 2 ] should be not a: Symbol.
	self assert: result.
	result := [ 3.14 ] should not be a: Set.
	self assert: result.
	result := [ 'some string' ] should not be an: Array.
	self assert: result.
	result := [ $a ] should not be a: #collection.
	self assert: result.
	result := [ #aSymbol ] should not be a: Character.
	self assert: result
]

{ #category : #testing }
STTShouldTest >> testShouldMatchAProperty [
	| result |
	result := [ 2 ] should be: #even.
	self assert: result.
	result := [ #() ] should be: #empty.
	self assert: result
]

{ #category : #testing }
STTShouldTest >> testShouldMatchARange [
	| result |
	result := [ 5.2 ] should be: 5.1 +- 1.3.
	self assert: result.
	result := [ 5.2 ] should be: 5.1 +- 0.1.
	self assert: result.
	result := [ 5.2 ] should not be: 5.4 +- 0.1.
	self assert: result
]

{ #category : #testing }
STTShouldTest >> testShouldMatchAValue [
	| result |
	result := [ 1 + 1 ] should be: 2.
	self assert: result.
	result := [ #() ] should be: #().
	self assert: result.
	result := [ 'some string' ] should be: 'some string'.
	self assert: result.
	result := [ $a ] should be: $a.
	self assert: result.
	result := [ #aSymbol ] should be: #symbol.
	self assert: result
]

{ #category : #testing }
STTShouldTest >> testShouldMatchIdentically [
	| result aSet |
	result := [ 2 ] should be theSameInstanceAs: 2.
	self assert: result.
	result := [ #() ] should be theSameInstanceAs: #().
	self assert: result.
	result := [ 'some string' ] should be theSameInstanceAs: 'some string'.
	self assert: result.
	result := [ $a ] should be theSameInstanceAs: $a.
	self assert: result.
	result := [ #aSymbol ] should be theSameInstanceAs: #aSymbol.
	self assert: result.
	aSet := Set with: 'a string'.
	result := [ aSet ] should be theSameInstanceAs: aSet.
	self assert: result.
	result := [ Set with: 'a string' ] should not be theSameInstanceAs: aSet.
	self assert: result.
	result := [ { 1 . 2 . 3 } ] should not be theSameInstanceAs: { 1 . 2 . 3 }.
	self assert: result
]

{ #category : #testing }
STTShouldTest >> testShouldMatchPropertyValues [
	| result |
	result := [ #(1 2 3) ] should have: { #size->3 . #isEmpty->false }.
	self assert: result.
	result := [ #() ] should not have: { #size->3 . #isEmpty->false }.
	self assert: result
]

{ #category : #testing }
STTShouldTest >> testShouldNotEqual [
	| result |
	result := [ 1 + 1 ] should not equal: 3.
	self assert: result.
	result := [ #(1) ] should not equal: #().
	self assert: result.
	result := [ 'some string' ] should not equal: 'some other string'.
	self assert: result.
	result := [ $a ] should not equal: $b.
	self assert: result.
	result := [ #aSymbol ] should not equal: #anotherSymbol.
	self assert: result
]

{ #category : #testing }
STTShouldTest >> testShouldNotFailToMatchWrongValue [
	| test |
	test := [ [ 1 + 1 ] should not be: 2 ].
	self should: test raise: TestFailure
]

{ #category : #testing }
STTShouldTest >> testShouldNotMatch [
	| result |
	result := [ 1 + 1 ] should not be: 3.
	self assert: result.
	result := [ #(1) ] should not be: #().
	self assert: result.
	result := [ 'some string' ] should not be: 'some other string'.
	self assert: result.
	result := [ $a ] should not be: $b.
	self assert: result.
	result := [ #aSymbol ] should not be: #integer.
	self assert: result
]

{ #category : #testing }
STTShouldTest >> testShouldNotMatchAProperty [
	| result test |
	result := [ 2 ] should not be: #odd.
	self assert: result.
	result := [ #(1) ] should not be: #empty.
	self assert: result.
	test := [ [ 3 ] should not be: #odd ].
	self should: test raise: TestFailure.
	test := [ [ #() ] should not be: #empty ].
	self should: test raise: TestFailure
]

{ #category : #testing }
STTShouldTest >> testShouldNotNotMatchAValue [
	"Should not arrise, but to ensure consistency."
	| result |
	result := [ 1 + 1 ] should not not be: 2.
	self assert: result
]

{ #category : #testing }
STTShouldTest >> testShouldThrowException [
	| result |
	result := [ 1 / 0 ] should throw: ZeroDivide.
	self assert: result.
	result := [ #() first ] should throw: SubscriptOutOfBounds.
	self assert: result.
	result := [ 0 / 1 ] should not throw: ZeroDivide.
	self assert: result.
	result := [ #(1) first ] should not throw: SubscriptOutOfBounds.
	self assert: result
]

{ #category : #testing }
STTShouldTest >> testShouldValueIsBlockValue [
	| s value |
	value := 1.
	s := STTShould with: [ value ].
	self assert: s value equals: value.
	value := 'some string'.
	s := STTShould with: [ value ].
	self assert: s value equals: value.
	value := 'some string' size.
	s := STTShould with: [ 'some string' size ].
	self assert: s value equals: value
]

{ #category : #testing }
STTShouldTest >> testSize [
	| result |
	result := [ #() ] should have size: 0.
	self assert: result.
	result := [ #(1 2 3) ] should have size: 3.
	self assert: result.
	result := [ #() ] should not have size: 3.
	self assert: result.
	result := [ #(1 2 3) ] should not have size: 0.
	self assert: result
]

{ #category : #testing }
STTShouldTest >> testStringEndsWith [
	| result |
	result := [ 'some string' ] should endWith: 'string'.
	self assert: result.
	result := [ 'another string' ] should not endWith: 'another'.
	self assert: result
]

{ #category : #testing }
STTShouldTest >> testStringEndsWithRegex [
	| result |
	result := [ 'Hello, World' ] should endWithRegex: 'W.*d'.
	self assert: result.
	result := [ 'another string' ] should endWithRegex: '\ss[^h]+g'.
	self assert: result.
	result := [ 'Hello, World' ] should not endWithRegex: '\sW'.
	self assert: result.
	result := [ 'another string' ] should not endWithRegex: 's.*i'.
	self assert: result
]

{ #category : #testing }
STTShouldTest >> testStringEndsWithRegexWithGroups [
	"Note the limitation due to greedy REs."
	| result |
	result := [ 'Hello, World' ] should endWithRegex: '(l+o), (W.+d)' withGroups: #('lo' 'World').
	self assert: result.
	result := [ 'another string' ] should endWithRegex: '(\sst)(r[^x]*g)' withGroups: #(' st' 'ring').
	self assert: result.
	result := [ 'Hello, World' ] should not endWithRegex: '(W.d)' withGroups: #('World').
	self assert: result.
	result := [ 'another string' ] should not endWithRegex: '(\sst)(r[^x]*g)' withGroups: #('st' 'ring').
	self assert: result
]

{ #category : #testing }
STTShouldTest >> testStringFullyMatchesRegex [
	| result |
	result := [ 'Hello, World' ] should fullyMatch: 'Hel+o.*d'.
	self assert: result.
	result := [ 'another string' ] should fullyMatch: 'a[^x]+\ss[^h]+g'.
	self assert: result.
	result := [ 'Hello, World' ] should not fullyMatch: '\sWo'.
	self assert: result.
	result := [ 'another string' ] should not fullyMatch: 'r\ss'.
	self assert: result
]

{ #category : #testing }
STTShouldTest >> testStringFullyMatchesRegexWithGroups [
	"Note the limitation due to greedy REs."
	| result |
	result := [ 'Hello, World' ] should fullyMatch: '(\w+), (\w+)' withGroups: #('Hello' 'World').
	self assert: result.
	result := [ 'another string' ] should fullyMatch: '(a.*r)\s(..r.*g)' withGroups: #('another' 'string').
	self assert: result.
	result := [ 'Hello, World' ] should not fullyMatch: '(\w+) (\w+)' withGroups: #('Hello' 'World').
	self assert: result.
	result := [ 'another string' ] should not fullyMatch: '(a.*r)\s(..r.*g)' withGroups: #('another' 'ring').
	self assert: result
]

{ #category : #testing }
STTShouldTest >> testStringIncludes [
	| result |
	result := [ 'some string' ] should include: 'me str'.
	self assert: result.
	result := [ 'another string' ] should not include: 'me str'.
	self assert: result
]

{ #category : #testing }
STTShouldTest >> testStringIncludesRegex [
	| result |
	result := [ 'Hello, World' ] should includeRegex: 'l+.*r'.
	self assert: result.
	result := [ 'another string' ] should includeRegex: '\ss[^h]+i'.
	self assert: result.
	result := [ 'Hello, World' ] should not includeRegex: '\sWx'.
	self assert: result.
	result := [ 'another string' ] should not includeRegex: 'r\sx'.
	self assert: result
]

{ #category : #testing }
STTShouldTest >> testStringIncludesRegexWithGroups [
	"Note the limitation due to greedy REs."
	| result |
	result := [ 'Hello, World' ] should includeRegex: '(l+o)' withGroups: #('lo').
	self assert: result.
	result := [ 'another string' ] should includeRegex: '(t.e).*(tr)' withGroups: #('the' 'tr').
	self assert: result.
	result := [ 'Hello, World' ] should not includeRegex: '(l+o)' withGroups: #('llo').
	self assert: result.
	result := [ 'another string' ] should not includeRegex: '(t.e).*(tr)' withGroups: #('the' 'ring').
	self assert: result
]

{ #category : #testing }
STTShouldTest >> testStringStartsWith [
	| result |
	result := [ 'some string' ] should startWith: 'some'.
	self assert: result.
	result := [ 'another string' ] should not startWith: 'some'.
	self assert: result
]

{ #category : #testing }
STTShouldTest >> testStringStartsWithRegex [
	| result |
	result := [ 'Hello, World' ] should startWithRegex: 'Hel+'.
	self assert: result.
	result := [ 'another string' ] should startWithRegex: 'a.*r'.
	self assert: result.
	result := [ 'Hello, World' ] should not startWithRegex: '\sW'.
	self assert: result.
	result := [ 'another string' ] should not startWithRegex: 's.*g'.
	self assert: result
]

{ #category : #testing }
STTShouldTest >> testStringStartsWithRegexWithGroups [
	| result |
	result := [ 'Hello, World' ] should startWithRegex: '(Hel+)' withGroups: #('Hell').
	self assert: result.
	result := [ 'another string' ] should startWithRegex: '(a.*o)(t.e)' withGroups: #('ano' 'the').
	self assert: result.
	result := [ 'Hello, World' ] should not startWithRegex: '(Hel+)' withGroups: #('Hel').
	self assert: result.
	result := [ 'another string' ] should not startWithRegex: '(a.*o)(t.e)' withGroups: #('an' 'other').
	self assert: result
]
