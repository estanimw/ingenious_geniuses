Class {
	#name : #ManagerOfEffectsOfTheCardsInGameTest,
	#superclass : #TestCase,
	#instVars : [
		'juan',
		'pancho'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #running }
ManagerOfEffectsOfTheCardsInGameTest >> setUp [
	juan := 'juan'.
	pancho := 'pancho'.

]

{ #category : #tests }
ManagerOfEffectsOfTheCardsInGameTest >> testAllManagersOfCardsOverAPlayerInitializeEmpty [
	| setOfPlayers managerOfEffects |
	setOfPlayers := { juan . pancho }.
	managerOfEffects := ManagerOfTheCardsActiveInGame createFor: setOfPlayers.
	self assert: (managerOfEffects totalEffectOver: juan) equals: 0.
	self assert: (managerOfEffects totalEffectOver: pancho) equals: 0.
]

{ #category : #tests }
ManagerOfEffectsOfTheCardsInGameTest >> testCantRemoveACardThatIsNotActiveOverAPlayer [
	| setOfPlayers managerOfEffects aCard |
	setOfPlayers := {juan . pancho}.
	managerOfEffects := ManagerOfTheCardsActiveInGame createFor: setOfPlayers.
	self assert: (managerOfEffects cardsAffectingPlayer: juan) equals: 0.
	aCard := Overload createCard.
	managerOfEffects addCard: aCard toPlayer: juan.
	managerOfEffects addCard: aCard toPlayer: juan.
	self assert: (managerOfEffects cardsAffectingPlayer: juan) equals: 2.
	aCard := Speed createCard.
	self should: [managerOfEffects removeCard: aCard fromPlayer: juan] raise: Error withMessageText: 'There isn`t that card affecting this player'.
]

{ #category : #tests }
ManagerOfEffectsOfTheCardsInGameTest >> testDifferentCardsAffectAPlayer [
	| setOfPlayers managerOfEffects aCard |
	setOfPlayers := { juan . pancho }.
	managerOfEffects := ManagerOfTheCardsActiveInGame createFor: setOfPlayers.
	aCard := Overload createCard.
	managerOfEffects addCard: aCard toPlayer: juan.
	aCard := Speed createCard.
	managerOfEffects addCard: aCard toPlayer: juan.
	aCard := Speed createCard.
	managerOfEffects addCard: aCard toPlayer: juan.
	aCard := Acceleration createCard.
	managerOfEffects addCardToAllPlayers: aCard.
	self assert: (managerOfEffects cardsAffectingPlayer: juan) equals: 4.
	self
		assert: (managerOfEffects cardsAffectingPlayer: pancho)
		equals: 1.
]

{ #category : #tests }
ManagerOfEffectsOfTheCardsInGameTest >> testManagerOfEffectsOfTheCardsInGameRemovesAnActiveCardFromAPlayer [
	| setOfPlayers managerOfEffects aCard |
	setOfPlayers := {juan . pancho}.
	managerOfEffects := ManagerOfTheCardsActiveInGame createFor: setOfPlayers.
	self assert: (managerOfEffects cardsAffectingPlayer: juan) equals: 0.
	aCard := Overload createCard.
	managerOfEffects addCard: aCard toPlayer: juan.
	managerOfEffects addCard: aCard toPlayer: juan.
	self assert: (managerOfEffects cardsAffectingPlayer: juan) equals: 2.
	managerOfEffects removeCard: Overload fromPlayer: juan.
	self assert: (managerOfEffects cardsAffectingPlayer: juan) equals: 1.
]

{ #category : #tests }
ManagerOfEffectsOfTheCardsInGameTest >> testSomeCardsAffectEachPlayer [
	| setOfPlayers managerOfEffects aCard |
	setOfPlayers := {juan.
	pancho}.
	managerOfEffects := ManagerOfTheCardsActiveInGame
		createFor: setOfPlayers.
	aCard := Overload createCard.
	managerOfEffects addCard: aCard toPlayer: juan.
	aCard := Speed createCard.
	managerOfEffects addCard: aCard toPlayer: juan.
	aCard := Speed createCard.
	managerOfEffects addCard: aCard toPlayer: pancho.
	aCard := Acceleration createCard.
	managerOfEffects addCardToAllPlayers: aCard.
	self assert: (managerOfEffects cardsAffectingPlayer: juan) equals: 3.
	self
		assert: (managerOfEffects cardsAffectingPlayer: pancho)
		equals: 2.
]

{ #category : #tests }
ManagerOfEffectsOfTheCardsInGameTest >> testThereIsALeastOneCardActiveInGame [
	| setOfPlayers managerOfEffects aCard |
	setOfPlayers := { juan . pancho }.
	managerOfEffects := ManagerOfTheCardsActiveInGame createFor: setOfPlayers.
	self assert: managerOfEffects thereIsAtLeastOneCardActiveInGame equals: false.
	aCard := Overload createCard.
	managerOfEffects addCard: aCard toPlayer: juan.
	self assert: managerOfEffects thereIsAtLeastOneCardActiveInGame equals: true.
	aCard := Acceleration createCard.
	managerOfEffects addCardToAllPlayers: aCard.
	self assert: managerOfEffects thereIsAtLeastOneCardActiveInGame equals: true.
]

{ #category : #tests }
ManagerOfEffectsOfTheCardsInGameTest >> testTotalEffectOverAPlayerCanBeNegativePositivoOrCero [
	| setOfPlayers managerOfEffects aCard |
	setOfPlayers := {juan.pancho}.
	managerOfEffects := ManagerOfTheCardsActiveInGame createFor: setOfPlayers.
	self assert: (managerOfEffects totalEffectOver: juan) equals: 0.
	self assert: (managerOfEffects totalEffectOver: pancho) equals: 0.
	aCard := Speed createCard.
	managerOfEffects addCard: aCard toPlayer: juan.
	self assert: (managerOfEffects totalEffectOver: juan) equals: 1.
	self assert: (managerOfEffects totalEffectOver: pancho) equals: 0.
	managerOfEffects addCard: aCard toPlayer: juan.
	aCard := Acceleration createCard.
	managerOfEffects addCardToAllPlayers: aCard.
	aCard := Overload createCard.
	managerOfEffects addCard: aCard toPlayer: pancho.
	managerOfEffects addCard: aCard toPlayer: pancho.
	self assert: (managerOfEffects totalEffectOver: juan) equals: 3.
	self assert: (managerOfEffects totalEffectOver: pancho) equals: -3.
	managerOfEffects addCard: aCard toPlayer: juan.
	self assert: (managerOfEffects totalEffectOver: juan) equals: 1.
	self assert: (managerOfEffects totalEffectOver: pancho) equals: -3
]

{ #category : #tests }
ManagerOfEffectsOfTheCardsInGameTest >> testTotalEffectOverAPlayerIsTheSumOfEveryEffect [
	| setOfPlayers managerOfEffects aCard |
	setOfPlayers := { juan . pancho }.
	managerOfEffects := ManagerOfTheCardsActiveInGame createFor: setOfPlayers.
	self assert: (managerOfEffects totalEffectOver: juan) equals: 0.
	aCard := Speed createCard.
	managerOfEffects addCard: aCard toPlayer: juan.
	self assert: (managerOfEffects totalEffectOver: juan) equals: 1.
	aCard := Speed createCard.
	managerOfEffects addCard: aCard toPlayer: juan.
	aCard := Acceleration createCard.
	managerOfEffects addCardToAllPlayers: aCard.
	self assert: (managerOfEffects totalEffectOver: juan) equals: 3.
	aCard := Overload createCard.
	managerOfEffects addCard: aCard toPlayer: juan.
	self assert: (managerOfEffects totalEffectOver: juan) equals: 1.
	
]

{ #category : #tests }
ManagerOfEffectsOfTheCardsInGameTest >> testTotalEffectOverDifferentPlayers [
	| setOfPlayers managerOfEffects aCard |
	setOfPlayers := { juan . pancho }.
	managerOfEffects := ManagerOfTheCardsActiveInGame createFor: setOfPlayers.
	self assert: (managerOfEffects totalEffectOver: juan) equals: 0.
	self assert: (managerOfEffects totalEffectOver: pancho) equals: 0.
	aCard := Speed createCard.
	managerOfEffects addCard: aCard toPlayer: juan.
	self assert: (managerOfEffects totalEffectOver: juan) equals: 1.
	self assert: (managerOfEffects totalEffectOver: pancho) equals: 0.
	aCard := Overload createCard.
	managerOfEffects addCard: aCard toPlayer: juan.
	aCard := Acceleration createCard.
	managerOfEffects addCardToAllPlayers: aCard.
	self assert: (managerOfEffects totalEffectOver: juan) equals: 0.
	self assert: (managerOfEffects totalEffectOver: pancho) equals: 1.
	
]

{ #category : #tests }
ManagerOfEffectsOfTheCardsInGameTest >> testTwoSameCardsAffectAPlayer [
	| setOfPlayers managerOfEffects aCard |
	setOfPlayers := {juan . pancho}.
	managerOfEffects := ManagerOfTheCardsActiveInGame createFor: setOfPlayers.
	aCard := Overload createCard.
	managerOfEffects addCard: aCard toPlayer: juan.
	managerOfEffects addCard: aCard toPlayer: juan.
	self assert: (managerOfEffects cardsAffectingPlayer: juan) equals: 2.
	self
		assert: (managerOfEffects cardsAffectingPlayer: pancho)
		equals: 0.
]
