Class {
	#name : #ManejadorDeEfectosDeLasCartasTest,
	#superclass : #TestCase,
	#instVars : [
		'juan',
		'pancho',
		'aBoard',
		'numberOfRoundsToBePlayed',
		'dieOf4',
		'dieOf6',
		'aDice',
		'cards'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
ManejadorDeEfectosDeLasCartasTest >> testAfectanDiferentesCartasAUnJugador [
	| setOfPlayers managerDeEfectos unaCarta |
	setOfPlayers := { 'juan' . 'pancho' }.
	managerDeEfectos := ManagerOfEffectsOfTheCardsInGame crearCon: setOfPlayers.
	unaCarta := Overload creacionDeCarta.
	managerDeEfectos addCard: unaCarta toPlayer: 'juan'.
	unaCarta := Speed creacionDeCarta.
	managerDeEfectos addCard: unaCarta toPlayer: 'juan'.
	unaCarta := Speed creacionDeCarta.
	managerDeEfectos addCard: unaCarta toPlayer: 'juan'.
	unaCarta := Acceleration creacionDeCarta.
	managerDeEfectos addCardToAllPlayers: unaCarta.
	self assert: (managerDeEfectos totalEffectOver: 'juan') equals: 1.
	self assert: (managerDeEfectos totalEffectOver: 'pancho') equals: 1.
]

{ #category : #tests }
ManejadorDeEfectosDeLasCartasTest >> testAfectanDosCartasAUnJugador [
	| setOfPlayers managerDeEfectos unaCarta |
	setOfPlayers := { 'juan' . 'pancho' }.
	managerDeEfectos := ManagerOfEffectsOfTheCardsInGame crearCon: setOfPlayers.
	unaCarta := Overload creacionDeCarta.
	managerDeEfectos addCard: unaCarta toPlayer: 'juan'.
	managerDeEfectos addCard: unaCarta toPlayer: 'juan'.
	self assert: (managerDeEfectos totalEffectOver: 'juan') equals: -4.
	self assert: (managerDeEfectos totalEffectOver: 'pancho') equals: 0.
]

{ #category : #tests }
ManejadorDeEfectosDeLasCartasTest >> testInicializaVacio [
	| setOfPlayers managerDeEfectos |
	setOfPlayers := { 'juan' . 'pancho' }.
	managerDeEfectos := ManagerOfEffectsOfTheCardsInGame crearCon: setOfPlayers.
	self assert: (managerDeEfectos totalEffectOver: 'juan') equals: 0.
	self assert: (managerDeEfectos totalEffectOver: 'pancho') equals: 0.
]
