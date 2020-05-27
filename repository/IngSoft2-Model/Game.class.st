"
This object has the responsability of managing each turn and also delegates to other objects the updates of the LeaderBoard and apply the effects of the slots.
"
Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'players',
		'roundsForTheGameToBeOver',
		'leaderBoard',
		'turnsIterator',
		'board',
		'dice'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Game class >> playedBy: players thatUse: aDice on: aBoard for: aNumberOfRounds [
	"self validateDiceOfAll: players forThis: aBoard."
	^(self new) initializeWith: players with: aDice and: aBoard until: aNumberOfRounds
]

{ #category : #validation }
Game class >> validateDiceOfAll: players forThis: board [
	players
		do: [ :player | self validateDiceOfOne: player forThis: board ]
]

{ #category : #validation }
Game class >> validateDiceOfOne: player forThis: board [
	| aDice |
	aDice := player dice.
	aDice dice
		do: [ :die | self validateOne: die OfAPlayerForThis: board ]
]

{ #category : #validation }
Game class >> validateOne: die OfAPlayerForThis: board [
	| sidesOfTheDie condition |
	sidesOfTheDie := die sides.
	condition := sidesOfTheDie
		between: 4
		and: board numberOfSlots * (1 / 3).
	condition
		ifFalse: [ ThePlayerHasAnInvalidDie signal: 'The die are invalid' ]
]

{ #category : #playing }
Game >> applyEffectOfTheSlotAtThePositionOfCurrentPlayer [
	board applyEffectOfTheSlotAtThePositionOfCurrentPlayerFromThe: self.
]

{ #category : #'turn managing' }
Game >> chooseNextPlayer [
	turnsIterator next
]

{ #category : #'player information' }
Game >> currentPlayer [
	^ turnsIterator current
]

{ #category : #'game status' }
Game >> hasWinner [
	| isThereAWinner |
	isThereAWinner := (leaderBoard current: (self currentPlayer) isWinnerForDoing: roundsForTheGameToBeOver).
	^ isThereAWinner
]

{ #category : #initialization }
Game >> initializeWith: allThePlayers with: aDice and: aBoard until: aNumberOfRounds [
	board := aBoard.
	players := allThePlayers.
	dice := aDice.
	turnsIterator := CircularIterator cyclingOver: allThePlayers.
	roundsForTheGameToBeOver := aNumberOfRounds.
	leaderBoard := LeaderBoard with: players forThis: board numberOfSlots
]

{ #category : #'as yet unclassified' }
Game >> move: player ANumberOfSlotsEqualTo: slotsQuantity [
	leaderBoard updateRowOfThis: player inA: slotsQuantity forThis: board.
]

{ #category : #'player information' }
Game >> numberOfRoundsMadeBy: aPlayer [
	^ leaderBoard roundsMadeBy: aPlayer
]

{ #category : #playing }
Game >> play [
	[ self hasWinner ] whileFalse: [ self playTurn ]
]

{ #category : #'turn managing' }
Game >> playTurn [
	| player |
	player := self currentPlayer.
	"player throwDiceOn: board until: roundsForTheGameToBeOver."
	self throwDiceOf: player.
	self applyEffectOfTheSlotAtThePositionOfCurrentPlayer.
	"self updateBoardsOfAllPlayers."
	leaderBoard updateOrderOfRows.
	
	self hasWinner
		ifFalse: [ self chooseNextPlayer ]
]

{ #category : #accessing }
Game >> players [
	^ players
]

{ #category : #'player information' }
Game >> positionOf: aPlayer [
	^ leaderBoard positionOf: aPlayer
]

{ #category : #'player information' }
Game >> rankingOf: aPlayer [
	^ leaderBoard rankingOf: aPlayer
]

{ #category : #'as yet unclassified' }
Game >> throwDiceOf: player [
	| slotsQuantity |
	slotsQuantity := dice roll.
	self move: player ANumberOfSlotsEqualTo: slotsQuantity.
]

{ #category : #accessing }
Game >> winner [
	^ leaderBoard winner.
	"self hasWinner
		ifTrue: [ ^ winner ]
		ifFalse: [ TheresNoWinnerYet signal: 'No winner yet.' ]"
]
