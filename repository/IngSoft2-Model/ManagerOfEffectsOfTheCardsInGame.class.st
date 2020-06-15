"
Equivale a Deck.
"
Class {
	#name : #ManagerOfEffectsOfTheCardsInGame,
	#superclass : #Object,
	#instVars : [
		'lastCardPlayed',
		'managersOfCardsOverAPlayer'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
ManagerOfEffectsOfTheCardsInGame class >> createFor: aSetOfPlayers [ 
	^(self new) initializeForPlayers: aSetOfPlayers.
]

{ #category : #'as yet unclassified' }
ManagerOfEffectsOfTheCardsInGame >> addCard: aCard toPlayer: aPlayer [
	managersOfCardsOverAPlayer
		detect:
			[ :unManejadorCartasAfectandoAUnJugador | unManejadorCartasAfectandoAUnJugador player == aPlayer ]
		ifFound:
			[ :unManejadorCartasAfectandoAUnJugador | unManejadorCartasAfectandoAUnJugador addCardToAffectThePlayer: aCard ].
	self updateLastCardPlayed: aCard
]

{ #category : #'as yet unclassified' }
ManagerOfEffectsOfTheCardsInGame >> addCardToAllPlayers: aCard [
	managersOfCardsOverAPlayer
		do:
			[ :unManejadorCartasAfectandoAUnJugador | unManejadorCartasAfectandoAUnJugador addCardToAffectThePlayer: aCard ].
	self updateLastCardPlayed: aCard
]

{ #category : #'as yet unclassified' }
ManagerOfEffectsOfTheCardsInGame >> cancelCardOnTarget: aTarget [
	| theCard targetPlayer |
	self thereIsAtLeastOneCardActiveInGame
		ifTrue: [ theCard := aTarget at: 1.
			targetPlayer := aTarget at: 2.
			self managersOfCardsOverAPlayer
				detect: [ :manager | manager player == targetPlayer ]
				ifFound: [ :manager | 
					manager cardsAffectingThePlayer
						detect: [ :card | card isMemberOf: theCard ]
						ifFound: [ :card | 
							manager removeCard: card.
							self updateLastCardPlayed: (Cancellation create) ] ] ]
		ifFalse: [ Error signal: 'There aren`t permanent cards in game' ]
]

{ #category : #'as yet unclassified' }
ManagerOfEffectsOfTheCardsInGame >> cardsAffectingPlayer: aPlayer [ 
	managersOfCardsOverAPlayer detect: [ :manager | manager player == aPlayer ] ifFound: [ :manager | ^ manager cardsAffectingThePlayer size ].
]

{ #category : #'as yet unclassified' }
ManagerOfEffectsOfTheCardsInGame >> initializeForPlayers: aSetOfPlayers [
	| aux |
	managersOfCardsOverAPlayer := OrderedCollection new.
	aSetOfPlayers do: [ :aPlayer | 
		aux := ManagerOfCardsOverAPlayer forPlayer: aPlayer.
		managersOfCardsOverAPlayer add: aux.
	]
]

{ #category : #query }
ManagerOfEffectsOfTheCardsInGame >> lastCardPlayed [
	^ lastCardPlayed
]

{ #category : #accessing }
ManagerOfEffectsOfTheCardsInGame >> managersOfCardsOverAPlayer [
	^ managersOfCardsOverAPlayer
]

{ #category : #'as yet unclassified' }
ManagerOfEffectsOfTheCardsInGame >> removeCard: aCard fromPlayer: aPlayer [
	managersOfCardsOverAPlayer
		detect:
			[ :unManejadorCartasAfectandoAUnJugador | unManejadorCartasAfectandoAUnJugador player == aPlayer ]
		ifFound:
			[ :unManejadorCartasAfectandoAUnJugador | unManejadorCartasAfectandoAUnJugador removeCard: aCard ].
	self updateLastCardPlayed: aCard
]

{ #category : #'as yet unclassified' }
ManagerOfEffectsOfTheCardsInGame >> thereIsAtLeastOneCardActiveInGame [
	managersOfCardsOverAPlayer
		detect:
			[ :cartasDeUnJugador | cartasDeUnJugador cardsAffectingThePlayer isNotEmpty ]
		ifFound: [ ^ true ].
	^ false
]

{ #category : #'as yet unclassified' }
ManagerOfEffectsOfTheCardsInGame >> totalEffectOver: aPlayer [
	managersOfCardsOverAPlayer
		detect:
			[ :unManejadorCartasAfectandoAUnJugador | unManejadorCartasAfectandoAUnJugador player == aPlayer ]
		ifFound:
			[ :unManejadorCartasAfectandoAUnJugador | ^ unManejadorCartasAfectandoAUnJugador calculateTotalEffectOverThePlayer ]
]

{ #category : #'as yet unclassified' }
ManagerOfEffectsOfTheCardsInGame >> updateLastCardPlayed: aCard [
	lastCardPlayed := aCard.
]
