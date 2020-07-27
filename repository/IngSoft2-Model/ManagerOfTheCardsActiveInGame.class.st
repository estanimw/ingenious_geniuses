"
Equivale a Deck.
"
Class {
	#name : #ManagerOfTheCardsActiveInGame,
	#superclass : #Object,
	#instVars : [
		'lastCardPlayed',
		'managersOfCardsAffectingAPlayer'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
ManagerOfTheCardsActiveInGame class >> createFor: aSetOfPlayers [ 
	^(self new) initializeForPlayers: aSetOfPlayers.
]

{ #category : #'card handling' }
ManagerOfTheCardsActiveInGame >> addCard: aCard toPlayer: aPlayer [
	managersOfCardsAffectingAPlayer
		detect:
			[ :aManagerOfCardsAffectingAPlayer | aManagerOfCardsAffectingAPlayer player == aPlayer ]
		ifFound:
			[ :aManagerOfCardsAffectingAPlayer | aManagerOfCardsAffectingAPlayer addCardToAffectThePlayer: aCard ].
	self updateLastCardPlayed: aCard
]

{ #category : #'card handling' }
ManagerOfTheCardsActiveInGame >> addCardToAllPlayers: aCard [
	managersOfCardsAffectingAPlayer
		do:
			[ :aManagerOfCardsAffectingAPlayer | aManagerOfCardsAffectingAPlayer addCardToAffectThePlayer: aCard ].
	self updateLastCardPlayed: aCard
]

{ #category : #'card handling' }
ManagerOfTheCardsActiveInGame >> cancelCardOnTarget: aTarget [
	| theCardClass targetPlayer |
	theCardClass := aTarget at: 1.
	targetPlayer := aTarget at: 2.
	self thereIsAtLeastOneCardActiveInGame
		ifTrue: [ self removeCard: theCardClass fromPlayer: targetPlayer ]
		ifFalse: [ Error signal: 'There aren`t permanent cards in game' ]
]

{ #category : #initialization }
ManagerOfTheCardsActiveInGame >> initializeForPlayers: aSetOfPlayers [
	| aux |
	lastCardPlayed := Card new.
	managersOfCardsAffectingAPlayer := OrderedCollection new.
	aSetOfPlayers
		do: [ :aPlayer | 
			aux := ManagerOfCardsAffectingAPlayer forPlayer: aPlayer.
			managersOfCardsAffectingAPlayer add: aux ]
]

{ #category : #query }
ManagerOfTheCardsActiveInGame >> lastCardPlayed [
	^ lastCardPlayed
]

{ #category : #utilities }
ManagerOfTheCardsActiveInGame >> numberOfCardsAffectingPlayer: aPlayer [
	managersOfCardsAffectingAPlayer
		detect: [ :aManagerOfCardsAffectingAPlayer | aManagerOfCardsAffectingAPlayer player == aPlayer ]
		ifFound: [ :aManagerOfCardsAffectingAPlayer | ^ aManagerOfCardsAffectingAPlayer cardsAffectingThePlayer size ]
]

{ #category : #'card handling' }
ManagerOfTheCardsActiveInGame >> removeCard: aCardClass fromPlayer: aPlayer [
	managersOfCardsAffectingAPlayer
		detect:
			[ :aManagerOfCardsAffectingAPlayer | aManagerOfCardsAffectingAPlayer player == aPlayer ]
		ifFound:
			[ :aManagerOfCardsAffectingAPlayer | aManagerOfCardsAffectingAPlayer removeCard: aCardClass ].
	self updateLastCardPlayed: Cancellation createCard
]

{ #category : #utilities }
ManagerOfTheCardsActiveInGame >> thereIsAtLeastOneCardActiveInGame [
	managersOfCardsAffectingAPlayer
		detect:
			[ :cardsOfAPlayer | cardsOfAPlayer cardsAffectingThePlayer isNotEmpty ]
		ifFound: [ ^ true ].
	^ false
]

{ #category : #calculations }
ManagerOfTheCardsActiveInGame >> totalEffectOver: aPlayer [
	managersOfCardsAffectingAPlayer
		detect:
			[ :aManagersOfCardsAffectingAPlayer | aManagersOfCardsAffectingAPlayer player == aPlayer ]
		ifFound:
			[ :aManagersOfCardsAffectingAPlayer | ^ aManagersOfCardsAffectingAPlayer calculateTotalEffectOverThePlayer ]
]

{ #category : #'card handling' }
ManagerOfTheCardsActiveInGame >> updateLastCardPlayed: aCard [
	lastCardPlayed := aCard.
]
