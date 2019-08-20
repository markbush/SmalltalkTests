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

## Available tests

### Checking equality

Either `===` or `equal:` will test for equality.

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

