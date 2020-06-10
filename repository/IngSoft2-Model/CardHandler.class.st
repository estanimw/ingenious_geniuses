"
Un mazo infinito de cartas.
"
Class {
	#name : #CardHandler,
	#superclass : #Object,
	#instVars : [
		'typesOfCards',
		'generator'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
CardHandler class >> withTheFollowingTypeOfCards: aSetOfCards [
	^ self new
		initializeWithCards: aSetOfCards
		andDistributionGenerator: SharedRandom globalGenerator.
]

{ #category : #'as yet unclassified' }
CardHandler class >> withTheFollowingTypesOfCards: aSetOfCards andGenerator: aGenerator [
	^ self new
		initializeWithCards: aSetOfCards
		andDistributionGenerator: aGenerator.
]

{ #category : #'as yet unclassified' }
CardHandler >> giveCard [
	| card |
	card := (typesOfCards atRandom: generator) new.
	^ card
]

{ #category : #initialization }
CardHandler >> initializeWithCards: aSetOfCards andDistributionGenerator: aGenerator [ 
	typesOfCards := aSetOfCards.
	generator := aGenerator.
]

{ #category : #accessing }
CardHandler >> typesOfCards [
	^typesOfCards 
]
