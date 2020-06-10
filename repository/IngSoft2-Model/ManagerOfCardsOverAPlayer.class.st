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

{ #category : #'as yet unclassified' }
ManagerOfCardsOverAPlayer class >> creadoPara: aPlayer [
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

{ #category : #'as yet unclassified' }
ManagerOfCardsOverAPlayer >> initializeForPlayer: aPlayer [
	cardsAffectingThePlayer := OrderedCollection new.
	player := aPlayer.
]

{ #category : #'as yet unclassified' }
ManagerOfCardsOverAPlayer >> player [
	^ player
]

{ #category : #'as yet unclassified' }
ManagerOfCardsOverAPlayer >> removeCard: aCard [
	cardsAffectingThePlayer remove: aCard
]
