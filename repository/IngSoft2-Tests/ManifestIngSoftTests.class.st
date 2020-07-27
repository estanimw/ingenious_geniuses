"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestIngSoftTests,
	#superclass : #PackageManifest,
	#category : #'IngSoft2-Tests-Manifest'
}

{ #category : #'code-critics' }
ManifestIngSoftTests class >> ruleGRTemporaryNeitherReadNorWrittenRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#GameTest #testHappyPathDeterministic #false)) #'2020-07-27T15:36:14.124105-03:00') )
]

{ #category : #'code-critics' }
ManifestIngSoftTests class >> ruleRBLongMethodsRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#GameTest #testHappyPathDeterministic #false)) #'2020-07-27T15:44:17.89802-03:00') )
]
