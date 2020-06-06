Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#instVars : [
		'juan',
		'pancho',
		'aBoard',
		'numberOfRoundsToBePlayed',
		'dieOf4',
		'dieOf6',
		'aDice',
		'cards'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #assertions }
GameTest >> assertCurrentNumberOfRoundsMadeBy: aPlayer in: aGame equals: numberOfRoundsMade [
	self
		assert: (aGame numberOfRoundsMadeBy: aPlayer)
		equals: numberOfRoundsMade.
]

{ #category : #assertions }
GameTest >> assertCurrentPositionOf: aPlayer in: aGame equals: finalPosition [
	self
		assert: (aGame positionOf: aPlayer)
		equals: finalPosition
]

{ #category : #assertions }
GameTest >> assertRankingOf: aPlayer in: aGame  equals: aRankPosition [
	self
		assert: (aGame rankingOf: aPlayer)
		equals: aRankPosition.
]

{ #category : #utilities }
GameTest >> play: aNumber turnsIn: game [
	1 to: aNumber do: [ :each | game playTurn ]
]

{ #category : #running }
GameTest >> setUp [
	super setUp.
	
	aBoard := Board of: { SpeedUp new . NoEffect new . MoonWalkDeterministic new . AtomicBomb new . NoEffect new . NoEffect new . NoEffect new . WormHole new . NoEffect new . SpeedUp new }.
	
	numberOfRoundsToBePlayed := 3.
	
	dieOf4 := Die of: 4 rolling: #(1 4 2).
	dieOf6 := Die of: 6 rolling: #(1 5 3).
	aDice := dieOf4 + dieOf6.
	juan := 'Juan'.
	pancho := 'Pancho'.
	
	cards := OrderedCollection new.
]

{ #category : #tests }
GameTest >> testAtomicBombEffect [
	| game players |
	players := OrderedCollection with: juan with: pancho.
	aBoard := Board
		of:
			{NoEffect new.
			NoEffect new.
			NoEffect new.
			AtomicBomb new.
			NoEffect new.
			NoEffect new.
			NoEffect new.
			NoEffect new.
			NoEffect new.
			NoEffect new}.
	game := Game
		playedBy: players
		thatUse: aDice
		on: aBoard
		for: numberOfRoundsToBePlayed
		withASetOf: cards.
	self assertCurrentPositionOf: juan in: game equals: 1.
	self assertCurrentPositionOf: pancho in: game equals: 1.
	self play: 8 turnsIn: game.
	self assertCurrentPositionOf: juan in: game equals: 9.
	self assertCurrentNumberOfRoundsMadeBy: juan in: game equals: 1.
	self assertCurrentPositionOf: pancho in: game equals: 6.
	self assertCurrentNumberOfRoundsMadeBy: pancho in: game equals: 2.
	game playTurn.
	self assertCurrentPositionOf: juan in: game equals: 1.
	self assertCurrentNumberOfRoundsMadeBy: juan in: game equals: 2.
	self assertCurrentPositionOf: pancho in: game equals: 1.
	self assertCurrentNumberOfRoundsMadeBy: pancho in: game equals: 2
]

{ #category : #tests }
GameTest >> testGameHasNoWinnerYet [
	| game players |
	players := OrderedCollection with: juan with: pancho.
	game := Game
		playedBy: players
		thatUse: aDice
		on: aBoard
		for: numberOfRoundsToBePlayed
		withASetOf: cards.
	self assert: game hasWinner equals: false
]

{ #category : #tests }
GameTest >> testMoonWalkEffectChangesRoundsMadeIfNecessary [
	| game players |
	players := OrderedCollection with: juan with: pancho.
	aBoard := Board
		of:
			{NoEffect new.
			NoEffect new.
			NoEffect new.
			NoEffect new.
			NoEffect new.
			NoEffect new.
			MoonWalkDeterministic new.
			NoEffect new.
			NoEffect new.
			NoEffect new}.
	game := Game
		playedBy: players
		thatUse: aDice
		on: aBoard
		for: numberOfRoundsToBePlayed
		withASetOf: cards.
	self assertCurrentPositionOf: juan in: game equals: 1.
	self assertCurrentPositionOf: pancho in: game equals: 1.
	self play: 4 turnsIn: game.
	self assertCurrentPositionOf: juan in: game equals: 8.
	self assertCurrentNumberOfRoundsMadeBy: juan in: game equals: 0.
	self assertCurrentPositionOf: pancho in: game equals: 2.
	self assertCurrentNumberOfRoundsMadeBy: pancho in: game equals: 1.
	game playTurn.
	self assertCurrentPositionOf: juan in: game equals: 7.
	self assertCurrentNumberOfRoundsMadeBy: juan in: game equals: 1.
	self assertCurrentPositionOf: pancho in: game equals: 10.
	self assertCurrentNumberOfRoundsMadeBy: pancho in: game equals: 0
]

{ #category : #tests }
GameTest >> testMoonWalkEffectMakesAllThePlayersMoveBackwardNSlots [
	| game players |
	players := OrderedCollection with: juan with: pancho.
	aBoard := Board
		of:
			{NoEffect new.
			NoEffect new.
			NoEffect new.
			NoEffect new.
			NoEffect new.
			NoEffect new.
			NoEffect new.
			MoonWalkDeterministic new.
			NoEffect new.
			NoEffect new}.
	game := Game
		playedBy: players
		thatUse: aDice
		on: aBoard
		for: numberOfRoundsToBePlayed
		withASetOf: cards.
	self assertCurrentPositionOf: juan in: game equals: 1.
	self assertCurrentPositionOf: pancho in: game equals: 1.
	self play: 2 turnsIn: game.
	self assertCurrentPositionOf: juan in: game equals: 3.
	self assertCurrentNumberOfRoundsMadeBy: juan in: game equals: 0.
	self assertCurrentPositionOf: pancho in: game equals: 10.
	self assertCurrentNumberOfRoundsMadeBy: pancho in: game equals: 0.
	game playTurn.
	self assertCurrentPositionOf: juan in: game equals: 8.
	self assertCurrentNumberOfRoundsMadeBy: juan in: game equals: 0.
	self assertCurrentPositionOf: pancho in: game equals: 8.
	self assertCurrentNumberOfRoundsMadeBy: pancho in: game equals: 0
]

{ #category : #tests }
GameTest >> testOnePlayerWinsAndTheOtherLoses [
	| game players |
	players := OrderedCollection with: juan with: pancho.
	game := Game
		playedBy: players
		thatUse: aDice
		on: aBoard
		for: numberOfRoundsToBePlayed
		withASetOf: cards.
	game play.
	self assertRankingOf: juan in: game equals: 1.
	self assertRankingOf: pancho in: game equals: 2
]

{ #category : #tests }
GameTest >> testPlayerWinsThanksToASpeedUpEffect [
	| game players |
	players := OrderedCollection with: juan with: pancho.
	aBoard := Board
		of:
			{NoEffect new.
			NoEffect new.
			NoEffect new.
			NoEffect new.
			NoEffect new.
			NoEffect new.
			NoEffect new.
			NoEffect new.
			NoEffect new.
			SpeedUp new}.
	game := Game
		playedBy: players
		thatUse: aDice
		on: aBoard
		for: numberOfRoundsToBePlayed
		withASetOf: cards.
	self assertCurrentPositionOf: juan in: game equals: 1.
	self assertCurrentPositionOf: pancho in: game equals: 1.
	self play: 7 turnsIn: game.
	self assertCurrentPositionOf: juan in: game equals: 9.
	self assertCurrentNumberOfRoundsMadeBy: juan in: game equals: 1.
	self assertCurrentPositionOf: pancho in: game equals: 1.
	self assertCurrentNumberOfRoundsMadeBy: pancho in: game equals: 2.
	game playTurn.
	self assertCurrentPositionOf: juan in: game equals: 9.
	self assertCurrentNumberOfRoundsMadeBy: juan in: game equals: 1.
	self assertCurrentPositionOf: pancho in: game equals: 4.
	self assertCurrentNumberOfRoundsMadeBy: pancho in: game equals: 3
]

{ #category : #tests }
GameTest >> testSpeedUpEffectChangesRoundsMadeAfterMakingOneLap [
	| game players |
	players := OrderedCollection with: juan with: pancho.
	aBoard := Board
		of:
			{NoEffect new.
			NoEffect new.
			NoEffect new.
			NoEffect new.
			NoEffect new.
			NoEffect new.
			NoEffect new.
			NoEffect new.
			NoEffect new.
			SpeedUp new}.
	game := Game
		playedBy: players
		thatUse: aDice
		on: aBoard
		for: numberOfRoundsToBePlayed
		withASetOf: cards.
	self assertCurrentPositionOf: juan in: game equals: 1.
	self assertCurrentPositionOf: pancho in: game equals: 1.
	game playTurn.
	self assertCurrentPositionOf: juan in: game equals: 3.
	self assertCurrentNumberOfRoundsMadeBy: juan in: game equals: 0.
	self assertCurrentPositionOf: pancho in: game equals: 1.
	self assertCurrentNumberOfRoundsMadeBy: pancho in: game equals: 0.
	game playTurn.
	self assertCurrentPositionOf: juan in: game equals: 3.
	self assertCurrentNumberOfRoundsMadeBy: juan in: game equals: 0.
	self assertCurrentPositionOf: pancho in: game equals: 4.
	self assertCurrentNumberOfRoundsMadeBy: pancho in: game equals: 1
]

{ #category : #tests }
GameTest >> testSpeedUpEffectMakesPlayerMoveForwardFourSlots [
	| game players |
	players := OrderedCollection with: juan with: pancho.
	aBoard := Board
		of:
			{NoEffect new.
			NoEffect new.
			SpeedUp new.
			NoEffect new.
			NoEffect new.
			NoEffect new.
			NoEffect new.
			NoEffect new.
			SpeedUp new.
			NoEffect new}.
	game := Game
		playedBy: players
		thatUse: aDice
		on: aBoard
		for: numberOfRoundsToBePlayed
		withASetOf: cards.
	self assertCurrentPositionOf: juan in: game equals: 1.
	self assertCurrentPositionOf: pancho in: game equals: 1.
	game playTurn.
	self assertCurrentPositionOf: juan in: game equals: 7.
	self assertCurrentNumberOfRoundsMadeBy: juan in: game equals: 0.
	self assertCurrentPositionOf: pancho in: game equals: 1.
	self assertCurrentNumberOfRoundsMadeBy: pancho in: game equals: 0
]

{ #category : #tests }
GameTest >> testWormHoleEffectChangesRoundsMadeIfNecessary [
	| game players |
	players := OrderedCollection with: juan with: pancho.
	aBoard := Board
		of:
			{NoEffect new.
			WormHole new.
			NoEffect new.
			NoEffect new.
			NoEffect new.
			NoEffect new.
			NoEffect new.
			NoEffect new.
			NoEffect new.
			NoEffect new}.
	game := Game
		playedBy: players
		thatUse: aDice
		on: aBoard
		for: numberOfRoundsToBePlayed
		withASetOf: cards.
	self assertCurrentPositionOf: juan in: game equals: 1.
	self assertCurrentPositionOf: pancho in: game equals: 1.
	self play: 3 turnsIn: game.
	self assertCurrentPositionOf: juan in: game equals: 8.
	self assertCurrentNumberOfRoundsMadeBy: juan in: game equals: 0.
	self assertCurrentPositionOf: pancho in: game equals: 10.
	self assertCurrentNumberOfRoundsMadeBy: pancho in: game equals: 0.
	game playTurn.
	self assertCurrentPositionOf: juan in: game equals: 8.
	self assertCurrentNumberOfRoundsMadeBy: juan in: game equals: 0.
	self assertCurrentPositionOf: pancho in: game equals: 8.
	self assertCurrentNumberOfRoundsMadeBy: pancho in: game equals: 0
]

{ #category : #tests }
GameTest >> testWormHoleEffectMakesPlayerMoveBackwardFourSlots [
	| game players |
	players := OrderedCollection with: juan with: pancho.
	aBoard := Board
		of:
			{NoEffect new.
			NoEffect new.
			NoEffect new.
			NoEffect new.
			NoEffect new.
			NoEffect new.
			NoEffect new.
			NoEffect new.
			NoEffect new.
			WormHole new}.
	game := Game
		playedBy: players
		thatUse: aDice
		on: aBoard
		for: numberOfRoundsToBePlayed
		withASetOf: cards.
	self assertCurrentPositionOf: juan in: game equals: 1.
	self assertCurrentPositionOf: pancho in: game equals: 1.
	game playTurn.
	self assertCurrentPositionOf: juan in: game equals: 3.
	self assertCurrentNumberOfRoundsMadeBy: juan in: game equals: 0.
	self assertCurrentPositionOf: pancho in: game equals: 1.
	self assertCurrentNumberOfRoundsMadeBy: pancho in: game equals: 0.
	game playTurn.
	self assertCurrentPositionOf: juan in: game equals: 3.
	self assertCurrentNumberOfRoundsMadeBy: juan in: game equals: 0.
	self assertCurrentPositionOf: pancho in: game equals: 6.
	self assertCurrentNumberOfRoundsMadeBy: pancho in: game equals: 0
]
