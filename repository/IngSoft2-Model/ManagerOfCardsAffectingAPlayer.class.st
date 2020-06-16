"
Equivale a DeckHandler.
"
Class {
	#name : #ManagerOfCardsAffectingAPlayer,
	#superclass : #Object,
	#instVars : [
		'player',
		'cardsAffectingThePlayer'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
ManagerOfCardsAffectingAPlayer class >> forPlayer: aPlayer [
	^(self new) initializeForPlayer: aPlayer.
]

{ #category : #adding }
ManagerOfCardsAffectingAPlayer >> addCardToAffectThePlayer: aCard [
	cardsAffectingThePlayer add: aCard.
]

{ #category : #'as yet unclassified' }
ManagerOfCardsAffectingAPlayer >> calculateTotalEffectOverThePlayer [
	| retorno |
	retorno := 0.
	cardsAffectingThePlayer
		do: [ :carta | retorno := retorno + carta effect ].
	^ retorno
]

{ #category : #accessing }
ManagerOfCardsAffectingAPlayer >> cardsAffectingThePlayer [
	^ cardsAffectingThePlayer
]

{ #category : #initialization }
ManagerOfCardsAffectingAPlayer >> initializeForPlayer: aPlayer [
	cardsAffectingThePlayer := OrderedCollection new.
	player := aPlayer.
]

{ #category : #accessing }
ManagerOfCardsAffectingAPlayer >> player [
	^ player
]

{ #category : #'as yet unclassified' }
ManagerOfCardsAffectingAPlayer >> removeCard: aCardClass [
	cardsAffectingThePlayer
		detect: [ :card | card isMemberOf: aCardClass ]
		ifFound: [ :card | cardsAffectingThePlayer remove: card ]
		ifNone: [ Error signal: 'There isn`t that card affecting this player' ]
]
