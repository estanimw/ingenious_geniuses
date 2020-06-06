Class {
	#name : #DeckHandlerTest,
	#superclass : #TestCase,
	#instVars : [
		'board',
		'juan',
		'pancho',
		'players',
		'leaderBoard'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #running }
DeckHandlerTest >> setUp [
	super setUp.
	board := Board of: { NoEffect new . NoEffect new . NoEffect new . NoEffect new . NoEffect new . NoEffect new}.
	juan := 'Juan'.
	pancho := 'Pancho'.
	players := OrderedCollection with: juan with: pancho.
	leaderBoard := LeaderBoard with: players.
]

{ #category : #tests }
DeckHandlerTest >> testCargaUnaCarta [
	| handler card |
	handler := DeckHandler ofPlayers: players from: cardHandler.
	card := Card new.
	handler give: card to: juan.
	self assert: (handler deckOf: juan) setOfCards isNotEmpty.
	self assert: (handler deckOf: pancho) setOfCards isEmpty
]

{ #category : #tests }
DeckHandlerTest >> testInicializanVacios [
	| handler |
	handler := DeckHandler ofPlayers: players from: cardHandler.
	self assert: handler allDecksAreEmpty
]
