Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
GameTest >> testGameSelectPlayersToMove [
	| game |
	game := Game setUpGameValuesExample1.
	game playShift.
	self assert: game players current position equals: 2.
	game chooseNextShift.
	game playShift.
	self assert: game players current position equals: 4
]

{ #category : #tests }
GameTest >> testOnePlayerWinsAndTheOtherLoses [

	| game |
	game := Game setUpGameValuesExample1.
	game playShift.
	[game hasAWinner] whileFalse:[
		game chooseNextShift.
		game playShift.
		].
	self assert: ((game players) current) winner equals: true.
	self assert: ((game players) current) position equals: 30.
	self assert: game whoIsTheWinner equals: (game players) current.
	game chooseNextShift.
	self assert: ((game players) current) winner equals: false.
	self assert: ((game players) current) position equals: 27.
]

{ #category : #tests }
GameTest >> testStartGame [

	| game board players die1 die2 dice1 player1 die3 die4 dice2 player2 |
	board := Board withSlots: 30.
	die1 := Die of: 4 rolling: #(1 4 2).
	die2 := Die of: 6 rolling: #(1 5 3).
	dice1 := die1 + die2.
	player1:= Player creation: dice1.
	die3 := Die of: 8 rolling: #(3 7 2).
	die4 := Die of: 4 rolling: #(1 2 3).
	dice2 := die3 + die4.
	player2:= Player creation: dice2.
	player1 boardSlots: (board slots).
	player2 boardSlots: (board slots).
	players:= CircularIterator cyclingOver: (OrderedCollection with: player1 with: player2).
	game := Game withBoardAndPlayers: (OrderedCollection with: board with: players).
	self assert: (game board) equals: board.
	self assert: (game players) equals: players.
]
