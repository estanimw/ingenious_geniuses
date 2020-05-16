"
This class models a game.
"
Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'board',
		'players',
		'winner',
		'roundsForTheGameToBeOver',
		'leaderBoard',
		'turnsIterator'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Game class >> playedBy: players on: aBoard until: aNumberOfRounds [
	self validateDiceOfAll: players forThis: aBoard.
	^(self new) initializeWith: players and: aBoard until: aNumberOfRounds
]

{ #category : #initialization }
Game class >> validateDiceOfAll: players forThis: board [
	players
		do: [ :player | self validateDiceOfOne: player forThis: board ]
]

{ #category : #initialization }
Game class >> validateDiceOfOne: player forThis: board [
	| aDice |
	aDice := player dice.
	(aDice dice) do: [ :die | self validateOne: die OfAPlayerForThis: board. ]
]

{ #category : #initialization }
Game class >> validateOne: die OfAPlayerForThis: board [
	| sidesOfTheDie condition |
	sidesOfTheDie := die sides.
	condition := sidesOfTheDie between: 4 and: (board * (1/3)).
	(condition)
		ifFalse: [ ThePlayerHasAnInvalidDie signal: 'The die are invalid' ] 
]

{ #category : #accessing }
Game >> board [
	^board
]

{ #category : #'turn managing' }
Game >> chooseNextPlayer [
	turnsIterator next.
]

{ #category : #'player information' }
Game >> currentPlayer [
	^turnsIterator current
]

{ #category : #'player information' }
Game >> currentPlayerIsWinner [
	^(self currentPlayer) isWinner
]

{ #category : #'player information' }
Game >> currentPlayerNumberOfRoundsMade [
	^(self currentPlayer) numberOfRoundsMade
]

{ #category : #'player information' }
Game >> currentPlayerPosition [
	^(self currentPlayer) currentPosition
]

{ #category : #'game status' }
Game >> hasWinner [
	(self currentPlayerIsWinner) ifTrue: [winner := (self currentPlayer)].
	^(self currentPlayerIsWinner).
]

{ #category : #initialization }
Game >> initializeWith: allThePlayers and: aBoard until: aNumberOfRounds [
	board := aBoard.
	players := allThePlayers.
	turnsIterator := CircularIterator cyclingOver: allThePlayers.
	winner := 0.
	roundsForTheGameToBeOver := aNumberOfRounds.
	leaderBoard := LeaderBoard creationWith: players forThis: board.
]

{ #category : #accessing }
Game >> leaderBoard [
	^ leaderBoard
]

{ #category : #playing }
Game >> play [
	[ self hasWinner ] whileFalse: [ self playTurn ]
]

{ #category : #'turn managing' }
Game >> playTurn [
	| player |
	player := self currentPlayer.
	player throwDiceOn: board until: roundsForTheGameToBeOver.
	leaderBoard updateBlockOfThis: player forThis: board.
	leaderBoard updateOrderOfBlocks.
	(self hasWinner) ifFalse:[
		self chooseNextPlayer.
	]
]

{ #category : #accessing }
Game >> players [
	^players
]

{ #category : #accessing }
Game >> roundsForTheGameToBeOver [
	^roundsForTheGameToBeOver
]

{ #category : #accessing }
Game >> winner [
	(self hasWinner) ifTrue: [ ^winner ] ifFalse: [ TheresNoWinnerYet signal: 'No winner yet.' ].
]
