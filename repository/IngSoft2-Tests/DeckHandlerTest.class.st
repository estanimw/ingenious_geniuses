Class {
	#name : #DeckHandlerTest,
	#superclass : #TestCase,
	#instVars : [
		'juan',
		'pancho',
		'players',
		'setOfCards',
		'mainDeck',
		'builder'
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
	100 timesRepeat: [ setOfCards add: deckHandler pickCardFromGameDeck ]
]

{ #category : #running }
DeckHandlerTest >> setUp [
	super setUp.
	juan := 'Juan'.
	pancho := 'Pancho'.
	players := OrderedCollection with: juan with: pancho.
	
	builder := MainDeckBuilder generateWithSizeOf: 6.
	builder addEffect: Acceleration withOccurrencyOf: 20.
	builder addEffect: Overload withOccurrencyOf: 10.
	builder addEffect: Speed withOccurrencyOf: 30.
	builder addEffect: Redo withOccurrencyOf: 20.
	builder addEffect: Repeat withOccurrencyOf: 10.
	builder addEffect: Cancellation withOccurrencyOf: 10.
	
	mainDeck := builder build.
	"setOfCards := { Acceleration. Cancellation. Overload. Redo. Repeat. Speed }."
]

{ #category : #tests }
DeckHandlerTest >> testAllPlayersStartsWithTwoRandomCards [
	| deckHandler |
	deckHandler := DeckHandler ofPlayers: players withMainDeck: mainDeck.
	self assert: deckHandler allDecksOfPlayersHaveTwoCards
]

{ #category : #tests }
DeckHandlerTest >> testDeckHandlerCantRemoveACardThatIsntAtThePlayersDeck [
	| deckHandler listOfCards |
	listOfCards := OrderedCollection new.
	listOfCards add: Acceleration createCard.
	listOfCards add: Overload createCard.
	listOfCards add: Cancellation createCard.
	listOfCards add: Speed createCard.
	
	mainDeck := MainDeck generateWithCardDistribution: listOfCards.
	deckHandler := DeckHandler ofPlayers: players withMainDeck: mainDeck.
	
	self assert: (deckHandler amountOfCardsOf: juan) equals: 2.
	deckHandler pop: Acceleration fromDeckOf: juan.
	self assert: (deckHandler amountOfCardsOf: juan) equals: 1.
	self
		should: [ deckHandler pop: Speed fromDeckOf: juan ]
		raise: Error
		withMessageText: 'The player doesn`t have that card in his deck'.
	deckHandler pop: Cancellation fromDeckOf: pancho.
	self assert: (deckHandler amountOfCardsOf: pancho) equals: 1.
	self
		should: [ deckHandler pop: Cancellation fromDeckOf: pancho ]
		raise: Error
		withMessageText: 'The player doesn`t have that card in his deck'
]

{ #category : #tests }
DeckHandlerTest >> testDeckHandlerGivesACardToAPlayer [
	| deckHandler card |
	deckHandler := DeckHandler
		ofPlayers: players
		withMainDeck: mainDeck.
	card := deckHandler pickCardFromGameDeck.
	deckHandler giveCard: card toPlayer: juan.
	self assert: (deckHandler amountOfCardsOf: juan) equals: 3.
	self assert: (deckHandler amountOfCardsOf: pancho) equals: 2
]

{ #category : #tests }
DeckHandlerTest >> testDeckHandlerGivesCardsWithAnSpecificOrder [
	| deckHandler listOfCards |
	listOfCards := OrderedCollection new. listOfCards add: Acceleration createCard. listOfCards add: Overload createCard. listOfCards add: Redo createCard. listOfCards add: Acceleration createCard.
	mainDeck := MainDeck generateWithCardDistribution: listOfCards.
	deckHandler := DeckHandler
		ofPlayers: players
		withMainDeck: mainDeck.
	self
		assert: ((deckHandler deckOf: juan) setOfCards at: 1)
		equals: Acceleration createCard.
	self
		assert: ((deckHandler deckOf: juan) setOfCards at: 2)
		equals: Overload createCard.
	self
		assert: ((deckHandler deckOf: pancho) setOfCards at: 1)
		equals: Redo createCard.
	self
		assert: ((deckHandler deckOf: pancho) setOfCards at: 2)
		equals: Acceleration createCard
]

{ #category : #tests }
DeckHandlerTest >> testDeckHandlerGivesCardsWithTheGivenDistribution [
	| deckHandler amountOfAcceleration amountOfOverload amountOfRedo amountOfSpeed amountOfCancellation amountOfRepeat mainDeck2 |
	amountOfAcceleration := OrderedCollection new.
	amountOfOverload := OrderedCollection new.
	amountOfRedo := OrderedCollection new.
	amountOfSpeed := OrderedCollection new.
	amountOfCancellation := OrderedCollection new.
	amountOfRepeat := OrderedCollection new.
	
	1000
		timesRepeat: [ 
			builder := MainDeckBuilder generateWithSizeOf: 1000.
			builder addEffect: Acceleration withOccurrencyOf: 20.
			builder addEffect: Overload withOccurrencyOf: 10.
			builder addEffect: Speed withOccurrencyOf: 30.
			builder addEffect: Redo withOccurrencyOf: 20.
			builder addEffect: Repeat withOccurrencyOf: 10.
			builder addEffect: Cancellation withOccurrencyOf: 10.
			
			mainDeck2 := builder build.	
			deckHandler := DeckHandler ofPlayers: players withMainDeck: mainDeck2.
			self completeASetOfCardsWithThe: deckHandler.
			amountOfAcceleration add: (self calculateAmountOf: Acceleration).
			amountOfOverload add: (self calculateAmountOf: Overload).
			amountOfRedo add: (self calculateAmountOf: Redo).
			amountOfSpeed add: (self calculateAmountOf: Speed).
			amountOfCancellation add: (self calculateAmountOf: Cancellation).
			amountOfRepeat add: (self calculateAmountOf: Repeat) 
		].
		
	self assert: amountOfAcceleration average rounded equals: 20.
	self assert: amountOfOverload average rounded equals: 10.
	self assert: amountOfSpeed average rounded equals: 30.
	self assert: amountOfRedo average rounded equals: 20.
	self assert: amountOfCancellation average rounded equals: 10.
	self assert: amountOfRepeat average rounded equals: 10
]

{ #category : #tests }
DeckHandlerTest >> testDeckHandlerHasVariousTypesOfCardsAtInitialization [
	| deckHandler |
	deckHandler := DeckHandler ofPlayers: players withMainDeck: mainDeck.
	self assert: deckHandler amountOfCardsOnMainDeck > 1 equals: true.
]

{ #category : #tests }
DeckHandlerTest >> testDeckHandlerRemovesACardFromAPlayersDeck [
	| deckHandler listOfCards |
	listOfCards := OrderedCollection new.
	listOfCards add: Acceleration createCard.
	listOfCards add: Overload createCard.
	listOfCards add: Cancellation createCard.
	listOfCards add: Speed createCard.
	mainDeck := MainDeck generateWithCardDistribution: listOfCards.
	deckHandler := DeckHandler ofPlayers: players withMainDeck: mainDeck.
	
	self assert: (deckHandler amountOfCardsOf: juan) equals: 2.
	deckHandler pop: Acceleration fromDeckOf: juan.
	self assert: (deckHandler amountOfCardsOf: juan) equals: 1.
	self assert: (deckHandler amountOfCardsOf: pancho) equals: 2.
	deckHandler pop: Speed fromDeckOf: pancho.
	self assert: (deckHandler amountOfCardsOf: juan) equals: 1.
]
