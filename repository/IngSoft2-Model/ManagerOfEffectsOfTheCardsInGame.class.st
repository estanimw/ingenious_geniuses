Class {
	#name : #ManagerOfEffectsOfTheCardsInGame,
	#superclass : #Object,
	#instVars : [
		'setManejadorCartasAfectandoAUnJugador'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
ManagerOfEffectsOfTheCardsInGame class >> crearCon: aSetOfPlayers [ 
	^(self new) initializeForPlayers: aSetOfPlayers.
]

{ #category : #'as yet unclassified' }
ManagerOfEffectsOfTheCardsInGame >> addCard: aCard toPlayer: aPlayer [
	setManejadorCartasAfectandoAUnJugador detect: [ :unManejadorCartasAfectandoAUnJugador | unManejadorCartasAfectandoAUnJugador player == aPlayer ] ifFound: [ :unManejadorCartasAfectandoAUnJugador | unManejadorCartasAfectandoAUnJugador addCardToAffectThePlayer: aCard ]
]

{ #category : #'as yet unclassified' }
ManagerOfEffectsOfTheCardsInGame >> addCardToAllPlayers: aCard [
	setManejadorCartasAfectandoAUnJugador do: [ :unManejadorCartasAfectandoAUnJugador | unManejadorCartasAfectandoAUnJugador addCardToAffectThePlayer: aCard ]
]

{ #category : #'as yet unclassified' }
ManagerOfEffectsOfTheCardsInGame >> initializeForPlayers: aSetOfPlayers [
	| aux |
	setManejadorCartasAfectandoAUnJugador := OrderedCollection new.
	aSetOfPlayers do: [ :aPlayer | 
		aux := ManagerOfCardsOverAPlayer creadoPara: aPlayer.
		setManejadorCartasAfectandoAUnJugador add: aux.
	]
]

{ #category : #'as yet unclassified' }
ManagerOfEffectsOfTheCardsInGame >> totalEffectOver: aPlayer [
	setManejadorCartasAfectandoAUnJugador
		detect:
			[ :unManejadorCartasAfectandoAUnJugador | unManejadorCartasAfectandoAUnJugador player == aPlayer ]
		ifFound:
			[ :unManejadorCartasAfectandoAUnJugador | ^ unManejadorCartasAfectandoAUnJugador calculateTotalEffectOverThePlayer ]
]
