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
	
	aBoard := Board of: { SpeedUp new . NoEffect new . MoonWalk createSlotWithN: 2 . AtomicBomb new . NoEffect new . NoEffect new . NoEffect new . WormHole new . NoEffect new . SpeedUp new }.
	
	numberOfRoundsToBePlayed := 3.
	
	dieOf4 := Die of: 4 rolling: #(1 4 2).
	dieOf6 := Die of: 6 rolling: #(1 5 3).
	aDice := dieOf4 + dieOf6.
	juan := 'Juan'.
	pancho := 'Pancho'.
	
	cards := { Acceleration. Cancellation. Overload. Redo. Repeat. Speed }.
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
GameTest >> testCancellationNoPuedeJugarseLaCarta [
	| game players |
	players := OrderedCollection with: juan with: pancho.
	aBoard := Board of: { NoEffect new . NoEffect new . CardGiver createSlot . NoEffect new . NoEffect new . NoEffect new . NoEffect new . NoEffect new . NoEffect new . NoEffect new }.
	game := Game
		playedBy: players
		thatUse: aDice
		on: aBoard
		for: numberOfRoundsToBePlayed
		withASetOf: cards.
	
	game giveCard: (Cancellation creacionDeCarta) toPlayer: juan.
	
	self should: [ game player: juan playsTheCard: Cancellation onTarget: {Overload . pancho} ] raise: Error withMessageText: 'No hay cartas permanentes activas'.
]

{ #category : #tests }
GameTest >> testCardGiverGivesOneCardToTheCurrentPlayer [
	| game players |
	players := OrderedCollection with: juan with: pancho.
	aBoard := Board
		of:
			{NoEffect new.
			NoEffect new.
			CardGiver new.
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
	self assert: (game amountOfCardsOf: juan) equals: 2. 
	game playTurn.
	self assert: (game amountOfCardsOf: juan)  equals: 3. 

]

{ #category : #tests }
GameTest >> testCartasSonJugadas [
	| game players |
	players := OrderedCollection with: juan with: pancho.
	aBoard := Board of: { NoEffect new . NoEffect new . CardGiver createSlot . NoEffect new . NoEffect new . NoEffect new . NoEffect new . NoEffect new . NoEffect new . NoEffect new }.
	game := Game
		playedBy: players
		thatUse: aDice
		on: aBoard
		for: numberOfRoundsToBePlayed
		withASetOf: cards.
	game giveCard: (Overload creacionDeCarta) toPlayer: juan.
	game giveCard: (Acceleration creacionDeCarta) toPlayer: pancho.
	
	game player: juan playsTheCard: Overload onTarget: pancho.
	game playTurn.
	game player: pancho playsTheCard: Acceleration onTarget: players.
	game playTurn.
	game playTurn.
	
	self assertCurrentPositionOf: juan in: game equals: 9.
	self assertCurrentPositionOf: pancho in: game equals: 9.
]

{ #category : #tests }
GameTest >> testCartasSonJugadasCancellation [
	| game players |
	players := OrderedCollection with: juan with: pancho.
	aBoard := Board of: { NoEffect new . NoEffect new . CardGiver createSlot . NoEffect new . NoEffect new . NoEffect new . NoEffect new . NoEffect new . NoEffect new . NoEffect new }.
	game := Game
		playedBy: players
		thatUse: aDice
		on: aBoard
		for: numberOfRoundsToBePlayed
		withASetOf: cards.
	game giveCard: (Overload creacionDeCarta) toPlayer: juan.
	game giveCard: (Speed creacionDeCarta) toPlayer: juan.
	game giveCard: (Overload creacionDeCarta) toPlayer: pancho.
	game giveCard: (Cancellation creacionDeCarta) toPlayer: pancho.
	
	game player: juan playsTheCard: Overload onTarget: pancho.
	game player: pancho playsTheCard: Overload onTarget: juan.
	game player: juan playsTheCard: Speed onTarget: pancho.
	
	game playTurn.
	game player: pancho playsTheCard: Cancellation onTarget: {Overload . pancho}.
	
	self assert: (game cardsAffectingPlayer: pancho) equals: 1.
	self assert: (game cardsAffectingPlayer: juan) equals: 1.
]

{ #category : #tests }
GameTest >> testCartasSonJugadasRedo [
	| game players |
	players := OrderedCollection with: juan with: pancho.
	aBoard := Board of: { NoEffect new . NoEffect new . CardGiver createSlot . NoEffect new . NoEffect new . NoEffect new . NoEffect new . NoEffect new . NoEffect new . NoEffect new }.
	game := Game
		playedBy: players
		thatUse: aDice
		on: aBoard
		for: numberOfRoundsToBePlayed
		withASetOf: cards.
	game giveCard: (Redo creacionDeCarta) toPlayer: juan.
	game giveCard: (Speed creacionDeCarta) toPlayer: pancho.
	
	game player: pancho playsTheCard: Speed onTarget: pancho.
	
	game player: juan playsTheCard: Redo onTarget: juan.
	
	game playTurn.
	
	self assert: (game cardsAffectingPlayer: pancho) equals: 1.
	self assert: (game cardsAffectingPlayer: juan) equals: 1.
]

{ #category : #tests }
GameTest >> testCartasSonJugadasRepeat [
	| game players |
	players := OrderedCollection with: juan with: pancho.
	aBoard := Board of: { NoEffect new . NoEffect new . SpeedUp createSlot . NoEffect new . NoEffect new . NoEffect new . NoEffect new . NoEffect new . NoEffect new . NoEffect new }.
	game := Game
		playedBy: players
		thatUse: aDice
		on: aBoard
		for: numberOfRoundsToBePlayed
		withASetOf: cards.
	"game giveCard: (Repeat creacionDeCarta) toPlayer: juan."
	game giveCard: (Repeat creacionDeCarta) toPlayer: pancho.
	game playTurn. "mueve juan"
	game player: pancho playsTheCard: Repeat onTarget: pancho.
	
	
	self assert: (game cardsAffectingPlayer: pancho) equals: 0.
	self assertCurrentPositionOf: pancho in: game equals: 5.
	self assertCurrentPositionOf: juan in: game equals: 7.
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
			MoonWalk createSlotWithN: 2.
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
			MoonWalk createSlotWithN: 2.
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
