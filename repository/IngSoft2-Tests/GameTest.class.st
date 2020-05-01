Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
GameTest class >> setUpGameValuesExample1 [
	| game aBoard dieOf4 dieOf6 diceOfJuan juan dieOf8 diceOf12 diceOfPancho pancho players |
	aBoard := 30.
	dieOf4 := Die of: 4 rolling: #(1 4 2).
	dieOf6 := Die of: 6 rolling: #(1 5 3).
	diceOfJuan := dieOf4 + dieOf6.
	juan:= Player playsWith: diceOfJuan.
	dieOf8 := Die of: 8 rolling: #(3 7 2).
	diceOf12 := Die of: 12 rolling: #(1 2 3).
	diceOfPancho := dieOf8 + diceOf12.
	pancho:= Player playsWith: diceOfPancho.
	players:= CircularIterator cyclingOver: (OrderedCollection with: juan with: pancho).
	game := Game playedBy: players on: aBoard.
	^ game.
]

{ #category : #tests }
GameTest class >> setUpGameValuesExample2 [
	| dieOf8 dieOf6 dieOf4 juan pancho aBoard diceOfJuan diceOf12 diceOfPancho |
	aBoard := 30.
	dieOf4 := Die of: 4 rolling: #(1 4 2).
	dieOf6 := Die of: 6 rolling: #(1 5 3).
	diceOfJuan := dieOf4 + dieOf6.
	juan := Player playsWith: diceOfJuan.
	dieOf8 := Die of: 8 rolling: #(3 7 2).
	diceOf12 := Die of: 12 rolling: #(1 2 3).
	diceOfPancho := dieOf8 + diceOf12.
	pancho := Player playsWith: diceOfPancho.
	^ OrderedCollection with: aBoard with: juan with: pancho.
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
	self assert: game currentPlayerPosition equals: 30.
	self assert: game winner equals: game currentPlayer.
	game chooseNextPlayer.
	self assert: game currentPlayerIsWinner equals: false.
	self assert: game currentPlayerPosition equals: 27.
]

{ #category : #tests }
GameTest >> testStartGame [
	| game aBoard players aux |
	aux := GameTest setUpGameValuesExample2.
	aBoard := aux removeFirst.
	players := CircularIterator cyclingOver: aux.
	game := Game playedBy: players on: aBoard.
	self assert: game players equals: players.
	self
		should: [ game winner ]
		raise: TheresNoWinnerYet
		withMessageText: 'No winner yet.'
]
