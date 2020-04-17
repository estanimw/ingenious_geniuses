Class {
	#name : #PlayerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
PlayerTest >> testPlayerChangesPositionTwoDie [

	| player dice die1 die2 board |
	board := Board withSlots: 30.
	die1 := Die of: 4 rolling: #(1 4 2).
	die2 := Die of: 6 rolling: #(1 5 3).
	dice := die1 + die2.
	player := Player creation: dice.
	player boardSlots: (board slots).
	player throwDice.
	self assert: (player position) equals: 2.
	player throwDice.
	self assert: (player position) equals: 11.
	player throwDice.
	self assert: (player position) equals: 16.
]

{ #category : #tests }
PlayerTest >> testPlayerGetsNumberOfSlotsOfBoard [

	| player dice die1 die2 board |
	board := Board withSlots: 30.
	die1 := Die of: 4.
	die2 := Die of: 6.
	dice := die1 + die2.
	player := Player creation: dice.
	player boardSlots: (board slots).
	self assert: (player boardSlots) equals: 30.
]

{ #category : #tests }
PlayerTest >> testPlayerReachesTheGoalAndWins [

	| player dice die1 die2 board |
	board := Board withSlots: 15.
	die1 := Die of: 4 rolling: #(1 4 2).
	die2 := Die of: 6 rolling: #(1 5 3).
	dice := die1 + die2.
	player := Player creation: dice.
	player boardSlots: (board slots).
	player throwDice.
	self assert: (player position) equals: 2.
	player throwDice.
	self assert: (player position) equals: 11.
	player throwDice.
	self assert: (player position) equals: 15.
	self assert: (player winner) equals: true.
]
