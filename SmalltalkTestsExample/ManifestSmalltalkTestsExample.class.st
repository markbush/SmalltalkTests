"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestSmalltalkTestsExample,
	#superclass : #PackageManifest,
	#category : #'SmalltalkTestsExample-Manifest'
}

{ #category : #'code-critics' }
ManifestSmalltalkTestsExample class >> ruleReTestClassNotInPackageWithTestEndingNameV1FalsePositive [
	^ #(#(#(#RGPackageDefinition #(#SmalltalkTestsExample)) #'2019-08-21T07:14:50.472573+01:00') )
]
