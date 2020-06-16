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
			[ :unManejadorCartasAfectandoAUnJugador | unManejadorCartasAfectandoAUnJugador player == aPlayer ]
		ifFound:
			[ :unManejadorCartasAfectandoAUnJugador | unManejadorCartasAfectandoAUnJugador addCardToAffectThePlayer: aCard ].
	self updateLastCardPlayed: aCard
]

{ #category : #'card handling' }
ManagerOfTheCardsActiveInGame >> addCardToAllPlayers: aCard [
	managersOfCardsAffectingAPlayer
		do:
			[ :unManejadorCartasAfectandoAUnJugador | unManejadorCartasAfectandoAUnJugador addCardToAffectThePlayer: aCard ].
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
		detect: [ :manager | manager player == aPlayer ]
		ifFound: [ :manager | ^ manager cardsAffectingThePlayer size ]
]

{ #category : #'card handling' }
ManagerOfTheCardsActiveInGame >> removeCard: aCardClass fromPlayer: aPlayer [
	managersOfCardsAffectingAPlayer
		detect:
			[ :aManagerOfCardsOverAPlayer | aManagerOfCardsOverAPlayer player == aPlayer ]
		ifFound:
			[ :unManejadorCartasAfectandoAUnJugador | unManejadorCartasAfectandoAUnJugador removeCard: aCardClass ].
	self updateLastCardPlayed: Cancellation createCard
]

{ #category : #utilities }
ManagerOfTheCardsActiveInGame >> thereIsAtLeastOneCardActiveInGame [
	managersOfCardsAffectingAPlayer
		detect:
			[ :cartasDeUnJugador | cartasDeUnJugador cardsAffectingThePlayer isNotEmpty ]
		ifFound: [ ^ true ].
	^ false
]

{ #category : #calculations }
ManagerOfTheCardsActiveInGame >> totalEffectOver: aPlayer [
	managersOfCardsAffectingAPlayer
		detect:
			[ :unManejadorCartasAfectandoAUnJugador | unManejadorCartasAfectandoAUnJugador player == aPlayer ]
		ifFound:
			[ :unManejadorCartasAfectandoAUnJugador | ^ unManejadorCartasAfectandoAUnJugador calculateTotalEffectOverThePlayer ]
]

{ #category : #'card handling' }
ManagerOfTheCardsActiveInGame >> updateLastCardPlayed: aCard [
	lastCardPlayed := aCard.
]
