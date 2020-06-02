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
		ifFalse: [ Error signal: 'The die are invalid' ]
]

{ #category : #playing }
Game >> applyEffectOfTheSlotAtThePositionOfCurrentPlayer [
	board applyEffectOfTheSlotAtThePositionOfCurrentPlayerFrom: self.
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
	^ leaderBoard
		thePlayer: self currentPlayer
		isWinnerForMaking: roundsForTheGameToBeOver
]

{ #category : #initialization }
Game >> initializeWith: allThePlayers with: aDice and: aBoard until: aNumberOfRounds [
	board := aBoard.
	players := allThePlayers.
	dice := aDice.
	turnsIterator := CircularIterator cyclingOver: allThePlayers.
	roundsForTheGameToBeOver := aNumberOfRounds.
	leaderBoard := LeaderBoard with: players
]

{ #category : #playing }
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
	self throwDiceOf: self currentPlayer.
	self applyEffectOfTheSlotAtThePositionOfCurrentPlayer.
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

{ #category : #playing }
Game >> throwDiceOf: player [
	| slotsQuantityToMove |
	slotsQuantityToMove := dice roll.
	self move: player ANumberOfSlotsEqualTo: slotsQuantityToMove.
]

{ #category : #accessing }
Game >> winner [
	^ leaderBoard winner.
]
