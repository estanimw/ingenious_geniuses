Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
GameTest class >> setUpGameValuesExample1 [
	| game aBoard dieOf4 dieOf6 diceOfJuan juan dieOf8 diceOf10 diceOfPancho pancho players xRounds |
	aBoard := 30.
	xRounds := 3.
	dieOf4 := Die of: 4 rolling: #(1 4 2).
	dieOf6 := Die of: 6 rolling: #(1 5 3).
	diceOfJuan := dieOf4 + dieOf6.
	juan := Player playsWith: diceOfJuan.
	dieOf8 := Die of: 8 rolling: #(3 7 2).
	diceOf10 := Die of: 10 rolling: #(1 2 3).
	diceOfPancho := dieOf8 + diceOf10.
	pancho := Player playsWith: diceOfPancho.
	players := CircularIterator
		cyclingOver: (OrderedCollection with: juan with: pancho).
	game := Game playedBy: players on: aBoard until: xRounds.
	^ game
]

{ #category : #tests }
GameTest class >> setUpGameValuesExample2 [
	| dieOf8 dieOf6 dieOf4 juan pancho aBoard diceOfJuan diceOf10 diceOfPancho |
	aBoard := 30.
	dieOf4 := Die of: 4 rolling: #(1 4 2).
	dieOf6 := Die of: 6 rolling: #(1 5 3).
	diceOfJuan := dieOf4 + dieOf6.
	juan := Player playsWith: diceOfJuan.
	dieOf8 := Die of: 8 rolling: #(3 7 2).
	diceOf10 := Die of: 10 rolling: #(1 2 3).
	diceOfPancho := dieOf8 + diceOf10.
	pancho := Player playsWith: diceOfPancho.
	^ OrderedCollection with: aBoard with: juan with: pancho.
]

{ #category : #tests }
GameTest class >> setUpGameValuesExample3 [
	| game aBoard dieOf4 dieOf6 diceOfJuan juan dieOf8 diceOf10 diceOfPancho pancho players xRounds |
	aBoard := 30.
	xRounds := 3.
	dieOf4 := Die of: 4 rolling: #(4 4 4).
	dieOf6 := Die of: 6 rolling: #(6 6 5).
	diceOfJuan := dieOf4 + dieOf6.
	juan := Player playsWith: diceOfJuan.
	dieOf8 := Die of: 8 rolling: #(8 8 8).
	diceOf10 := Die of: 10 rolling: #(10 10 10).
	diceOfPancho := dieOf8 + diceOf10.
	pancho := Player playsWith: diceOfPancho.
	players := CircularIterator
		cyclingOver: (OrderedCollection with: juan with: pancho).
	game := Game playedBy: players on: aBoard until: xRounds.
	^ game
]

{ #category : #tests }
GameTest class >> setUpGameValuesExample4 [
	| game aBoard dieOf4 dieOf6 diceOfJuan juan dieOf8 diceOf10 diceOfPancho pancho players xRounds dieOf5 dieOf7 diceOfPedrito pedrito dieOf9 diceOfRenzo renzo |
	aBoard := 30.
	xRounds := 3.
	dieOf4 := Die of: 4 rolling: #(1 4 2).
	dieOf6 := Die of: 6 rolling: #(1 5 3).
	diceOfJuan := dieOf4 + dieOf6.
	juan := Player playsWith: diceOfJuan.
	
	dieOf8 := Die of: 8 rolling: #(3 7 2).
	diceOf10 := Die of: 10 rolling: #(1 2 3).
	diceOfPancho := dieOf8 + diceOf10.
	pancho := Player playsWith: diceOfPancho.
	
	dieOf5 := Die of: 5 rolling: #(5 4 4).
	dieOf7 := Die of: 7 rolling: #(6 5 3).
	diceOfPedrito := dieOf5 + dieOf7.
	pedrito := Player playsWith: diceOfPedrito.
	
	dieOf9 := Die of: 9 rolling: #(8 4 3).
	diceOfRenzo := dieOf9 + dieOf9.
	renzo := Player playsWith: diceOfRenzo.
	
	
	players := CircularIterator
		cyclingOver: (OrderedCollection with: juan with: pancho with: pedrito with: renzo).
	game := Game playedBy: players on: aBoard until: xRounds.
	^ game
]

{ #category : #tests }
GameTest >> testBoardOfPositionsChangesAfterEveryMovement [
	| game player1 player2 |
	game := GameTest setUpGameValuesExample1.
	player1 := game currentPlayer.
	self assert: (game boardOfPositions at: player1) equals: 0.
	game chooseNextPlayer.
	player2 := game currentPlayer.
	self assert: (game boardOfPositions at: player2) equals: 0.
	game chooseNextPlayer.
	game playTurn.
	self assert: (game boardOfPositions at: player1) equals: 2.
	game chooseNextPlayer.
	self assert: (game boardOfPositions at: player2) equals: 0.
	game playTurn.
	self assert: (game boardOfPositions at: player2) equals: 4.
	game chooseNextPlayer.
	self assert: (game boardOfPositions at: player1) equals: 2.
]

{ #category : #tests }
GameTest >> testBoardOfRoundsMadeChangesAfterEveryMovement [
	| game player1 player2 |
	game := GameTest setUpGameValuesExample3.
	player1 := game currentPlayer.
	self assert: (game boardOfRoundsMade at: player1) equals: 0.
	game chooseNextPlayer.
	player2 := game currentPlayer.
	self assert: (game boardOfRoundsMade at: player2) equals: 0.
	game chooseNextPlayer.
	game playTurn.
	self assert: (game boardOfRoundsMade at: player1) equals: 0.
	game chooseNextPlayer.
	self assert: (game boardOfRoundsMade at: player2) equals: 0.
	game playTurn.
	self assert: (game boardOfRoundsMade at: player2) equals: 0.
	game chooseNextPlayer.
	game playTurn.
	self assert: (game boardOfRoundsMade at: player1) equals: 0.
	game chooseNextPlayer.
	game playTurn.
	self assert: (game boardOfRoundsMade at: player2) equals: 1.
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
	self shouldnt: [game := GameTest setUpGameValuesExample1] raise: Error.
	game play.
	self assert: game currentPlayerIsWinner.
	self assert: game currentPlayerNumberOfRoundsMade equals: 3.
	game chooseNextPlayer.
	self assert: game currentPlayerIsWinner equals: false.
	self assert: (game currentPlayerNumberOfRoundsMade) ~= 3.
]

{ #category : #tests }
GameTest >> testStartGame [
	| game aBoard players aux xRounds |
	aux := GameTest setUpGameValuesExample2.
	aBoard := aux removeFirst.
	xRounds := 3.
	players := CircularIterator cyclingOver: aux.
	game := Game playedBy: players on: aBoard until: xRounds.
	self assert: game players equals: players.
	self
		should: [ game winner ]
		raise: TheresNoWinnerYet
		withMessageText: 'No winner yet.'
]

{ #category : #tests }
GameTest >> testTablaGanadores [
	| game |
	game := GameTest setUpGameValuesExample4.
	game play.
	self assert: game currentPlayerIsWinner.
	self assert: game currentPlayerNumberOfRoundsMade equals: 3.
	self assert: (game fillBoardOfWhoIsWinning at: (game currentPlayer)) equals: 1. "chequeo que quede primero :)"
	game chooseNextPlayer.
	self assert: game currentPlayerIsWinner equals: false.
	self assert: (game currentPlayerNumberOfRoundsMade ~= 3).
	self assert: (game fillBoardOfWhoIsWinning at: (game currentPlayer)) ~= 1.
]
