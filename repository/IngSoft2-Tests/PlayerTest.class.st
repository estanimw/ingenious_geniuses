Class {
	#name : #PlayerTest,
	#superclass : #TestCase,
	#instVars : [
		'aBoard',
		'aDice'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #running }
PlayerTest >> setUp [
	| aDieOf4 aDieOf5 |
	super setUp.
	
	aBoard := 15.
	aDieOf4 := Die of: 4 rolling: #(1 4 2).
	aDieOf5 := Die of: 5 rolling: #(1 5 3).
	aDice := aDieOf4 + aDieOf5.

]

{ #category : #tests }
PlayerTest >> testPlayerChangesPositionUsingADiceAndWins [
	| pedro players game numberOfRoundsToBePlayed |
	
	numberOfRoundsToBePlayed := 1.
	pedro := Player playsWith: aDice.
	players := OrderedCollection with: pedro.
	game := Game playedBy: players on: aBoard until: numberOfRoundsToBePlayed.
	
	game playTurn.
	self assert: pedro currentPosition equals: 2.
	
	game playTurn.
	self assert: pedro currentPosition equals: 11.
	
	game playTurn.
	self assert: pedro isWinner.
]

{ #category : #tests }
PlayerTest >> testPlayerHasInvalidDie [
	| francisco aDieOf6 players game numberOfRoundsToBePlayed|
	numberOfRoundsToBePlayed := 3.

	aDieOf6 := Die of: 6 rolling: #(1 5 3).
	aDice := aDieOf6 + aDieOf6.
	francisco := Player playsWith: aDice.
	players := OrderedCollection with: francisco.
	
	self
		should: [ game := Game playedBy: players on: aBoard until: numberOfRoundsToBePlayed ]
		raise: ThePlayerHasAnInvalidDie
		withMessageText: 'The die are invalid'
]

{ #category : #tests }
PlayerTest >> testPlayerInitialization [

	| martin |
	martin := Player playsWith: aDice.
	self assert: (martin currentPosition) equals: 0.
]
