"
An Object
"
Class {
	#name : #EffectAndProbability,
	#superclass : #Object,
	#instVars : [
		'effect',
		'occurrency'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
EffectAndProbability class >> withEffect: anEffect andOccurrencyOf: anOdd [
	^self new initializeWithEffect: anEffect andOccurrencyOf: anOdd.
]

{ #category : #accessing }
EffectAndProbability >> effect [
	^ effect
]

{ #category : #initialization }
EffectAndProbability >> initializeWithEffect: anEffect andOccurrencyOf: anOdd [
	effect := anEffect.
	occurrency := anOdd.
]

{ #category : #accessing }
EffectAndProbability >> occurrency [
	^ occurrency
]
