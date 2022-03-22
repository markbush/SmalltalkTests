# SmalltalkTests
Spec style tests for Smalltalks

## Introduction

SmalltalkTests provides a DSL for describing tests.  It doesn't provide a full BDD framework.  In this way, you can plug SmalltalkTests into an existing framework.  In particular, they work great in SUnit tests, integrating right into your normal workflow for testing.

This DSL is based on the test matchers provided by frameworks such as [RSpec](https://rspec.info) and [ScalaTest](http://www.scalatest.org/). If you are familiar with those, then you will feel right at home with SmalltalkTests.

The initial implementation is very flat.  That is, there are two classes (STTShould and STTShouldNot) with a lot of repeated code.  This is currently to ensure that when a test fails, the debugger opens on the test code, not the framework code.

The tests for SmalltalkTests give examples of all of the options available.  There is also an example implementation of a stack structure with tests written just using SmalltalkTests.

All of the tests available operate on a block.  This is so that they can test for exceptions, so need to control when the code is evaluated.  There are two equivalent forms, depending on how emphatic you want to be:

```smalltalk
[ value to test ] should ...
[ value to test ] must ...
```

Both forms have variants which negate the meaning of the test:

```smalltalk
[ value to test ] should not ...
[ value to test ] must not ...
```

## Installing

### Pharo 6.1

Open the Monticello Browser and add the SqueakSource repository:
```smalltalk
MCHttpRepository
    location: 'http://www.squeaksource.com/SmalltalkTests'
    user: ''
    password: ''
```

Select and load each of the packages:
* SmalltalkTests
* SmalltalkTests-Tests
* SmalltalkTestsExample

### Pharo 7.0, 8.0, 9.0, 10.0

Using Metacello:

```smalltalk
Metacello new
  baseline: 'SmalltalkTests';
  repository: 'github://markbush/SmalltalkTests';
  load
```

To include the Stack sample use of the framework (SmalltalkTestsExample):

```smalltalk
Metacello new
  baseline: 'SmalltalkTests';
  repository: 'github://markbush/SmalltalkTests';
  load: #full
```

Using Iceberg:

Open Iceberg and add the GitHub repository:
* Owner name: markbush
* Project name: SmalltalkTests
* Protocol: HTTPS

Open the package view and load each of the packages:
* SmalltalkTests
* SmalltalkTests-Tests
* SmalltalkTestsExample

## Checking the installation

The `SmalltalkTests-Tests` package contains standard SUnit tests for this project.  These tests have been confirmed working in Pharo 6.1, 7.0, 8.0, 9.0, and 10.0 development.  Run the tests to confirm that the package is working in your image.

The `SmalltalkTestsExample` package is an example of using SmalltalkTests in a project.  This is a sample implementation of stacks.  The tests have been confirmed working in Pharo 6.1, 7.0, 8.0, 9.0, and 10.0 development.

## Available tests

### Checking equality

Either `===` or `equal:` will test for equality.  Do **not** use equality testing for floats.  Use `be:` with a range (see below).

```smalltalk
[ 1 + 1 ] should === 2.
[ #() ] should equal: #().
[ 'some string' ] should equal: 'some string'.
[ $a ] should equal: $a.
[ #aSymbol ] should equal: #aSymbol.
[ 1 + 1 ] should not === 3.
[ #(1) ] should not equal: #().
[ 'some string' ] should not equal: 'some other string'.
[ $a ] should not equal: $b.
[ #aSymbol ] should not equal: #anotherSymbol.
```

### Checking size

You can test the size of anything with a `size` message.

```smalltalk
[ #() ] should have size: 0.
[ #(1 2 3) ] should have size: 3.
[ #() ] should not have size: 3.
[ #(1 2 3) ] should not have size: 0.
```

### Checking strings

Checking if a string starts with, ends with, or includes another string is straightforward.

```smalltalk
[ 'some string' ] should startWith: 'some'.
[ 'another string' ] should not startWith: 'some'.
[ 'some string' ] should endWith: 'string'.
[ 'another string' ] should not endWith: 'another'.
[ 'some string' ] should include: 'me str'.
[ 'another string' ] should not include: 'me str'.
```

You can do similar checks with regular expressions, as well as checking for a complete match.

```smalltalk
[ 'Hello, World' ] should startWithRegex: 'Hel+'.
[ 'another string' ] should startWithRegex: 'a.*r'.
[ 'Hello, World' ] should not startWithRegex: '\sW'.
[ 'another string' ] should not startWithRegex: 's.*g'.
[ 'Hello, World' ] should endWithRegex: 'W.*d'.
[ 'another string' ] should endWithRegex: '\ss[^h]+g'.
[ 'Hello, World' ] should not endWithRegex: '\sW'.
[ 'another string' ] should not endWithRegex: 's.*i'.
[ 'Hello, World' ] should includeRegex: 'l+.*r'.
[ 'another string' ] should includeRegex: '\ss[^h]+i'.
[ 'Hello, World' ] should not includeRegex: '\sWx'.
[ 'another string' ] should not includeRegex: 'r\sx'.
[ 'Hello, World' ] should fullyMatch: 'Hel+o.*d'.
[ 'another string' ] should fullyMatch: 'a[^x]+\ss[^h]+g'.
[ 'Hello, World' ] should not fullyMatch: '\sWo'.
[ 'another string' ] should not fullyMatch: 'r\ss'.
```

These forms all allow you to specify match groups and test that they return specific values.

NOTE: Pharo regular expressions are greedy and don't provide non-greedy elements.  This means that in order to match in the middle or end of a string, an initial capture group may not behave as expected.  The examples below show that a pattern of, say, 'l+' at the start will only match a single 'l'.

```smalltalk
[ 'Hello, World' ] should startWithRegex: '(Hel+)' withGroups: #('Hell').
[ 'another string' ] should startWithRegex: '(a.*o)(t.e)' withGroups: #('ano' 'the').
[ 'Hello, World' ] should not startWithRegex: '(Hel+)' withGroups: #('Hel').
[ 'another string' ] should not startWithRegex: '(a.*o)(t.e)' withGroups: #('an' 'other').
[ 'Hello, World' ] should endWithRegex: '(l+o), (W.+d)' withGroups: #('lo' 'World').
[ 'another string' ] should endWithRegex: '(\sst)(r[^x]*g)' withGroups: #(' st' 'ring').
[ 'Hello, World' ] should not endWithRegex: '(W.d)' withGroups: #('World').
[ 'another string' ] should not endWithRegex: '(\sst)(r[^x]*g)' withGroups: #('st' 'ring').
[ 'Hello, World' ] should includeRegex: '(l+o)' withGroups: #('lo').
[ 'another string' ] should includeRegex: '(t.e).*(tr)' withGroups: #('the' 'tr').
[ 'Hello, World' ] should not includeRegex: '(l+o)' withGroups: #('llo').
[ 'another string' ] should not includeRegex: '(t.e).*(tr)' withGroups: #('the' 'ring').
[ 'Hello, World' ] should fullyMatch: '(\w+), (\w+)' withGroups: #('Hello' 'World').
[ 'another string' ] should fullyMatch: '(a.*r)\s(..r.*g)' withGroups: #('another' 'string').
[ 'Hello, World' ] should not fullyMatch: '(\w+) (\w+)' withGroups: #('Hello' 'World').
[ 'another string' ] should not fullyMatch: '(a.*r)\s(..r.*g)' withGroups: #('another' 'ring').
```

### Greater and less than

You can match any type that supports `>`, `>=`, `<`, `<=` (not just numbers).

```smalltalk
[ 2 ] should be < 4.
[ 3.6 ] should be < 3.7.
[ -4 ] should not be < -6.
[ 12.5 ] should not be < 0.
[ 2 ] should be <= 4.
[ 3.6 ] should be <= 3.6.
[ -4 ] should not be <= -6.
[ 12.5 ] should not be <= 0.
[ 4 ] should be > 2.
[ 3.7 ] should be > 3.6.
[ -6 ] should not be > -4.
[ 0 ] should not be > 12.5.
[ 4 ] should be >= 2.
[ 3.7 ] should be >= 3.7.
[ -6 ] should not be >= -4.
[ 0 ] should not be >= 12.5.
```

### Checking boolean properties

You can use `be:` to check for a boolean property.

```smalltalk
[ 2 ] should be: #even.
[ #() ] should be: #empty.
[ 2 ] should not be: #odd.
[ #(1) ] should not be: #empty.
```

### Checking arbitrary properties

You can use `have:` to check arbitrary properties with values.

```smalltalk
[ #(1 2 3) ] should have: { #size->3 . #isEmpty->false }.
[ #() ] should not have: { #size->3 . #isEmpty->false }.
```

### Checking object identity

You can check that a result is exactly the same object as something with `theSameInstanceAs:`.

```smalltalk
[ 2 ] should be theSameInstanceAs: 2.
[ $a ] should be theSameInstanceAs: $a.
[ #aSymbol ] should be theSameInstanceAs: #aSymbol.
aSet := Set with: 'a string'.
[ aSet ] should be theSameInstanceAs: aSet.
[ Set with: 'a string' ] should not be theSameInstanceAs: aSet.
[ { 1 . 2 . 3 } ] should not be theSameInstanceAs: { 1 . 2 . 3 }.
```

### Checking an object's class

You can check that a result is a particular class (or subclass) with `a:` and `an:`.

```smalltalk
[ 2 ] should be an: Integer.
[ 3.14 ] should be a: Float.
[ 'some string' ] should be a: String.
[ $a ] should be a: Character.
[ #aSymbol ] should be a: #symbol.
[ 2 ] should not be a: Symbol.
[ 3.14 ] should not be a: Set.
[ 'some string' ] should not be an: Array.
[ $a ] should not be a: #collection.
[ #aSymbol ] should not be a: Character.
```

### Checking numbers against a range

You can see if a number falls in a range of values with `be:`.  You should always use this to check floating point values.

```smalltalk
[ 5.2 ] should be: 5.1 +- 1.3.
[ 5.2 ] should be: 5.1 +- 0.1.
[ 5.2 ] should not be: 5.4 +- 0.1.
```

### Checking for emptiness

You can easily check that a result is empty.

```smalltalk
[ #() ] should be empty.
[ Set new ] should be empty.
[ '' ] should be empty.
[ #(1 2 3) ] should not be empty.
[ Set with: 'contents' ] should not be empty.
[ 'some string' ] should not be empty.
```

### Checking a collection contains a value

You can use both `contain:` and `contain value:` to check an element is in a collection.

```smalltalk
[ 'some string' ] should contain: $t.
[ #(1 2 3) ] should contain: 1.
[ Set with: #aSymbol ] should contain: #aSymbol.
[ 'some string' ] should not contain: $x.
[ #(1 2 3) ] should not contain: 4.
[ Set with: #aSymbol ] should not contain: #anotherSymbol.
d := { #one->1 . #two->2 . #three->3 } asDictionary.
a := #(1 $x #aSymbol).
[ d ] should contain value: 1.
[ d ] should contain value: 2.
[ a ] should contain value: $x.
[ d ] should not contain value: 4.
[ a ] should not contain value: #anotherSymbol.
```

### Checking a Dictionary contains a key

Use `contain key:` to check a key is in a Dictionary.

```smalltalk
d := { #one->1 . #two->2 . #three->3 } asDictionary.
[ d ] should contain key: #one.
[ d ] should contain key: #two.
[ d ] should not contain key: #four.
```

### More complex collection checks

```smalltalk
[ 'some string' ] should contain oneOf: 'asx'.
[ #(1 2 3) ] should contain oneOf: #(3 4 5).
[ Set with: #aSymbol ] should contain oneOf: #(#aSymbol #anotherSymbol).
[ 'some string' ] should not contain oneOf: 'mtg'.
[ #(1 2 3) ] should not contain oneOf: #(2 3 4).
[ Set with: #aSymbol with: #anotherSymbol ] should not contain oneOf: #(#aSymbol #anotherSymbol).
```

```smalltalk
[ 'some string' ] should contain atLeastOneOf: 'asg'.
[ #(1 2 3) ] should contain atLeastOneOf: #(3 4 5).
[ Set with: #aSymbol ] should contain atLeastOneOf: #(#aSymbol #anotherSymbol).
[ 'some string' ] should not contain atLeastOneOf: 'xyz'.
[ #(1 2 3) ] should not contain atLeastOneOf: #(4 5 6).
[ Set with: #aSymbol with: #anotherSymbol ] should not contain atLeastOneOf: #(#someSymbol #someOtherSymbol).
```

```smalltalk
[ 'some string' ] should contain atMostOneOf: 'asx'.
[ #(1 2 3) ] should contain atMostOneOf: #(4 5 6).
[ Set with: #aSymbol ] should contain atMostOneOf: #(#aSymbol #anotherSymbol).
[ 'some string' ] should not contain atMostOneOf: 'smx'.
[ #(1 2 3) ] should not contain atMostOneOf: #(2 3 4).
[ Set with: #aSymbol with: #anotherSymbol ] should not contain atMostOneOf: #(#aSymbol #anotherSymbol).
```

```smalltalk
[ 'some string' ] should contain noneOf: 'xyz'.
[ #(1 2 3) ] should contain noneOf: #(4 5 6).
[ Set with: #aSymbol ] should contain noneOf: #(#someSymbol #anotherSymbol).
[ 'some string' ] should not contain noneOf: 'mtg'.
[ #(1 2 3) ] should not contain noneOf: #(3 4 5).
[ Set with: #aSymbol with: #anotherSymbol ] should not contain noneOf: #(#aSymbol #anotherSymbol).
```

```smalltalk
[ 'some string' ] should contain allOf: 'msg'.
[ #(1 2 3) ] should contain allOf: #(1 3 1).
[ Set with: #aSymbol ] should contain allOf: #(#aSymbol).
[ 'some string' ] should not contain allOf: 'smx'.
[ #(1 2 3) ] should not contain allOf: #(2 3 4).
[ Set with: #aSymbol with: #anotherSymbol ] should not contain allOf: #(#someSymbol #anotherSymbol).
```

```smalltalk
[ 'some string' ] should contain only: ' egimnorst'.
[ #(1 2 3 2) ] should contain only: #(1 3 1 2).
[ Set with: #aSymbol ] should contain only: #(#aSymbol).
[ 'some string' ] should not contain only: 'smx'.
[ #(1 2 3) ] should not contain only: #(2 3 4).
[ Set with: #aSymbol with: #anotherSymbol ] should not contain only: #(#someSymbol #anotherSymbol).
```

```smalltalk
[ 'some string' ] should contain theSameElementsAs: ' egimnorsst'.
[ #(1 2 3 2) ] should contain theSameElementsAs: #(1 3 2 2).
[ Set with: #aSymbol ] should contain theSameElementsAs: #(#aSymbol).
[ 'some string' ] should not contain theSameElementsAs: 'smx'.
[ #(1 2 3) ] should not contain theSameElementsAs: #(2 3 4).
[ Set with: #aSymbol with: #anotherSymbol ] should not contain theSameElementsAs: #(#someSymbol #anotherSymbol).
```

```smalltalk
[ 'some string' ] should contain theSameElementsInOrderAs: 'some string'.
[ #(1 2 3 2) ] should contain theSameElementsInOrderAs: #(1 2 3 2).
[ Set with: #aSymbol ] should contain theSameElementsInOrderAs: #(#aSymbol).
[ 'some string' ] should not contain theSameElementsInOrderAs: 'smx'.
[ #(1 2 3) ] should not contain theSameElementsInOrderAs: #(3 2 1).
[ Set with: #aSymbol with: #anotherSymbol ] should not contain theSameElementsInOrderAs: #(#someSymbol #anotherSymbol).
```

### Checking exceptions

You can check that specific exceptions get thrown.  The test checks if the specified exception or any subclass is thrown.

```smalltalk
[ 1 / 0 ] should throw: ZeroDivide.
[ #() first ] should throw: SubscriptOutOfBounds.
[ 0 / 1 ] should not throw: ZeroDivide.
[ #(1) first ] should not throw: SubscriptOutOfBounds.
```
