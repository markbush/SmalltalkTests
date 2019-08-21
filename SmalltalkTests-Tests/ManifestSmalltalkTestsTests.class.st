"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestSmalltalkTestsTests,
	#superclass : #PackageManifest,
	#category : #'SmalltalkTests-Tests-Manifest'
}

{ #category : #'code-critics' }
ManifestSmalltalkTestsTests class >> ruleRBLongMethodsRuleV1FalsePositive [
	^ #(#(#(#RGPackageDefinition #(#'SmalltalkTests-Tests')) #'2019-08-21T07:09:19.606754+01:00') )
]

{ #category : #'code-critics' }
ManifestSmalltalkTestsTests class >> ruleRBNotEliminationRuleV1FalsePositive [
	^ #(#(#(#RGPackageDefinition #(#'SmalltalkTests-Tests')) #'2019-08-21T07:09:54.643315+01:00') )
]
