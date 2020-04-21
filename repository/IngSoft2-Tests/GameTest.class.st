Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
GameTest class >> setUpGameValuesExample1 [
	| game aBoard dieOf4 dieOf6 diceOfJuan juan dieOf8 diceOf12 diceOfPancho pancho players |
	aBoard := Board withSlots: 30.
	dieOf4 := Die of: 4 rolling: #(1 4 2).
	dieOf6 := Die of: 6 rolling: #(1 5 3).
	diceOfJuan := dieOf4 + dieOf6.
	juan:= Player playsWith: diceOfJuan on: aBoard.
	dieOf8 := Die of: 8 rolling: #(3 7 2).
	diceOf12 := Die of: 12 rolling: #(1 2 3).
	diceOfPancho := dieOf8 + diceOf12.
	pancho:= Player playsWith: diceOfPancho on: aBoard.
	players:= CircularIterator cyclingOver: (OrderedCollection with: juan with: pancho).
	game := Game playedBy: players on: aBoard.
	^ game.
]

{ #category : #tests }
GameTest >> testGameSelectPlayersToMove [
	| game |
	game := GameTest setUpGameValuesExample1.
	game playTurn.
	self assert: game currentPlayerPosition equals: 2.
	game chooseNextPlayer.
	game playTurn.
	self assert: game currentPlayerPosition equals: 4
]

{ #category : #tests }
GameTest >> testOnePlayerWinsAndTheOtherLoses [

	| game |
	game := GameTest setUpGameValuesExample1.
	"game playTurn.
	[game hasWinner] whileFalse:[
		game chooseNextTurn.
		game playTurn.
		]."
	game play.
	self assert: game currentPlayerIsWinner.
	self assert: game currentPlayerPosition equals: 30.
	self assert: game winner equals: game currentPlayer.
	game chooseNextPlayer.
	self assert: game currentPlayerIsWinner equals: false.
	self assert: game currentPlayerPosition equals: 27.
]

{ #category : #tests }
GameTest >> testStartGame [

	| game aBoard players dieOf4 dieOf6 diceOfJuan juan dieOf8 diceOf12 diceOfPancho pancho |
	aBoard := Board withSlots: 30.
	dieOf4 := Die of: 4 rolling: #(1 4 2).
	dieOf6 := Die of: 6 rolling: #(1 5 3).
	diceOfJuan := dieOf4 + dieOf6.
	juan:= Player playsWith: diceOfJuan on: aBoard.
	dieOf8 := Die of: 8 rolling: #(3 7 2).
	diceOf12 := Die of: 12 rolling: #(1 2 3).
	diceOfPancho := dieOf8 + diceOf12.
	pancho:= Player playsWith: diceOfPancho on: aBoard.
	players:= CircularIterator cyclingOver: (OrderedCollection with: juan with: pancho).
	game := Game playedBy: players on: aBoard.
	self assert: (game board) equals: aBoard.
	self assert: (game players) equals: players.
	self should: [game winner] raise: TheresNoWinnerYet withMessageText: 'No winner yet.'.
]
