Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#instVars : [
		'juan',
		'pancho',
		'aBoard',
		'numberOfRoundsToBePlayed',
		'dieOf4',
		'dieOf6',
		'dieOf8',
		'diceOf10',
		'diceOfJuan',
		'diceOfPancho'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #assertions }
GameTest >> assertCurrentNumberOfRoundsMadeBy: aPlayer in: aGame equals: numberOfRoundsMade [
	self
		assert: (aGame numberOfRoundsMadeBy: aPlayer)
		equals: numberOfRoundsMade.
]

{ #category : #assertions }
GameTest >> assertCurrentPositionOf: aPlayer in: aGame equals: finalPosition [
	self
		assert: (aGame positionOf: aPlayer)
		equals: finalPosition
]

{ #category : #assertions }
GameTest >> assertRankingOf: aPlayer in: aGame  equals: aRankPosition [
	self
		assert: (aGame rankingOf: aPlayer)
		equals: aRankPosition.
]

{ #category : #utilities }
GameTest >> play: aNumber turnsIn: game [
	1 to: aNumber do: [ :each | game playTurn ]
]

{ #category : #running }
GameTest >> setUp [
	super setUp.
	
	aBoard := 30.
	numberOfRoundsToBePlayed := 3.
	
	dieOf4 := Die of: 4 rolling: #(1 4 2).
	dieOf6 := Die of: 6 rolling: #(1 5 3).
	dieOf8 := Die of: 8 rolling: #(3 7 2).
	diceOf10 := Die of: 10 rolling: #(1 2 3).
	
	diceOfJuan := dieOf4 + dieOf6.
   diceOfPancho := dieOf8 + diceOf10.
	
	juan := Player playsWith: diceOfJuan.
	pancho := Player playsWith: diceOfPancho.
	
	"players := OrderedCollection with: juan with: pancho.
	game := Game playedBy: players on: aBoard until: numberOfRoundsToBePlayed."
]

{ #category : #tests }
GameTest >> testBoardOfPositionsChangesAfterEveryMovement [
	| game players |
	players := OrderedCollection with: juan with: pancho.
	game := Game playedBy: players on: aBoard until: numberOfRoundsToBePlayed.
	
	self assertCurrentPositionOf: juan in: game equals: 0.
	self assertCurrentPositionOf: pancho in: game equals: 0.
	
	game playTurn.
	self assertCurrentPositionOf: juan in: game equals: 2.
	self assertCurrentPositionOf: pancho in: game equals: 0.
	
	game playTurn.
	self assertCurrentPositionOf: juan in: game equals: 2.
	self assertCurrentPositionOf: pancho in: game equals: 4.
	
	
	game playTurn.
	self assertCurrentPositionOf: juan in: game equals: 11.
	self assertCurrentPositionOf: pancho in: game equals: 4.
]

{ #category : #tests }
GameTest >> testBoardOfRoundsMadeChangesAfterEveryMovement [
	| game players |
	players := OrderedCollection with: juan with: pancho.
	game := Game playedBy: players on: aBoard until: numberOfRoundsToBePlayed.
	
	self assertCurrentNumberOfRoundsMadeBy: juan in: game equals: 0.
	self assertCurrentNumberOfRoundsMadeBy: pancho in: game equals: 0.
	
	self play: 10 turnsIn: game.
	
	self assertCurrentNumberOfRoundsMadeBy: juan in: game equals: 0.
	self assertCurrentNumberOfRoundsMadeBy: pancho in: game equals: 1
]

{ #category : #tests }
GameTest >> testBoardOfWhoIsWinningChangesAfterEveryMovement [
	| thePlayers aGame dieOf5 dieOf7 diceOfPedrito pedrito dieOf9 diceOfRenzo renzo |
	
	dieOf5 := Die of: 5 rolling: #(5 4 4).
	dieOf7 := Die of: 7 rolling: #(6 5 3).
	diceOfPedrito := dieOf5 + dieOf7.
	pedrito := Player playsWith: diceOfPedrito.
	
	dieOf9 := Die of: 9 rolling: #(8 4 3).
	diceOfRenzo := dieOf9 + dieOf9.
	renzo := Player playsWith: diceOfRenzo.
	
	thePlayers := OrderedCollection with: juan with: pancho with: pedrito with: renzo.
	aGame := Game playedBy: thePlayers on: aBoard until: numberOfRoundsToBePlayed.
	
	aGame playTurn.
	self assertRankingOf: juan in: aGame equals: 1.
	
	aGame playTurn.
	self assertRankingOf: pancho in: aGame equals: 1.
	self assertRankingOf: juan in: aGame equals: 2.
	
	self play: 3 turnsIn: aGame.
	self assertRankingOf: renzo in: aGame equals: 1.
	self assertRankingOf: juan in: aGame equals: 2.
	self assertRankingOf: pedrito in: aGame equals: 3.
	self assertRankingOf: pancho in: aGame equals: 4.
]

{ #category : #tests }
GameTest >> testGameHasNoWinnerYet [
	| game players |
	players := OrderedCollection with: juan with: pancho.
	game := Game playedBy: players on: aBoard until: numberOfRoundsToBePlayed.
	
	self
		should: [ game winner ]
		raise: TheresNoWinnerYet
		withMessageText: 'No winner yet.'
]

{ #category : #tests }
GameTest >> testOnePlayerWinsAndTheOtherLoses [
	| game players |
	players := OrderedCollection with: juan with: pancho.
	game := Game playedBy: players on: aBoard until: numberOfRoundsToBePlayed.
	
	game play.
	self assertRankingOf: pancho in: game equals: 1.
	self assertRankingOf: juan in: game equals: 2
]
