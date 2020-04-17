"
This class models a game.
"
Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'board',
		'players',
		'winner'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #tests }
Game class >> setUpGameValuesExample1 [
	| player2 die4 die1 dice2 player1 players die3 dice1 die2 game board |
	board := Board withSlots: 30.
	die1 := Die of: 4 rolling: #(1 4 2).
	die2 := Die of: 6 rolling: #(1 5 3).
	dice1 := die1 + die2.
	player1 := Player creation: dice1.
	die3 := Die of: 8 rolling: #(3 7 2).
	die4 := Die of: 4 rolling: #(1 2 3).
	dice2 := die3 + die4.
	player2 := Player creation: dice2.
	player1 boardSlots: board slots.
	player2 boardSlots: board slots.
	players := CircularIterator cyclingOver: (OrderedCollection with: player1 with: player2).
	game := self withBoardAndPlayers: (OrderedCollection with: board with: players).
	^ game
]

{ #category : #initialization }
Game class >> withBoardAndPlayers: aCollection [ 
	^ (self new) initializeWithBoardAndPlayers: aCollection.
]

{ #category : #accessing }
Game >> board [
	^ board
]

{ #category : #'as yet unclassified' }
Game >> chooseNextShift [
	players next.
]

{ #category : #'as yet unclassified' }
Game >> hasAWinner [
	((players current) winner) ifTrue: [ winner := players current].
	^(players current) winner
]

{ #category : #initialization }
Game >> initializeWithBoardAndPlayers: aCollection [ 
	board := aCollection removeFirst.
	players := aCollection removeFirst.
	winner := 0.
]

{ #category : #'as yet unclassified' }
Game >> playShift [
	(players current) throwDice.
]

{ #category : #accessing }
Game >> players [
	^ players
]

{ #category : #'as yet unclassified' }
Game >> whoIsTheWinner [
	^winner
]
