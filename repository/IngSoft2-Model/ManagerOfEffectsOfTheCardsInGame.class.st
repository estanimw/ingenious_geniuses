"
Equivale a Deck.
"
Class {
	#name : #ManagerOfEffectsOfTheCardsInGame,
	#superclass : #Object,
	#instVars : [
		'setManejadorCartasAfectandoAUnJugador',
		'lastCardPlayed'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
ManagerOfEffectsOfTheCardsInGame class >> crearCon: aSetOfPlayers [ 
	^(self new) initializeForPlayers: aSetOfPlayers.
]

{ #category : #'as yet unclassified' }
ManagerOfEffectsOfTheCardsInGame >> addCard: aCard toPlayer: aPlayer [
	setManejadorCartasAfectandoAUnJugador detect: [ :unManejadorCartasAfectandoAUnJugador | unManejadorCartasAfectandoAUnJugador player == aPlayer ] ifFound: [ :unManejadorCartasAfectandoAUnJugador | unManejadorCartasAfectandoAUnJugador addCardToAffectThePlayer: aCard ].
	lastCardPlayed := aCard class.
]

{ #category : #'as yet unclassified' }
ManagerOfEffectsOfTheCardsInGame >> addCardToAllPlayers: aCard [
	setManejadorCartasAfectandoAUnJugador do: [ :unManejadorCartasAfectandoAUnJugador | unManejadorCartasAfectandoAUnJugador addCardToAffectThePlayer: aCard ]
]

{ #category : #'as yet unclassified' }
ManagerOfEffectsOfTheCardsInGame >> cardsAffectingPlayer: aPlayer [ 
	setManejadorCartasAfectandoAUnJugador detect: [ :manager | manager player == aPlayer ] ifFound: [ :manager | ^ manager cardsAffectingThePlayer size ].
]

{ #category : #'as yet unclassified' }
ManagerOfEffectsOfTheCardsInGame >> hayAlMenosUnaCartaPermanenteActiva [
	setManejadorCartasAfectandoAUnJugador detect: [ :cartasDeUnJugador | cartasDeUnJugador cardsAffectingThePlayer isNotEmpty] ifFound: [^true].
	^false.
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

{ #category : #query }
ManagerOfEffectsOfTheCardsInGame >> lastCardPlayed [
	^ lastCardPlayed
]

{ #category : #accessing }
ManagerOfEffectsOfTheCardsInGame >> setManejadorCartasAfectandoAUnJugador [
	^ setManejadorCartasAfectandoAUnJugador
]

{ #category : #'as yet unclassified' }
ManagerOfEffectsOfTheCardsInGame >> totalEffectOver: aPlayer [
	setManejadorCartasAfectandoAUnJugador
		detect:
			[ :unManejadorCartasAfectandoAUnJugador | unManejadorCartasAfectandoAUnJugador player == aPlayer ]
		ifFound:
			[ :unManejadorCartasAfectandoAUnJugador | ^ unManejadorCartasAfectandoAUnJugador calculateTotalEffectOverThePlayer ]
]
