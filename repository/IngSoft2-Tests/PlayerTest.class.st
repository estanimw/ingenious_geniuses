Class {
	#name : #PlayerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
PlayerTest >> testChangesPositionTwoDie [
	| player dice die1 die2 board |
	die1 := Die of: 4 rolling: #(1 4 2).
	die2 := Die of: 6 rolling: #(1 5 3).
	dice := die1 + die2.
	player := Player creation: dice.
	board := Board withSlots: 30.
	player boardSlots: (board slots).
	player throwDice.
	self assert: (player position ) equals: 2.
	player throwDice.
	self assert: (player position ) equals: 11.
	player throwDice.
	self assert: (player position ) equals: 16.
]

{ #category : #tests }
PlayerTest >> testOnePlayerLosesAndOnePlayerWins [
	| player1 dice1 die1 die2 board die3 die4 dice2 player2 |
	die1 := Die of: 4 rolling: #(1 4 2).
	die2 := Die of: 6 rolling: #(1 5 3).
	dice1 := die1 + die2.
	die3 := Die of: 4 rolling: #(1 2 3).
	die4 := Die of: 6 rolling: #(1 2 3).
	dice2 := die3 + die4.
	player1 := Player creation: dice1.
	player2 := Player creation: dice2.
	board := Board withSlots: 15.
	player1 boardSlots: (board slots).
	player2 boardSlots: (board slots).
	player1 throwDice.
	player2 throwDice.
	self assert: (player1 position ) equals: 2.
	self assert: (player2 position ) equals: 2.
	player1 throwDice.
	player2 throwDice.
	self assert: (player1 position ) equals: 11.
	self assert: (player2 position ) equals: 6.
	player1 throwDice.
	player2 throwDice.
	self assert: (player1 position ) equals: 15.
	self assert: (player2 position ) equals: 12.
	
	self assert: (player1 winner) equals: true.
	self assert: (player2 winner) equals: false.
]

{ #category : #tests }
PlayerTest >> testPlayerGetsNumberOfSlotsFromBoard [
	| player dice die1 die2 board |
	die1 := Die of: 4.
	die2 := Die of: 4.
	dice := die1 + die2.
	player := Player creation: dice.
	board := Board withSlots: 30.
	player boardSlots: (board slots).
	self assert: (player boardSlots ) equals: 30.
]

{ #category : #tests }
PlayerTest >> testPlayerInitialization [	
	| player dice die1 die2 |
	die1 := Die of: 4.
	die2 := Die of: 4.
	dice := die1 + die2.
	player := Player creation: dice.
	self assert: (player position ) equals: 0.
]

{ #category : #tests }
PlayerTest >> testPlayerReachesTheGoalAndWins [
	| player dice die1 die2 board |
	die1 := Die of: 4 rolling: #(1 4 2).
	die2 := Die of: 6 rolling: #(1 5 3).
	dice := die1 + die2.
	player := Player creation: dice.
	board := Board withSlots: 15.
	player boardSlots: (board slots).
	player throwDice.
	self assert: (player position ) equals: 2.
	player throwDice.
	self assert: (player position ) equals: 11.
	player throwDice.
	self assert: (player position ) equals: 15.
	self assert: (player winner) equals: true.
]
