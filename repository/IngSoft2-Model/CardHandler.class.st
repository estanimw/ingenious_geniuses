Class {
	#name : #CardHandler,
	#superclass : #Object,
	#instVars : [
		'typesOfCards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
CardHandler class >> withTheValidCards: aSetOfCards [
	^self new initializeWithCards: aSetOfCards
]

{ #category : #'as yet unclassified' }
CardHandler >> giveCard [
	| card |
	card := (typesOfCards atRandom) new.
	^ card
]

{ #category : #'as yet unclassified' }
CardHandler >> initializeWithCards: aSetOfCards [ 
	typesOfCards := aSetOfCards.
]

{ #category : #'as yet unclassified' }
CardHandler >> typesOfCards [
	^typesOfCards 
]
