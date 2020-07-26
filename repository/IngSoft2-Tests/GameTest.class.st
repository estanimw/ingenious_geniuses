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
	
	aBoard := Board ofASlotDistribution: { SpeedUp createSlot . NoEffect createSlot . MoonWalk createSlotWithN: 2 . AtomicBomb createSlot . NoEffect createSlot . NoEffect createSlot . NoEffect createSlot . WormHole createSlot . NoEffect createSlot . SpeedUp createSlot }.
	
	numberOfRoundsToBePlayed := 3.
	
	dieOf4 := Die of: 4 rolling: #(1 4 2).
	dieOf6 := Die of: 6 rolling: #(1 5 3).
	aDice := dieOf4 + dieOf6.
	juan := 'Juan'.
	pancho := 'Pancho'.
	
	cards := { Acceleration. Cancellation. Overload. Redo. Repeat. Speed }.
]

{ #category : #tests }
GameTest >> testAccelerationIncreasesTheTotalRollOfAllPlayersByOne [
	| game players |
	players := OrderedCollection with: juan with: pancho.
	aBoard := Board
		ofASlotDistribution:
			{NoEffect createSlot.
			NoEffect createSlot.
			CardGiver createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot}.
	game := Game
		playedBy: players
		thatUse: aDice
		on: aBoard
		for: numberOfRoundsToBePlayed
		withASetOf: cards.
	game giveCard: Acceleration createCard toPlayer: juan.
	game player: juan playsTheCard: Acceleration onTarget: players.
	game playTurn.
	game playTurn.
	self assertCurrentPositionOf: juan in: game equals: 4.
	self assertCurrentPositionOf: pancho in: game equals: 1.
]

{ #category : #tests }
GameTest >> testAccelerationIsAccumulative [
	| game players |
	players := OrderedCollection with: juan with: pancho.
	aBoard := Board
		ofASlotDistribution:
			{NoEffect createSlot.
			NoEffect createSlot.
			CardGiver createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot}.
	game := Game
		playedBy: players
		thatUse: aDice
		on: aBoard
		for: numberOfRoundsToBePlayed
		withASetOf: cards.
	game giveCard: Acceleration createCard toPlayer: juan.
	game giveCard: Acceleration createCard toPlayer: pancho.
	game player: juan playsTheCard: Acceleration onTarget: players.
	game playTurn.
	game player: pancho playsTheCard: Acceleration onTarget: players.
	game playTurn.
	self assertCurrentPositionOf: juan in: game equals: 4.
	self assertCurrentPositionOf: pancho in: game equals: 2.
]

{ #category : #tests }
GameTest >> testAllEffectsAreAccumulative [
	| game players |
	players := OrderedCollection with: juan with: pancho.
	aBoard := Board
		ofASlotDistribution:
			{NoEffect createSlot.
			NoEffect createSlot.
			CardGiver createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot}.
	game := Game
		playedBy: players
		thatUse: aDice
		on: aBoard
		for: numberOfRoundsToBePlayed
		withASetOf: cards.
	game giveCard: Acceleration createCard toPlayer: juan.
	game giveCard: Speed createCard toPlayer: juan.
	game giveCard: Speed createCard toPlayer: juan.
	game giveCard: Overload createCard toPlayer: pancho.
	game player: juan playsTheCard: Acceleration onTarget: players.
	game player: juan playsTheCard: Speed onTarget: juan.
	game player: juan playsTheCard: Speed onTarget: juan.
	game playTurn.
	self assertCurrentPositionOf: juan in: game equals: 6.
	self assertCurrentNumberOfRoundsMadeBy: juan in: game equals: 0.
	self assertCurrentPositionOf: pancho in: game equals: 1.
	self assertCurrentNumberOfRoundsMadeBy: pancho in: game equals: 0.
	game player: pancho playsTheCard: Overload onTarget: juan.
	self play: 2 turnsIn: game.
	self assertCurrentPositionOf: juan in: game equals: 2.
	self assertCurrentNumberOfRoundsMadeBy: juan in: game equals: 1.
	self assertCurrentPositionOf: pancho in: game equals: 1.
	self assertCurrentNumberOfRoundsMadeBy: pancho in: game equals: 1.
]

{ #category : #tests }
GameTest >> testAtomicBombEffect [
	| game players |
	players := OrderedCollection with: juan with: pancho.
	aBoard := Board
		ofASlotDistribution:
			{NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			AtomicBomb createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot}.
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
GameTest >> testCancellationCantCancellACardThatIsntAffectingThePlayer [
	| game players |
	players := OrderedCollection with: juan with: pancho.
	aBoard := Board
		ofASlotDistribution:
			{NoEffect createSlot.
			NoEffect createSlot.
			CardGiver createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot}.
	game := Game
		playedBy: players
		thatUse: aDice
		on: aBoard
		for: numberOfRoundsToBePlayed
		withASetOf: cards.
	game giveCard: Overload createCard toPlayer: juan.
	game giveCard: Overload createCard toPlayer: pancho.
	game giveCard: Cancellation createCard toPlayer: pancho.
	game player: juan playsTheCard: Overload onTarget: pancho.
	game playTurn.
	game player: pancho playsTheCard: Overload onTarget: juan.
	game playTurn.
	game playTurn.
	self assert: (game numberOfCardsAffectingPlayer: pancho) equals: 1.
	self assert: (game numberOfCardsAffectingPlayer: juan) equals: 1.
	self should: [game player: pancho playsTheCard: Cancellation onTarget: {Speed . pancho}] raise: Error withMessageText: 'There isn`t that card affecting this player'.
]

{ #category : #tests }
GameTest >> testCancellationEliminatesOneActiveCardOverAPlayer [
	| game players |
	players := OrderedCollection with: juan with: pancho.
	aBoard := Board
		ofASlotDistribution:
			{NoEffect createSlot.
			NoEffect createSlot.
			CardGiver createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot}.
	game := Game
		playedBy: players
		thatUse: aDice
		on: aBoard
		for: numberOfRoundsToBePlayed
		withASetOf: cards.
	game giveCard: Overload createCard toPlayer: juan.
	game giveCard: Speed createCard toPlayer: juan.
	game giveCard: Overload createCard toPlayer: pancho.
	game giveCard: Cancellation createCard toPlayer: pancho.
	game player: juan playsTheCard: Overload onTarget: pancho.
	game playTurn.
	game player: pancho playsTheCard: Overload onTarget: juan.
	game playTurn.
	game player: juan playsTheCard: Speed onTarget: pancho.
	game playTurn.
	self assert: (game numberOfCardsAffectingPlayer: pancho) equals: 2.
	self assert: (game numberOfCardsAffectingPlayer: juan) equals: 1.
	game player: pancho playsTheCard: Cancellation onTarget: {Overload . pancho}.
	self assert: (game numberOfCardsAffectingPlayer: pancho) equals: 1.
	self assert: (game numberOfCardsAffectingPlayer: juan) equals: 1
]

{ #category : #tests }
GameTest >> testCardGiverGivesOneCardToTheCurrentPlayer [
	| game players |
	players := OrderedCollection with: juan with: pancho.
	aBoard := Board
		ofASlotDistribution:
			{NoEffect createSlot.
			NoEffect createSlot.
			CardGiver createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot}.
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
GameTest >> testHappyPathDeterministic [
	| game players aDie otherDie builder |
	players := OrderedCollection with: juan with: pancho.
	
	1000 timesRepeat: [ 
	builder := BoardBuilder forABoardOfSize: 100.
	builder addEffect: AtomicBomb withOccurrencyOf: 2.
	builder addEffect: NoEffect withOccurrencyOf: 38.
	builder addEffect: SpeedUp withOccurrencyOf: 20. 
	builder addEffect: MoonWalk withOccurrencyOf: 10.
	builder addEffect: WormHole withOccurrencyOf: 20.
	builder addEffect: CardGiver withOccurrencyOf: 10.
	
	aBoard := builder build.
	
	aDie := Die ofASlotDistribution: 6.
	otherDie := Die ofASlotDistribution: 6.
	aDice := aDie + otherDie.
	
	game := Game
		playedBy: players
		thatUse: aDice
		on: aBoard
		for: numberOfRoundsToBePlayed
		withASetOf: cards.
	
	game play.
	self assert: game hasWinner equals: true ]
]

{ #category : #tests }
GameTest >> testHappyPathNoDeterministic [
	| game players aDie otherDie builder |
	players := OrderedCollection with: juan with: pancho.
	
	1000 timesRepeat: [ 
	builder := BoardBuilder forABoardOfSize: 100.
	builder addEffect: AtomicBomb withOccurrencyOf: 2.
	builder addEffect: NoEffect withOccurrencyOf: 38.
	builder addEffect: SpeedUp withOccurrencyOf: 20. 
	builder addEffect: MoonWalk withOccurrencyOf: 10.
	builder addEffect: WormHole withOccurrencyOf: 20.
	builder addEffect: CardGiver withOccurrencyOf: 10.
	
	aBoard := builder build.
	
	aDie := Die ofASlotDistribution: 6.
	otherDie := Die ofASlotDistribution: 6.
	aDice := aDie + otherDie.
	
	game := Game
		playedBy: players
		thatUse: aDice
		on: aBoard
		for: numberOfRoundsToBePlayed
		withASetOf: cards.
	
	game play.
	self assert: game hasWinner equals: true ]
]

{ #category : #tests }
GameTest >> testMoonWalkEffectChangesRoundsMadeIfNecessary [
	| game players |
	players := OrderedCollection with: juan with: pancho.
	aBoard := Board
		ofASlotDistribution:
			{NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			MoonWalk createSlotWithN: 2.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot}.
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
		ofASlotDistribution:
			{NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			MoonWalk createSlotWithN: 2.
			NoEffect createSlot.
			NoEffect createSlot}.
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
GameTest >> testOverloadCanMakeAPlayerMoveBackwards [
	| game players |
	players := OrderedCollection with: juan with: pancho.
	aBoard := Board
		ofASlotDistribution:
			{NoEffect createSlot.
			NoEffect createSlot.
			CardGiver createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot}.
	game := Game
		playedBy: players
		thatUse: aDice
		on: aBoard
		for: numberOfRoundsToBePlayed
		withASetOf: cards.
	game giveCard: Overload createCard toPlayer: pancho.
	game giveCard: Overload createCard toPlayer: pancho.
	game playTurn.
	self assertCurrentPositionOf: juan in: game equals: 3.
	game player: pancho playsTheCard: Overload onTarget: juan.
	game player: pancho playsTheCard: Overload onTarget: juan.
	game player: pancho playsTheCard: Overload onTarget: juan.
	self play: 2 turnsIn: game.
	self assertCurrentPositionOf: juan in: game equals: 2.
]

{ #category : #tests }
GameTest >> testOverloadCanMakeAPlayerMoveBackwardsAndChangeTheNumberOfRoundsMadeByThePlayer [
	| game players |
	players := OrderedCollection with: juan with: pancho.
	aBoard := Board
		ofASlotDistribution:
			{NoEffect createSlot.
			NoEffect createSlot.
			CardGiver createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot}.
	game := Game
		playedBy: players
		thatUse: aDice
		on: aBoard
		for: numberOfRoundsToBePlayed
		withASetOf: cards.
	game giveCard: Overload createCard toPlayer: juan.
	game giveCard: Overload createCard toPlayer: juan.
	game giveCard: Overload createCard toPlayer: juan.
	game giveCard: Overload createCard toPlayer: juan.
	self play: 4 turnsIn: game.
	self assertCurrentPositionOf: juan in: game equals: 8.
	self assertCurrentNumberOfRoundsMadeBy: juan in: game equals: 0. 
	self assertCurrentPositionOf: pancho in: game equals: 2.
	self assertCurrentNumberOfRoundsMadeBy: pancho in: game equals: 1.
	game player: juan playsTheCard: Overload onTarget: pancho.
	game player: juan playsTheCard: Overload onTarget: pancho.
	game player: juan playsTheCard: Overload onTarget: pancho.
	game player: juan playsTheCard: Overload onTarget: pancho.
	self play: 2 turnsIn: game.

	self assertCurrentPositionOf: juan in: game equals: 7.
	self assertCurrentNumberOfRoundsMadeBy: juan in: game equals: 1. 
	self assertCurrentPositionOf: pancho in: game equals: 9.
	self assertCurrentNumberOfRoundsMadeBy: pancho in: game equals: 0.
]

{ #category : #tests }
GameTest >> testOverloadCantMakeAPlayerMoveBackwardsAtFirstPositionOfFirstRound [
	| game players |
	players := OrderedCollection with: juan with: pancho.
	aBoard := Board
		ofASlotDistribution:
			{NoEffect createSlot.
			NoEffect createSlot.
			CardGiver createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot}.
	game := Game
		playedBy: players
		thatUse: aDice
		on: aBoard
		for: numberOfRoundsToBePlayed
		withASetOf: cards.
	game giveCard: Overload createCard toPlayer: pancho.
	game giveCard: Overload createCard toPlayer: pancho.
	game giveCard: Overload createCard toPlayer: pancho.
	game giveCard: Overload createCard toPlayer: pancho.
	game playTurn.
	self assertCurrentPositionOf: juan in: game equals: 3.
	self assertCurrentNumberOfRoundsMadeBy: juan in: game equals: 0. 
	game player: pancho playsTheCard: Overload onTarget: juan.
	game player: pancho playsTheCard: Overload onTarget: juan.
	game player: pancho playsTheCard: Overload onTarget: juan.
	game player: pancho playsTheCard: Overload onTarget: juan.
	self play: 2 turnsIn: game.
	self assertCurrentPositionOf: juan in: game equals: 1.
	self assertCurrentNumberOfRoundsMadeBy: juan in: game equals: 0.
]

{ #category : #tests }
GameTest >> testOverloadCombinedWithAnSlotEffect [
	| game players |
	players := OrderedCollection with: juan with: pancho.
	aBoard := Board
		ofASlotDistribution:
			{NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			SpeedUp createSlot.
			NoEffect createSlot.
			NoEffect createSlot}.
	game := Game
		playedBy: players
		thatUse: aDice
		on: aBoard
		for: numberOfRoundsToBePlayed
		withASetOf: cards.
	game giveCard: Overload createCard toPlayer: juan.
	game player: juan playsTheCard: Overload onTarget: pancho.
	
	self play: 3 turnsIn: game.
	self assertCurrentPositionOf: pancho in: game equals: 2.
	self assertCurrentNumberOfRoundsMadeBy: pancho in: game equals: 1.
]

{ #category : #tests }
GameTest >> testOverloadCombinedWithAnotherCardOfAnotherType [
	| game players |
	players := OrderedCollection with: juan with: pancho.
	aBoard := Board
		ofASlotDistribution:
			{NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot}.
	game := Game
		playedBy: players
		thatUse: aDice
		on: aBoard
		for: numberOfRoundsToBePlayed
		withASetOf: cards.
	game giveCard: Overload createCard toPlayer: pancho.
	game giveCard: Speed createCard toPlayer: pancho.
	game playTurn.
	self assertCurrentPositionOf: juan in: game equals: 3.
	game player: pancho playsTheCard: Overload onTarget: juan.
	game player: pancho playsTheCard: Speed onTarget: juan.
	self play: 2 turnsIn: game.
	self assertCurrentPositionOf: juan in: game equals: 7.
]

{ #category : #tests }
GameTest >> testOverloadIsAccumulative [
	| game players |
	players := OrderedCollection with: juan with: pancho.
	aBoard := Board
		ofASlotDistribution:
			{NoEffect createSlot.
			NoEffect createSlot.
			CardGiver createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot}.
	game := Game
		playedBy: players
		thatUse: aDice
		on: aBoard
		for: numberOfRoundsToBePlayed
		withASetOf: cards.
	game giveCard: Overload createCard toPlayer: pancho.
	game giveCard: Overload createCard toPlayer: pancho.
	game playTurn.
	self assertCurrentPositionOf: juan in: game equals: 3.
	game player: pancho playsTheCard: Overload onTarget: juan.
	game player: pancho playsTheCard: Overload onTarget: juan.
	game playTurn.
	game playTurn.
	self assertCurrentPositionOf: juan in: game equals: 4.
]

{ #category : #tests }
GameTest >> testOverloadReduceTheTotalRollOfAPlayerByTwoAndDoesntAffectTheOtherPlayers [
	| game players |
	players := OrderedCollection with: juan with: pancho.
	aBoard := Board
		ofASlotDistribution:
			{NoEffect createSlot.
			NoEffect createSlot.
			CardGiver createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot}.
	game := Game
		playedBy: players
		thatUse: aDice
		on: aBoard
		for: numberOfRoundsToBePlayed
		withASetOf: cards.
	game giveCard: Overload createCard toPlayer: juan.
	game player: juan playsTheCard: Overload onTarget: juan.
	self assertCurrentPositionOf: juan in: game equals: 1.
	self assertCurrentPositionOf: pancho in: game equals: 1.
	self play: 2 turnsIn: game.
	self assertCurrentPositionOf: juan in: game equals: 1.
	self assertCurrentPositionOf: pancho in: game equals: 10.
]

{ #category : #tests }
GameTest >> testPlayerCantPlayCancellationBecauseThereAreNotActiveCardsInGame [
	| game players |
	players := OrderedCollection with: juan with: pancho.
	aBoard := Board
		ofASlotDistribution:
			{NoEffect createSlot.
			NoEffect createSlot.
			CardGiver createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot}.
	game := Game
		playedBy: players
		thatUse: aDice
		on: aBoard
		for: numberOfRoundsToBePlayed
		withASetOf: cards.
	game giveCard: Cancellation createCard toPlayer: juan.
	self
		should: [ game
				player: juan
				playsTheCard: Cancellation
				onTarget:
					{Overload .
					pancho} ]
		raise: Error
		withMessageText: 'There aren`t permanent cards in game'
]

{ #category : #tests }
GameTest >> testPlayerCantUseAPermanentCardIfItsNotHisTurn [
	| game players |
	players := OrderedCollection with: juan with: pancho.
	aBoard := Board
		ofASlotDistribution:
			{NoEffect createSlot.
			NoEffect createSlot.
			CardGiver createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot}.
	game := Game
		playedBy: players
		thatUse: aDice
		on: aBoard
		for: numberOfRoundsToBePlayed
		withASetOf: cards.
	game giveCard: Acceleration createCard toPlayer: pancho.
	game giveCard: Speed createCard toPlayer: pancho.
	self
		should: [ game player: pancho playsTheCard: Overload onTarget: juan ]
		raise: Error
		withMessageText: 'You can`t play that card because it`s not your turn'.
	self
		should:
			[ game player: pancho playsTheCard: Acceleration onTarget: juan ]
		raise: Error
		withMessageText: 'You can`t play that card because it`s not your turn'.
	self
		should: [ game player: pancho playsTheCard: Speed onTarget: juan ]
		raise: Error
		withMessageText: 'You can`t play that card because it`s not your turn'
]

{ #category : #tests }
GameTest >> testPlayerWinsThanksToASpeedUpEffect [
	| game players |
	players := OrderedCollection with: juan with: pancho.
	aBoard := Board
		ofASlotDistribution:
			{NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			SpeedUp createSlot}.
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
	self assertCurrentNumberOfRoundsMadeBy: pancho in: game equals: 3.
	self assert: game winner equals: pancho.
]

{ #category : #tests }
GameTest >> testPlayersPlaySomeCards [
	| game players |
	players := OrderedCollection with: juan with: pancho.
	aBoard := Board
		ofASlotDistribution:
			{NoEffect createSlot.
			NoEffect createSlot.
			CardGiver createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot}.
	game := Game
		playedBy: players
		thatUse: aDice
		on: aBoard
		for: numberOfRoundsToBePlayed
		withASetOf: cards.
	game giveCard: Overload createCard toPlayer: juan.
	game giveCard: Acceleration createCard toPlayer: pancho.
	game player: juan playsTheCard: Overload onTarget: pancho.
	game playTurn.
	game
		player: pancho
		playsTheCard: Acceleration
		onTarget: players.
	game playTurn.
	game playTurn.
	self assertCurrentPositionOf: juan in: game equals: 9.
	self assertCurrentPositionOf: pancho in: game equals: 9
]

{ #category : #tests }
GameTest >> testRedoCantBeUsedBecauseNoOtherCardHaveBeenPlayedYet [
	| game players |
	players := OrderedCollection with: juan with: pancho.
	aBoard := Board
		ofASlotDistribution:
			{NoEffect createSlot.
			NoEffect createSlot.
			CardGiver createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot}.
	game := Game
		playedBy: players
		thatUse: aDice
		on: aBoard
		for: numberOfRoundsToBePlayed
		withASetOf: cards.
	game giveCard: Redo createCard toPlayer: juan.
	game playTurn.
	self should: [game player: juan playsTheCard: Redo onTarget: pancho] raise: Error withMessageText: 'Redo can´t be played because no other cards have been played yet.'.
]

{ #category : #tests }
GameTest >> testRedoRepeatsTheEffectOfLastCardPlayedThisOneBeingACancellation [
	| game players |
	players := OrderedCollection with: juan with: pancho.
	aBoard := Board
		ofASlotDistribution:
			{NoEffect createSlot.
			NoEffect createSlot.
			CardGiver createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot}.
	game := Game
		playedBy: players
		thatUse: aDice
		on: aBoard
		for: numberOfRoundsToBePlayed
		withASetOf: cards.
	game giveCard: Redo createCard toPlayer: juan.
	game giveCard: Speed createCard toPlayer: juan.
	game giveCard: Cancellation createCard toPlayer: pancho.
	game giveCard: Speed createCard toPlayer: pancho.
	game player: juan playsTheCard: Speed onTarget: juan.
	game playTurn.
	game player: pancho playsTheCard: Speed onTarget: pancho.
	game
		player: pancho
		playsTheCard: Cancellation
		onTarget:
			{Speed.
			juan}.
	game
		player: juan
		playsTheCard: Redo
		onTarget:
			{Speed.
			pancho}.
	game playTurn.
	self assert: (game numberOfCardsAffectingPlayer: pancho) equals: 0.
	self assert: (game numberOfCardsAffectingPlayer: juan) equals: 0.
	self assertCurrentPositionOf: juan in: game equals: 4.
	self assertCurrentPositionOf: pancho in: game equals: 10.
	self play: 2 turnsIn: game.
	self assertCurrentPositionOf: juan in: game equals: 9.
	self assertCurrentPositionOf: pancho in: game equals: 2
]

{ #category : #tests }
GameTest >> testRedoRepeatsTheEffectOfLastCardPlayedThisOneBeingARepeat [
	| game players |
	players := OrderedCollection with: juan with: pancho.
	aBoard := Board
		ofASlotDistribution:
			{NoEffect createSlot.
			NoEffect createSlot.
			SpeedUp createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			SpeedUp createSlot}.
	game := Game
		playedBy: players
		thatUse: aDice
		on: aBoard
		for: numberOfRoundsToBePlayed
		withASetOf: cards.
	game giveCard: Redo createCard toPlayer: juan.
	game giveCard: Repeat createCard toPlayer: pancho.
	game playTurn.
	game player: pancho playsTheCard: Repeat onTarget: pancho.
	self assert: (game numberOfCardsAffectingPlayer: pancho) equals: 0.
	self assert: (game numberOfCardsAffectingPlayer: juan) equals: 0.
	self assertCurrentPositionOf: juan in: game equals: 7.
	self assertCurrentPositionOf: pancho in: game equals: 5.
	game player: juan playsTheCard: Redo onTarget: juan.
	self assertCurrentPositionOf: juan in: game equals: 1.
	self assertCurrentPositionOf: pancho in: game equals: 5.
	game playTurn.
	self assert: (game numberOfCardsAffectingPlayer: pancho) equals: 0.
	self assert: (game numberOfCardsAffectingPlayer: juan) equals: 0.
	self assertCurrentPositionOf: juan in: game equals: 1.
	self assertCurrentPositionOf: pancho in: game equals: 4
]

{ #category : #tests }
GameTest >> testRedoRepeatsTheEffectOfLastCardPlayedThisOneBeingASpeed [
	| game players |
	players := OrderedCollection with: juan with: pancho.
	aBoard := Board
		ofASlotDistribution:
			{NoEffect createSlot.
			NoEffect createSlot.
			CardGiver createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot}.
	game := Game
		playedBy: players
		thatUse: aDice
		on: aBoard
		for: numberOfRoundsToBePlayed
		withASetOf: cards.
	game giveCard: Redo createCard toPlayer: juan.
	game giveCard: Speed createCard toPlayer: pancho.
	game playTurn.
	game player: pancho playsTheCard: Speed onTarget: pancho.
	game player: juan playsTheCard: Redo onTarget: juan.
	game playTurn.
	self assert: (game numberOfCardsAffectingPlayer: pancho) equals: 1.
	self assert: (game numberOfCardsAffectingPlayer: juan) equals: 1.
	self assertCurrentPositionOf: juan in: game equals: 3.
	self assertCurrentPositionOf: pancho in: game equals: 1.
	self play: 2 turnsIn: game.
	self assertCurrentPositionOf: juan in: game equals: 9.
	self assertCurrentPositionOf: pancho in: game equals: 4
]

{ #category : #tests }
GameTest >> testRedoRepeatsTheEffectOfLastCardPlayedThisOneBeingAnAcceleration [
	| game players |
	players := OrderedCollection with: juan with: pancho.
	aBoard := Board
		ofASlotDistribution:
			{NoEffect createSlot.
			NoEffect createSlot.
			CardGiver createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot}.
	game := Game
		playedBy: players
		thatUse: aDice
		on: aBoard
		for: numberOfRoundsToBePlayed
		withASetOf: cards.
	game giveCard: Redo createCard toPlayer: juan.
	game giveCard: Acceleration createCard toPlayer: pancho.
	game playTurn.
	game
		player: pancho
		playsTheCard: Acceleration
		onTarget: players.
	game player: juan playsTheCard: Redo onTarget: players.
	game playTurn.
	self assert: (game numberOfCardsAffectingPlayer: pancho) equals: 2.
	self assert: (game numberOfCardsAffectingPlayer: juan) equals: 2.
	self assertCurrentPositionOf: juan in: game equals: 3.
	self assertCurrentPositionOf: pancho in: game equals: 2.
	self play: 2 turnsIn: game.
	self assertCurrentPositionOf: juan in: game equals: 10.
	self assertCurrentPositionOf: pancho in: game equals: 6
]

{ #category : #tests }
GameTest >> testRedoRepeatsTheEffectOfLastCardPlayedThisOneBeingAnOverload [
	| game players |
	players := OrderedCollection with: juan with: pancho.
	aBoard := Board
		ofASlotDistribution:
			{NoEffect createSlot.
			NoEffect createSlot.
			CardGiver createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot}.
	game := Game
		playedBy: players
		thatUse: aDice
		on: aBoard
		for: numberOfRoundsToBePlayed
		withASetOf: cards.
	game giveCard: Redo createCard toPlayer: juan.
	game giveCard: Overload createCard toPlayer: pancho.
	game playTurn.
	game player: pancho playsTheCard: Overload onTarget: juan.
	game player: juan playsTheCard: Redo onTarget: pancho.
	game playTurn.
	self assert: (game numberOfCardsAffectingPlayer: pancho) equals: 1.
	self assert: (game numberOfCardsAffectingPlayer: juan) equals: 1.
	self assertCurrentPositionOf: juan in: game equals: 3.
	self assertCurrentPositionOf: pancho in: game equals: 8.
	self play: 2 turnsIn: game.
	self assertCurrentPositionOf: juan in: game equals: 6.
	self assertCurrentPositionOf: pancho in: game equals: 8
]

{ #category : #tests }
GameTest >> testRepeatCantBeUsedIfTheGameHasntStarted [
	| game players |
	players := OrderedCollection with: juan with: pancho.
	aBoard := Board
		ofASlotDistribution:
			{NoEffect createSlot.
			NoEffect createSlot.
			SpeedUp createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot}.
	game := Game
		playedBy: players
		thatUse: aDice
		on: aBoard
		for: numberOfRoundsToBePlayed
		withASetOf: cards.
	game giveCard: Repeat createCard toPlayer: pancho.
	self should: [game player: pancho playsTheCard: Repeat onTarget: pancho] raise: Error withMessageText: 'At least one turn must be played before using Repeat card.'.
]

{ #category : #tests }
GameTest >> testRepeatRepeatsTheEffectOfTheLastSlotOfAPlayer [
	| game players |
	players := OrderedCollection with: juan with: pancho.
	aBoard := Board
		ofASlotDistribution:
			{NoEffect createSlot.
			NoEffect createSlot.
			SpeedUp createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot}.
	game := Game
		playedBy: players
		thatUse: aDice
		on: aBoard
		for: numberOfRoundsToBePlayed
		withASetOf: cards.
	game giveCard: Repeat createCard toPlayer: pancho.
	game playTurn.	"mueve juan"
	game player: pancho playsTheCard: Repeat onTarget: pancho.
	self assert: (game numberOfCardsAffectingPlayer: pancho) equals: 0.
	self assertCurrentPositionOf: pancho in: game equals: 5.
	self assertCurrentPositionOf: juan in: game equals: 7
]

{ #category : #tests }
GameTest >> testRepeatRepeatsTheEffectOfTheLastSlotOfAPlayerThisOneBeingAtomicBomb [
	| game players |
	players := OrderedCollection with: juan with: pancho.
	aBoard := Board
		ofASlotDistribution:
			{NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			AtomicBomb createSlot}.
	game := Game
		playedBy: players
		thatUse: aDice
		on: aBoard
		for: numberOfRoundsToBePlayed
		withASetOf: cards.
	game giveCard: Repeat createCard toPlayer: pancho.
	game playTurn.
	self assertCurrentPositionOf: juan in: game equals: 3.
	self assertCurrentPositionOf: pancho in: game equals: 1.
	game playTurn.
	self assertCurrentPositionOf: juan in: game equals: 1.
	self assertCurrentPositionOf: pancho in: game equals: 1.
	game player: pancho playsTheCard: Repeat onTarget: pancho.
	self assertCurrentPositionOf: juan in: game equals: 1.
	self assertCurrentPositionOf: pancho in: game equals: 1
]

{ #category : #tests }
GameTest >> testRepeatRepeatsTheEffectOfTheLastSlotOfAPlayerThisOneBeingCardGiver [
	| game players |
	players := OrderedCollection with: juan with: pancho.
	aBoard := Board
		ofASlotDistribution:
			{NoEffect createSlot.
			NoEffect createSlot.
			CardGiver createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot}.
	game := Game
		playedBy: players
		thatUse: aDice
		on: aBoard
		for: numberOfRoundsToBePlayed
		withASetOf: cards.
	game giveCard: Repeat createCard toPlayer: pancho.
	game playTurn.
	game player: pancho playsTheCard: Repeat onTarget: pancho.
	self assert: (game amountOfCardsOf: juan) equals: 3.
	self assert: (game amountOfCardsOf: pancho) equals: 3.
	self assertCurrentPositionOf: juan in: game equals: 3.
	self assertCurrentPositionOf: pancho in: game equals: 1
]

{ #category : #tests }
GameTest >> testRepeatRepeatsTheEffectOfTheLastSlotOfAPlayerThisOneBeingMoonWalk [
	| game players |
	players := OrderedCollection with: juan with: pancho.
	aBoard := Board
		ofASlotDistribution:
			{NoEffect createSlot.
			NoEffect createSlot.
			MoonWalk createSlotWithN: 1.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot}.
	game := Game
		playedBy: players
		thatUse: aDice
		on: aBoard
		for: numberOfRoundsToBePlayed
		withASetOf: cards.
	game giveCard: Repeat createCard toPlayer: pancho.
	game playTurn.
	self assertCurrentPositionOf: juan in: game equals: 3.
	self assertCurrentPositionOf: pancho in: game equals: 1.
	game player: pancho playsTheCard: Repeat onTarget: pancho.
	game playTurn.
	self assertCurrentPositionOf: juan in: game equals: 2.
	self assertCurrentPositionOf: pancho in: game equals: 10.
]

{ #category : #tests }
GameTest >> testRepeatRepeatsTheEffectOfTheLastSlotOfAPlayerThisOneBeingNoEffect [
	| game players |
	players := OrderedCollection with: juan with: pancho.
	aBoard := Board
		ofASlotDistribution:
			{NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot}.
	game := Game
		playedBy: players
		thatUse: aDice
		on: aBoard
		for: numberOfRoundsToBePlayed
		withASetOf: cards.
	game giveCard: Repeat createCard toPlayer: pancho.
	game playTurn.
	game player: pancho playsTheCard: Repeat onTarget: pancho.
	self assert: (game numberOfCardsAffectingPlayer: pancho) equals: 0.
	self assertCurrentPositionOf: pancho in: game equals: 1.
	self assertCurrentPositionOf: juan in: game equals: 3
]

{ #category : #tests }
GameTest >> testRepeatRepeatsTheEffectOfTheLastSlotOfAPlayerThisOneBeingSpeedUp [
	| game players |
	players := OrderedCollection with: juan with: pancho.
	aBoard := Board
		ofASlotDistribution:
			{NoEffect createSlot.
			NoEffect createSlot.
			SpeedUp createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot}.
	game := Game
		playedBy: players
		thatUse: aDice
		on: aBoard
		for: numberOfRoundsToBePlayed
		withASetOf: cards.
	game giveCard: Repeat createCard toPlayer: pancho.
	game playTurn.
	game player: pancho playsTheCard: Repeat onTarget: pancho.
	self assert: (game numberOfCardsAffectingPlayer: pancho) equals: 0.
	self assertCurrentPositionOf: pancho in: game equals: 5.
	self assertCurrentPositionOf: juan in: game equals: 7
]

{ #category : #tests }
GameTest >> testRepeatRepeatsTheEffectOfTheLastSlotOfAPlayerThisOneBeingWormHole [
	| game players |
	players := OrderedCollection with: juan with: pancho.
	aBoard := Board
		ofASlotDistribution:
			{NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			WormHole createSlot.
			NoEffect createSlot.
			NoEffect createSlot}.
	game := Game
		playedBy: players
		thatUse: aDice
		on: aBoard
		for: numberOfRoundsToBePlayed
		withASetOf: cards.
	game giveCard: Repeat createCard toPlayer: pancho.
	game playTurn.
	game playTurn.
	game playTurn.
	game player: pancho playsTheCard: Repeat onTarget: pancho.
	self assert: (game numberOfCardsAffectingPlayer: pancho) equals: 0.
	self assertCurrentPositionOf: juan in: game equals: 4.
	self assertCurrentPositionOf: pancho in: game equals: 6
]

{ #category : #tests }
GameTest >> testSpeedCombinedWithAnSlotEffect [
	| game players |
	players := OrderedCollection with: juan with: pancho.
	aBoard := Board
		ofASlotDistribution:
			{NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			SpeedUp createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot}.
	game := Game
		playedBy: players
		thatUse: aDice
		on: aBoard
		for: numberOfRoundsToBePlayed
		withASetOf: cards.
	game giveCard: Speed createCard toPlayer: juan.
	game player: juan playsTheCard: Speed onTarget: juan.
	game playTurn.
	self assertCurrentPositionOf: juan in: game equals: 8.
]

{ #category : #tests }
GameTest >> testSpeedIncreasesTheTotalRollOfAPlayerByOneAndDoesntAffectTheOtherPlayers [
	| game players |
	players := OrderedCollection with: juan with: pancho.
	aBoard := Board
		ofASlotDistribution:
			{NoEffect createSlot.
			NoEffect createSlot.
			CardGiver createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot}.
	game := Game
		playedBy: players
		thatUse: aDice
		on: aBoard
		for: numberOfRoundsToBePlayed
		withASetOf: cards.
	game giveCard: Speed createCard toPlayer: juan.
	game player: juan playsTheCard: Speed onTarget: juan.
	self play: 2 turnsIn: game.
	self assertCurrentPositionOf: juan in: game equals: 4.
	self assertCurrentPositionOf: pancho in: game equals: 10.
]

{ #category : #tests }
GameTest >> testSpeedIsAccumulative [
	| game players |
	players := OrderedCollection with: juan with: pancho.
	aBoard := Board
		ofASlotDistribution:
			{NoEffect createSlot.
			NoEffect createSlot.
			CardGiver createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot}.
	game := Game
		playedBy: players
		thatUse: aDice
		on: aBoard
		for: numberOfRoundsToBePlayed
		withASetOf: cards.
	game giveCard: Speed createCard toPlayer: juan.
	game giveCard: Speed createCard toPlayer: juan.
	game giveCard: Speed createCard toPlayer: juan.
	game player: juan playsTheCard: Speed onTarget: juan.
	game player: juan playsTheCard: Speed onTarget: juan.
	game player: juan playsTheCard: Speed onTarget: juan.
	game playTurn.
	self assertCurrentPositionOf: juan in: game equals: 6.
]

{ #category : #tests }
GameTest >> testSpeedUpEffectChangesRoundsMadeAfterMakingOneLap [
	| game players |
	players := OrderedCollection with: juan with: pancho.
	aBoard := Board
		ofASlotDistribution:
			{NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			SpeedUp createSlot}.
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
		ofASlotDistribution:
			{NoEffect createSlot.
			NoEffect createSlot.
			SpeedUp createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			SpeedUp createSlot.
			NoEffect createSlot}.
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
GameTest >> testValidationOfTheTargetThatTheCardsReceive [
	| game players |
	players := OrderedCollection with: juan with: pancho.
	aBoard := Board
		ofASlotDistribution:
			{NoEffect createSlot.
			NoEffect createSlot.
			CardGiver createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot}.
	game := Game
		playedBy: players
		thatUse: aDice
		on: aBoard
		for: numberOfRoundsToBePlayed
		withASetOf: cards.
	game giveCard: Acceleration createCard toPlayer: juan.
	game giveCard: Speed createCard toPlayer: pancho.
	game giveCard: Overload createCard toPlayer: juan.
	game giveCard: Cancellation createCard toPlayer: pancho.
	game giveCard: Repeat createCard toPlayer: juan.
	self
		should: [ game
				player: juan
				playsTheCard: Acceleration
				onTarget: Overload ]
		raise: Error
		withMessageText:
			'The card Acccelation must receive a collection with all the players as a target'.
	game playTurn.
	self
		should:
			[ game player: pancho playsTheCard: Speed onTarget: Overload ]
		raise: Error
		withMessageText: 'The card Speed must receive a player as a target'.
	game playTurn.
	self
		should: [ game player: juan playsTheCard: Overload onTarget: Redo ]
		raise: Error
		withMessageText: 'The card Overload must receive a player as a target'.
	game playTurn.
	self
		should:
			[ game player: pancho playsTheCard: Cancellation onTarget: juan ]
		raise: Error
		withMessageText: 'The card Cancellation must receive a collection with a Card and a player as a target'.
	game playTurn.
	self
		should: [ game player: juan playsTheCard: Repeat onTarget: Overload ]
		raise: Error
		withMessageText:
			'The card Repeat must receive a player as a target'
]

{ #category : #tests }
GameTest >> testWormHoleEffectChangesRoundsMadeIfNecessary [
	| game players |
	players := OrderedCollection with: juan with: pancho.
	aBoard := Board
		ofASlotDistribution:
			{NoEffect createSlot.
			WormHole createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot}.
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
		ofASlotDistribution:
			{NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			NoEffect createSlot.
			WormHole createSlot}.
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
