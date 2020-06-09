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

{ #category : #running }
DeckHandlerTest >> setUp [
	super setUp.
	juan := 'Juan'.
	pancho := 'Pancho'.
	players := OrderedCollection with: juan with: pancho.
	setOfCards := { Acceleration. Cancellation. Overload. Redo. }.
]

{ #category : #tests }
DeckHandlerTest >> testAllPlayersStartsWithTwoRandomCards [
	| deckHandler cardHandler |
	cardHandler := CardHandler withTheFollowingTypeOfCards: setOfCards.
	deckHandler := DeckHandler ofPlayers: players from: cardHandler.
	self assert: deckHandler allDecksHaveTwoCards
]

{ #category : #tests }
DeckHandlerTest >> testDeckHandlerGivesACardToAPlayer [
	| deckHandler card cardHandler |
	cardHandler := CardHandler withTheFollowingTypeOfCards: setOfCards.
	"cardHandler := CardHandler withTheValidCards: setOfCards andGenerator: (SequentialNaturalNumberProvider providing: #(1 2 3 4 5 6))."
	deckHandler := DeckHandler ofPlayers: players from: cardHandler.
	card := cardHandler giveCard.
	deckHandler give: card to: juan.
	self assert: (deckHandler amountOfCardsOf: juan) equals: 3.
	self assert: (deckHandler amountOfCardsOf: pancho) equals: 2.
]
