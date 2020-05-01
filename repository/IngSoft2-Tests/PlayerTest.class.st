Class {
	#name : #PlayerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
PlayerTest >> testPlayerChangesPositionUsingTwoDieAndWins [

	| aPlayer aDice aDieOf4 aDieOf5 aBoard players game |
	aBoard := 15.
	aDieOf4 := Die of: 4 rolling: #(1 4 2).
	aDieOf5 := Die of: 5 rolling: #(1 5 3).
	aDice := aDieOf4 + aDieOf5.
	aPlayer := Player playsWith: aDice.
	players:= CircularIterator cyclingOver: (OrderedCollection with: aPlayer).
	game := Game playedBy: players on: aBoard.
	game playTurn.
	self assert: (aPlayer currentPosition) equals: 2.
	game playTurn.
	self assert: (aPlayer currentPosition) equals: 11.
	game playTurn.
	self assert: (aPlayer currentPosition) equals: 15.
]

{ #category : #tests }
PlayerTest >> testPlayerHasInvalidDie [

	| aPlayer aDice aDieOf4 aDieOf6 aBoard players game |
	aBoard := 15.
	aDieOf4 := Die of: 4 rolling: #(1 4 2).
	aDieOf6 := Die of: 6 rolling: #(1 5 3).
	aDice := aDieOf4 + aDieOf6.
	aPlayer := Player playsWith: aDice.
	players:= CircularIterator cyclingOver: (OrderedCollection with: aPlayer).
	self
		should: [ game := Game playedBy: players on: aBoard ]
		raise: Error
		withMessageText: 'Error con los dados'

]

{ #category : #tests }
PlayerTest >> testPlayerInitialization [

	| aPlayer aDice aDieOf4 aDieOf6 |
	aDieOf4 := Die of: 4.
	aDieOf6 := Die of: 6.
	aDice := aDieOf4 + aDieOf6.
	aPlayer := Player playsWith: aDice.
	self assert: (aPlayer currentPosition) equals: 0.
]
