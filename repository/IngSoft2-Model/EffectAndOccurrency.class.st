"
An Object
"
Class {
	#name : #EffectAndOccurrency,
	#superclass : #Object,
	#instVars : [
		'effect',
		'occurrency'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
EffectAndOccurrency class >> withEffect: anEffect andOccurrencyOf: anOdd [
	^self new initializeWithEffect: anEffect andOccurrencyOf: anOdd.
]

{ #category : #accessing }
EffectAndOccurrency >> effect [
	^ effect
]

{ #category : #initialization }
EffectAndOccurrency >> initializeWithEffect: anEffect andOccurrencyOf: anOdd [
	effect := anEffect.
	occurrency := anOdd.
]

{ #category : #accessing }
EffectAndOccurrency >> occurrency [
	^ occurrency
]
