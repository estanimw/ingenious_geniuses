"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestIngSoftModel,
	#superclass : #PackageManifest,
	#category : #'IngSoft2-Model-Manifest'
}

{ #category : #'code-critics' }
ManifestIngSoftModel class >> ruleGRGuardClauseRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#Game #playTurn #false)) #'2020-08-11T11:58:16.600877-03:00') )
]

{ #category : #'code-critics' }
ManifestIngSoftModel class >> ruleRBGuardingClauseRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#Game #playTurn #false)) #'2020-08-11T11:58:22.505295-03:00') )
]
