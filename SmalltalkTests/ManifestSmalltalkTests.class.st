"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestSmalltalkTests,
	#superclass : #PackageManifest,
	#category : #'SmalltalkTests-Manifest'
}

{ #category : #'code-critics' }
ManifestSmalltalkTests class >> ruleRBBadMessageRuleV1FalsePositive [
	^ #(#(#(#RGPackageDefinition #(#SmalltalkTests)) #'2019-08-21T07:05:26.76983+01:00') )
]

{ #category : #'code-critics' }
ManifestSmalltalkTests class >> ruleRBInconsistentMethodClassificationRuleV1FalsePositive [
	^ #(#(#(#RGPackageDefinition #(#SmalltalkTests)) #'2019-08-21T07:06:09.374839+01:00') )
]
