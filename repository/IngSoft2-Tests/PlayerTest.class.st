Class {
	#name : #PlayerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
PlayerTest >> testPlayerChangesPositionTwoDie [

	| aPlayer aDice aDieOf4 aDieOf6 aBoard |
	aBoard := Board withSlots: 30.
	aDieOf4 := Die of: 4 rolling: #(1 4 2).
	aDieOf6 := Die of: 6 rolling: #(1 5 3).
	aDice := aDieOf4 + aDieOf6.
	aPlayer := Player playsWith: aDice on: aBoard.
	aPlayer throwDice.
	self assert: (aPlayer currentPosition) equals: 2.
	aPlayer throwDice.
	self assert: (aPlayer currentPosition) equals: 11.
	aPlayer throwDice.
	self assert: (aPlayer currentPosition) equals: 16.
]

{ #category : #tests }
PlayerTest >> testPlayerInitialization [

	| aPlayer aDice aDieOf4 aDieOf6 aBoard |
	aBoard := Board withSlots: 30.
	aDieOf4 := Die of: 4.
	aDieOf6 := Die of: 6.
	aDice := aDieOf4 + aDieOf6.
	aPlayer := Player playsWith: aDice on: aBoard.
	self assert: (aPlayer currentPosition) equals: 0.
	self assert: (aPlayer slotsOfTheBoardOfTheGame) equals: 30.
]

{ #category : #tests }
PlayerTest >> testPlayerReachesTheGoalAndWins [

	| aPlayer aDice aDieOf4 aDieOf6 aBoard |
	aBoard := Board withSlots: 15.
	aDieOf4 := Die of: 4 rolling: #(1 4 2).
	aDieOf6 := Die of: 6 rolling: #(1 5 3).
	aDice := aDieOf4 + aDieOf6.
	aPlayer := Player playsWith: aDice on: aBoard.
	aPlayer throwDice.
	self assert: (aPlayer currentPosition) equals: 2.
	aPlayer throwDice.
	self assert: (aPlayer currentPosition) equals: 11.
	aPlayer throwDice.
	self assert: (aPlayer currentPosition) equals: 15.
	self assert: aPlayer isWinner.
]
