"
Equivale a DeckHandler.
"
Class {
	#name : #ManagerOfCardsOverAPlayer,
	#superclass : #Object,
	#instVars : [
		'player',
		'cardsAffectingThePlayer'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
ManagerOfCardsOverAPlayer class >> forPlayer: aPlayer [
	^(self new) initializeForPlayer: aPlayer.
]

{ #category : #adding }
ManagerOfCardsOverAPlayer >> addCardToAffectThePlayer: aCard [
	cardsAffectingThePlayer add: aCard.
]

{ #category : #'as yet unclassified' }
ManagerOfCardsOverAPlayer >> calculateTotalEffectOverThePlayer [
	| retorno |
	retorno := 0.
	cardsAffectingThePlayer do: [ :carta | retorno := retorno + (carta effect)].
	^retorno.
]

{ #category : #accessing }
ManagerOfCardsOverAPlayer >> cardsAffectingThePlayer [
	^ cardsAffectingThePlayer
]

{ #category : #initialization }
ManagerOfCardsOverAPlayer >> initializeForPlayer: aPlayer [
	cardsAffectingThePlayer := OrderedCollection new.
	player := aPlayer.
]

{ #category : #accessing }
ManagerOfCardsOverAPlayer >> player [
	^ player
]

{ #category : #'as yet unclassified' }
ManagerOfCardsOverAPlayer >> removeCard: aCard [
	(cardsAffectingThePlayer includes: aCard) ifTrue: [cardsAffectingThePlayer remove: aCard] ifFalse: [ Error signal: 'There isn`t that card affecting this player' ].
]
