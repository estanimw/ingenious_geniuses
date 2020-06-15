Class {
	#name : #DeckHandlerTest,
	#superclass : #TestCase,
	#instVars : [
		'juan',
		'pancho',
		'players',
		'setOfCards'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #calculating }
DeckHandlerTest >> calculateAmountOf: anEffect [ 
	| amount |
	amount := 0.
	setOfCards
		do: [ :effect | 
			(effect isMemberOf: anEffect)
				ifTrue: [ amount := amount + 1 ] ].
	^ amount
]

{ #category : #tests }
DeckHandlerTest >> completeASetOfCardsWithThe: deckHandler [
	setOfCards := OrderedCollection new.
	60 timesRepeat: [ setOfCards add: deckHandler giveCard ]
]

{ #category : #running }
DeckHandlerTest >> setUp [
	super setUp.
	juan := 'Juan'.
	pancho := 'Pancho'.
	players := OrderedCollection with: juan with: pancho.
	setOfCards := { Acceleration. Cancellation. Overload. Redo. Repeat. Speed }.
]

{ #category : #tests }
DeckHandlerTest >> testAllPlayersStartsWithTwoRandomCards [
	| deckHandler |
	deckHandler := DeckHandler ofPlayers: players withTheFollowingTypeOfCards: setOfCards.
	self assert: deckHandler allDecksHaveTwoCards
]

{ #category : #tests }
DeckHandlerTest >> testDeckHandlerCantRemoveACardThatIsntAtThePlayersDeck [
	| deckHandler aCard |
	deckHandler := DeckHandler ofPlayers: players withTheFollowingTypeOfCards: setOfCards andGenerator: (SequentialNaturalNumberProvider providing: #(1 2 3 4 5 6)).
	self assert: (deckHandler amountOfCardsOf: juan) equals: 2.
	aCard := Acceleration create.
	deckHandler pop: aCard fromDeckOf: juan.
	self assert: (deckHandler amountOfCardsOf: juan) equals: 1.
	aCard := Speed create.
	self should: [ deckHandler pop: aCard fromDeckOf: juan. ] raise: Error withMessageText: 'The player doesn`t have that card in his deck'.
	aCard := Cancellation create.
	deckHandler pop: aCard fromDeckOf: juan.
	self assert: (deckHandler amountOfCardsOf: juan) equals: 0.
	aCard := Cancellation create.
	self should: [ deckHandler pop: aCard fromDeckOf: juan. ] raise: Error withMessageText: 'The player doesn`t have that card in his deck'.
]

{ #category : #tests }
DeckHandlerTest >> testDeckHandlerGivesACardToAPlayer [
	| deckHandler card |
	deckHandler := DeckHandler
		ofPlayers: players
		withTheFollowingTypeOfCards: setOfCards.
	card := deckHandler giveCard.
	deckHandler give: card to: juan.
	self assert: (deckHandler amountOfCardsOf: juan) equals: 3.
	self assert: (deckHandler amountOfCardsOf: pancho) equals: 2
]

{ #category : #tests }
DeckHandlerTest >> testDeckHandlerGivesCardsWithAUniformDistribution [
	| deckHandler amountOfAcceleration amountOfOverload amountOfRedo amountOfSpeed amountOfCancellation amountOfRepeat |
	deckHandler := DeckHandler ofPlayers: players withTheFollowingTypeOfCards: setOfCards.
	amountOfAcceleration := OrderedCollection new.
	amountOfOverload := OrderedCollection new.
	amountOfRedo := OrderedCollection new.
	amountOfSpeed := OrderedCollection new.
	amountOfCancellation := OrderedCollection new.
	amountOfRepeat := OrderedCollection new.
	
	1000
		timesRepeat: [ 
			self completeASetOfCardsWithThe: deckHandler.
			amountOfAcceleration add: (self calculateAmountOf: Acceleration).
			amountOfOverload add: (self calculateAmountOf: Overload).
			amountOfRedo add: (self calculateAmountOf: Redo).
			amountOfSpeed add: (self calculateAmountOf: Speed).
			amountOfCancellation add: (self calculateAmountOf: Cancellation).
			amountOfRepeat add: (self calculateAmountOf: Repeat) 
		].
		
	self assert: amountOfAcceleration average rounded equals: 10.
	self assert: amountOfOverload average rounded equals: 10.
	self assert: amountOfRedo average rounded equals: 10.
	self assert: amountOfSpeed average rounded equals: 10.
	self assert: amountOfCancellation average rounded equals: 10.
	self assert: amountOfRepeat average rounded equals: 10
]

{ #category : #tests }
DeckHandlerTest >> testDeckHandlerGivesCardsWithAnOrder [
	| deckHandler |
	deckHandler := DeckHandler
		ofPlayers: players
		withTheFollowingTypeOfCards: setOfCards
		andGenerator: (SequentialNaturalNumberProvider providing: #(1 2 3 4 5 6)).
	self
		assert: ((deckHandler deckOf: juan) setOfCards at: 1)
		equals: Acceleration create
]

{ #category : #tests }
DeckHandlerTest >> testDeckHandlerHasAllTypesOfCardsAtInitialization [
	| deckHandler |
	deckHandler := DeckHandler ofPlayers: players withTheFollowingTypeOfCards: setOfCards.
	self assert: deckHandler typesOfCards isNotEmpty.
]

{ #category : #tests }
DeckHandlerTest >> testDeckHandlerRemovesACardFromAPlayersDeck [
	| deckHandler aCard |
	deckHandler := DeckHandler ofPlayers: players withTheFollowingTypeOfCards: setOfCards andGenerator: (SequentialNaturalNumberProvider providing: #(1 2 3 4 5 6)).
	self assert: (deckHandler amountOfCardsOf: juan) equals: 2.
	aCard := Acceleration create.
	deckHandler pop: aCard fromDeckOf: juan.
	self assert: (deckHandler amountOfCardsOf: juan) equals: 1.
	aCard := Cancellation create.
	deckHandler pop: aCard fromDeckOf: juan.
	self assert: (deckHandler amountOfCardsOf: juan) equals: 0.
]
