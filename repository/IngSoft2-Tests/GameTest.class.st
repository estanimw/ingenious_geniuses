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
		'dieOf8',
		'diceOf10',
		'diceOfJuan',
		'diceOfPancho',
		'aDice'
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
	
	aBoard := Board of: 30 with: NoEffect.
	numberOfRoundsToBePlayed := 3.
	
"	dieOf4 := Die of: 4 rolling: #(1 4 2).
	dieOf6 := Die of: 6 rolling: #(1 5 3).
	dieOf8 := Die of: 8 rolling: #(3 7 2).
	diceOf10 := Die of: 10 rolling: #(1 2 3).
	
	diceOfJuan := dieOf4 + dieOf6.
   diceOfPancho := dieOf8 + diceOf10.
	
	juan := Player playsWith: diceOfJuan.
	pancho := Player playsWith: diceOfPancho."
	dieOf4 := Die of: 4 rolling: #(1 4 2).
	dieOf6 := Die of: 6 rolling: #(1 5 3).
	aDice := dieOf4 + dieOf6.
	juan := 'Juan'.
	pancho := 'Pancho'.
	"players := OrderedCollection with: juan with: pancho.
	game := Game playedBy: players on: aBoard until: numberOfRoundsToBePlayed."
]

{ #category : #tests }
GameTest >> testAtomicBombEffect [
	| game players |
	players := OrderedCollection with: juan with: pancho.
	aBoard := Board of: 30 with: AtomicBomb.
	game := Game playedBy: players thatUse: aDice on: aBoard for: numberOfRoundsToBePlayed.
	
	self assertCurrentPositionOf: juan in: game equals: 0.
	self assertCurrentPositionOf: pancho in: game equals: 0.
	
	game playTurn.
	self assertCurrentPositionOf: juan in: game equals: 2.
	self assertCurrentPositionOf: pancho in: game equals: 0.
	
	game playTurn.
	self assertCurrentPositionOf: juan in: game equals: 2.
	self assertCurrentPositionOf: pancho in: game equals: 9.
	
	
	game playTurn.
	self assertCurrentPositionOf: juan in: game equals: 0.
	self assertCurrentPositionOf: pancho in: game equals: 0.
]

{ #category : #tests }
GameTest >> testBoardOfPositionsChangesAfterEveryMovement [
	| game players |
	players := OrderedCollection with: juan with: pancho.
	game := Game playedBy: players thatUse: aDice on: aBoard for: numberOfRoundsToBePlayed.
	
	self assertCurrentPositionOf: juan in: game equals: 0.
	self assertCurrentPositionOf: pancho in: game equals: 0.
	
	game playTurn.
	self assertCurrentPositionOf: juan in: game equals: 2.
	self assertCurrentPositionOf: pancho in: game equals: 0.
	
	game playTurn.
	self assertCurrentPositionOf: juan in: game equals: 2.
	self assertCurrentPositionOf: pancho in: game equals: 9.
	
	game playTurn.
	self assertCurrentPositionOf: juan in: game equals: 7.
	self assertCurrentPositionOf: pancho in: game equals: 9.
]

{ #category : #tests }
GameTest >> testBoardOfRoundsMadeChangesAfterEveryMovement [
	| game players |
	players := OrderedCollection with: juan with: pancho.
	game := Game playedBy: players thatUse: aDice on: aBoard for: numberOfRoundsToBePlayed.
	
	self assertCurrentNumberOfRoundsMadeBy: juan in: game equals: 0.
	self assertCurrentNumberOfRoundsMadeBy: pancho in: game equals: 0.
	
	self play: 23 turnsIn: game.
	"game play."
	
	self assertCurrentNumberOfRoundsMadeBy: juan in: game equals: 2.
	self assertCurrentNumberOfRoundsMadeBy: pancho in: game equals: 1.
]

{ #category : #tests }
GameTest >> testBoardOfWhoIsWinningChangesAfterEveryMovement [
	| thePlayers game dieOf5 dieOf7 diceOfPedrito pedrito dieOf9 diceOfRenzo renzo |
	
"	dieOf5 := Die of: 5 rolling: #(5 4 4).
	dieOf7 := Die of: 7 rolling: #(5 5 3).
	diceOfPedrito := dieOf5 + dieOf7.
	pedrito := Player playsWith: diceOfPedrito.
	
	dieOf9 := Die of: 9 rolling: #(8 4 3).
	diceOfRenzo := dieOf9 + dieOf9.
	renzo := Player playsWith: diceOfRenzo."
	pedrito := 'Pedrito'.
	renzo := 'Renzo'.
	
	thePlayers := OrderedCollection with: juan with: pancho with: pedrito with: renzo.
	game := Game playedBy: thePlayers thatUse: aDice on: aBoard for: numberOfRoundsToBePlayed.
	
	game playTurn.
	self assertRankingOf: juan in: game equals: 1.
	
	game playTurn.
	self assertRankingOf: pancho in: game equals: 1.
	self assertRankingOf: juan in: game equals: 2.
	
	"self play: 3 turnsIn: game."
	game play.
	
	self assertRankingOf: juan in: game equals: 1.
	self assertRankingOf: pancho in: game equals: 2.
	self assertRankingOf: pedrito in: game equals: 3.
	self assertRankingOf: renzo in: game equals: 4.
]

{ #category : #tests }
GameTest >> testGameHasNoWinnerYet [
	| game players |
	players := OrderedCollection with: juan with: pancho.
	game := Game playedBy: players thatUse: aDice on: aBoard for: numberOfRoundsToBePlayed.
	
	self
		should: [ game winner ]
		raise: TheresNoWinnerYet
		withMessageText: 'No winner yet.'
]

{ #category : #tests }
GameTest >> testMoonWalkEffect [
	| game players |
	players := OrderedCollection with: juan with: pancho.
	aBoard := Board of: 30 with: MoonWalkDeterministic.
	game := Game playedBy: players thatUse: aDice on: aBoard for: numberOfRoundsToBePlayed.
	
	self assertCurrentPositionOf: juan in: game equals: 0.
	self assertCurrentPositionOf: pancho in: game equals: 0.
	
	game playTurn.
	self assertCurrentPositionOf: juan in: game equals: 2.
	self assertCurrentPositionOf: pancho in: game equals: 0.
	
	game playTurn.
	self assertCurrentPositionOf: juan in: game equals: 2.
	self assertCurrentPositionOf: pancho in: game equals: 9.
	
	
	game playTurn.
	self assertCurrentPositionOf: juan in: game equals: 7.
	self assertCurrentPositionOf: pancho in: game equals: 8.
]

{ #category : #tests }
GameTest >> testOnePlayerWinsAndTheOtherLoses [
	| game players |
	players := OrderedCollection with: juan with: pancho.
	game := Game playedBy: players thatUse: aDice on: aBoard for: numberOfRoundsToBePlayed.
	
	game play.
	"game winner == 'pancho'."
	self assertRankingOf: pancho in: game equals: 1.
	self assertRankingOf: juan in: game equals: 2
]

{ #category : #tests }
GameTest >> testSpeedUpEffect [
	| game players |
	players := OrderedCollection with: juan with: pancho.
	aBoard := Board of: 30 with: SpeedUp.
	game := Game playedBy: players thatUse: aDice on: aBoard for: numberOfRoundsToBePlayed.
	
	self assertCurrentPositionOf: juan in: game equals: 0.
	self assertCurrentPositionOf: pancho in: game equals: 0.
	
	game playTurn.
	self assertCurrentPositionOf: juan in: game equals: 2.
	self assertCurrentPositionOf: pancho in: game equals: 0.
	
	game playTurn.
	self assertCurrentPositionOf: juan in: game equals: 2.
	self assertCurrentPositionOf: pancho in: game equals: 9.
	
	game playTurn.
	self assertCurrentPositionOf: juan in: game equals: 11.
	self assertCurrentPositionOf: pancho in: game equals: 9.
]

{ #category : #tests }
GameTest >> testWormHoleEffect [
	| game players |
	players := OrderedCollection with: juan with: pancho.
	aBoard := Board of: 30 with: WormHole.
	game := Game playedBy: players thatUse: aDice on: aBoard for: numberOfRoundsToBePlayed.
	
	self assertCurrentPositionOf: juan in: game equals: 0.
	self assertCurrentPositionOf: pancho in: game equals: 0.
	
	game playTurn.
	self assertCurrentPositionOf: juan in: game equals: 2.
	self assertCurrentPositionOf: pancho in: game equals: 0.
	
	game playTurn.
	self assertCurrentPositionOf: juan in: game equals: 2.
	self assertCurrentPositionOf: pancho in: game equals: 9.
	
	game playTurn.
	self assertCurrentPositionOf: juan in: game equals: 3.
	self assertCurrentPositionOf: pancho in: game equals: 9.
]
