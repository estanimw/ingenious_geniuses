Class {
	#name : #ManagerOfCardActiveInGameTest,
	#superclass : #TestCase,
	#instVars : [
		'juan',
		'pancho'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #running }
ManagerOfCardActiveInGameTest >> setUp [
	juan := 'juan'.
	pancho := 'pancho'.

]

{ #category : #tests }
ManagerOfCardActiveInGameTest >> testAllManagersOfCardsOverAPlayerInitializeEmpty [
	| setOfPlayers managerOfCardsActiveInGame |
	setOfPlayers := { juan . pancho }.
	managerOfCardsActiveInGame := ManagerOfTheCardsActiveInGame createFor: setOfPlayers.
	self assert: (managerOfCardsActiveInGame totalEffectOver: juan) equals: 0.
	self assert: (managerOfCardsActiveInGame totalEffectOver: pancho) equals: 0.
]

{ #category : #tests }
ManagerOfCardActiveInGameTest >> testCantRemoveACardThatIsNotActiveOverAPlayer [
	| setOfPlayers managerOfCardsActiveInGame aCard |
	setOfPlayers := {juan . pancho}.
	managerOfCardsActiveInGame := ManagerOfTheCardsActiveInGame createFor: setOfPlayers.
	self assert: (managerOfCardsActiveInGame numberOfCardsAffectingPlayer: juan) equals: 0.
	aCard := Overload createCard.
	managerOfCardsActiveInGame addCard: aCard toPlayer: juan.
	managerOfCardsActiveInGame addCard: aCard toPlayer: juan.
	self assert: (managerOfCardsActiveInGame numberOfCardsAffectingPlayer: juan) equals: 2.
	aCard := Speed createCard.
	self should: [managerOfCardsActiveInGame removeCard: aCard fromPlayer: juan] raise: Error withMessageText: 'There isn`t that card affecting this player'.
]

{ #category : #tests }
ManagerOfCardActiveInGameTest >> testDifferentCardsAffectAPlayer [
	| setOfPlayers managerOfCardsActiveInGame aCard |
	setOfPlayers := { juan . pancho }.
	managerOfCardsActiveInGame := ManagerOfTheCardsActiveInGame createFor: setOfPlayers.
	aCard := Overload createCard.
	managerOfCardsActiveInGame addCard: aCard toPlayer: juan.
	aCard := Speed createCard.
	managerOfCardsActiveInGame addCard: aCard toPlayer: juan.
	aCard := Speed createCard.
	managerOfCardsActiveInGame addCard: aCard toPlayer: juan.
	aCard := Acceleration createCard.
	managerOfCardsActiveInGame addCardToAllPlayers: aCard.
	self assert: (managerOfCardsActiveInGame numberOfCardsAffectingPlayer: juan) equals: 4.
	self
		assert: (managerOfCardsActiveInGame numberOfCardsAffectingPlayer: pancho)
		equals: 1.
]

{ #category : #tests }
ManagerOfCardActiveInGameTest >> testManagerOfEffectsOfTheCardsInGameRemovesAnActiveCardFromAPlayer [
	| setOfPlayers managerOfCardsActiveInGame aCard |
	setOfPlayers := {juan . pancho}.
	managerOfCardsActiveInGame := ManagerOfTheCardsActiveInGame createFor: setOfPlayers.
	self assert: (managerOfCardsActiveInGame numberOfCardsAffectingPlayer: juan) equals: 0.
	aCard := Overload createCard.
	managerOfCardsActiveInGame addCard: aCard toPlayer: juan.
	managerOfCardsActiveInGame addCard: aCard toPlayer: juan.
	self assert: (managerOfCardsActiveInGame numberOfCardsAffectingPlayer: juan) equals: 2.
	managerOfCardsActiveInGame removeCard: Overload fromPlayer: juan.
	self assert: (managerOfCardsActiveInGame numberOfCardsAffectingPlayer: juan) equals: 1.
]

{ #category : #tests }
ManagerOfCardActiveInGameTest >> testSomeCardsAffectEachPlayer [
	| setOfPlayers managerOfCardsActiveInGame aCard |
	setOfPlayers := {juan.
	pancho}.
	managerOfCardsActiveInGame := ManagerOfTheCardsActiveInGame
		createFor: setOfPlayers.
	aCard := Overload createCard.
	managerOfCardsActiveInGame addCard: aCard toPlayer: juan.
	aCard := Speed createCard.
	managerOfCardsActiveInGame addCard: aCard toPlayer: juan.
	aCard := Speed createCard.
	managerOfCardsActiveInGame addCard: aCard toPlayer: pancho.
	aCard := Acceleration createCard.
	managerOfCardsActiveInGame addCardToAllPlayers: aCard.
	self assert: (managerOfCardsActiveInGame numberOfCardsAffectingPlayer: juan) equals: 3.
	self
		assert: (managerOfCardsActiveInGame numberOfCardsAffectingPlayer: pancho)
		equals: 2.
]

{ #category : #tests }
ManagerOfCardActiveInGameTest >> testThereIsALeastOneCardActiveInGame [
	| setOfPlayers managerOfCardsActiveInGame aCard |
	setOfPlayers := { juan . pancho }.
	managerOfCardsActiveInGame := ManagerOfTheCardsActiveInGame createFor: setOfPlayers.
	self assert: managerOfCardsActiveInGame thereIsAtLeastOneCardActiveInGame equals: false.
	aCard := Overload createCard.
	managerOfCardsActiveInGame addCard: aCard toPlayer: juan.
	self assert: managerOfCardsActiveInGame thereIsAtLeastOneCardActiveInGame equals: true.
	aCard := Acceleration createCard.
	managerOfCardsActiveInGame addCardToAllPlayers: aCard.
	self assert: managerOfCardsActiveInGame thereIsAtLeastOneCardActiveInGame equals: true.
]

{ #category : #tests }
ManagerOfCardActiveInGameTest >> testTotalEffectOverAPlayerCanBeNegativePositivoOrCero [
	| setOfPlayers managerOfCardsActiveInGame aCard |
	setOfPlayers := {juan.pancho}.
	managerOfCardsActiveInGame := ManagerOfTheCardsActiveInGame createFor: setOfPlayers.
	self assert: (managerOfCardsActiveInGame totalEffectOver: juan) equals: 0.
	self assert: (managerOfCardsActiveInGame totalEffectOver: pancho) equals: 0.
	aCard := Speed createCard.
	managerOfCardsActiveInGame addCard: aCard toPlayer: juan.
	self assert: (managerOfCardsActiveInGame totalEffectOver: juan) equals: 1.
	self assert: (managerOfCardsActiveInGame totalEffectOver: pancho) equals: 0.
	managerOfCardsActiveInGame addCard: aCard toPlayer: juan.
	aCard := Acceleration createCard.
	managerOfCardsActiveInGame addCardToAllPlayers: aCard.
	aCard := Overload createCard.
	managerOfCardsActiveInGame addCard: aCard toPlayer: pancho.
	managerOfCardsActiveInGame addCard: aCard toPlayer: pancho.
	self assert: (managerOfCardsActiveInGame totalEffectOver: juan) equals: 3.
	self assert: (managerOfCardsActiveInGame totalEffectOver: pancho) equals: -3.
	managerOfCardsActiveInGame addCard: aCard toPlayer: juan.
	self assert: (managerOfCardsActiveInGame totalEffectOver: juan) equals: 1.
	self assert: (managerOfCardsActiveInGame totalEffectOver: pancho) equals: -3
]

{ #category : #tests }
ManagerOfCardActiveInGameTest >> testTotalEffectOverAPlayerIsTheSumOfEveryEffect [
	| setOfPlayers managerOfCardsActiveInGame aCard |
	setOfPlayers := { juan . pancho }.
	managerOfCardsActiveInGame := ManagerOfTheCardsActiveInGame createFor: setOfPlayers.
	self assert: (managerOfCardsActiveInGame totalEffectOver: juan) equals: 0.
	aCard := Speed createCard.
	managerOfCardsActiveInGame addCard: aCard toPlayer: juan.
	self assert: (managerOfCardsActiveInGame totalEffectOver: juan) equals: 1.
	aCard := Speed createCard.
	managerOfCardsActiveInGame addCard: aCard toPlayer: juan.
	aCard := Acceleration createCard.
	managerOfCardsActiveInGame addCardToAllPlayers: aCard.
	self assert: (managerOfCardsActiveInGame totalEffectOver: juan) equals: 3.
	aCard := Overload createCard.
	managerOfCardsActiveInGame addCard: aCard toPlayer: juan.
	self assert: (managerOfCardsActiveInGame totalEffectOver: juan) equals: 1.
	
]

{ #category : #tests }
ManagerOfCardActiveInGameTest >> testTotalEffectOverDifferentPlayers [
	| setOfPlayers managerOfCardsActiveInGame aCard |
	setOfPlayers := { juan . pancho }.
	managerOfCardsActiveInGame := ManagerOfTheCardsActiveInGame createFor: setOfPlayers.
	self assert: (managerOfCardsActiveInGame totalEffectOver: juan) equals: 0.
	self assert: (managerOfCardsActiveInGame totalEffectOver: pancho) equals: 0.
	aCard := Speed createCard.
	managerOfCardsActiveInGame addCard: aCard toPlayer: juan.
	self assert: (managerOfCardsActiveInGame totalEffectOver: juan) equals: 1.
	self assert: (managerOfCardsActiveInGame totalEffectOver: pancho) equals: 0.
	aCard := Overload createCard.
	managerOfCardsActiveInGame addCard: aCard toPlayer: juan.
	aCard := Acceleration createCard.
	managerOfCardsActiveInGame addCardToAllPlayers: aCard.
	self assert: (managerOfCardsActiveInGame totalEffectOver: juan) equals: 0.
	self assert: (managerOfCardsActiveInGame totalEffectOver: pancho) equals: 1.
	
]

{ #category : #tests }
ManagerOfCardActiveInGameTest >> testTwoSameCardsAffectAPlayer [
	| setOfPlayers managerOfCardsActiveInGame aCard |
	setOfPlayers := {juan . pancho}.
	managerOfCardsActiveInGame := ManagerOfTheCardsActiveInGame createFor: setOfPlayers.
	aCard := Overload createCard.
	managerOfCardsActiveInGame addCard: aCard toPlayer: juan.
	managerOfCardsActiveInGame addCard: aCard toPlayer: juan.
	self assert: (managerOfCardsActiveInGame numberOfCardsAffectingPlayer: juan) equals: 2.
	self
		assert: (managerOfCardsActiveInGame numberOfCardsAffectingPlayer: pancho)
		equals: 0.
]
