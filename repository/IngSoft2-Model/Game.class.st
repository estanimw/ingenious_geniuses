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

{ #category : #'instance creation' }
Game class >> playedBy: players on: aBoard until: aNumberOfRounds [
	self validateDiceOfAll: players forThis: aBoard.
	^(self new) initializeWith: players and: aBoard until: aNumberOfRounds
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
	(aDice dice) do: [ :die | self validateOne: die OfAPlayerForThis: board. ]
]

{ #category : #validation }
Game class >> validateOne: die OfAPlayerForThis: board [
	| sidesOfTheDie condition |
	sidesOfTheDie := die sides.
	condition := sidesOfTheDie between: 4 and: (board * (1/3)).
	(condition)
		ifFalse: [ ThePlayerHasAnInvalidDie signal: 'The die are invalid' ] 
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
	leaderBoard := LeaderBoard with: players forThis: board.
]

{ #category : #'player information' }
Game >> numberOfRoundsMadeBy: aPlayer [
	^leaderBoard roundsMadeBy: aPlayer.
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
	self updateBoardsChangesFor: player.
	
	self hasWinner
		ifFalse: [ self chooseNextPlayer ]
]

{ #category : #'player information' }
Game >> positionOf: aPlayer [
	^leaderBoard positionOf: aPlayer.
]

{ #category : #'player information' }
Game >> rankingOf: aPlayer [
	^leaderBoard rankingOf: aPlayer.
]

{ #category : #updating }
Game >> updateBoardsChangesFor: player [
	leaderBoard updateBlockOfThis: player forThis: board.
	leaderBoard updateOrderOfBlocks
]

{ #category : #accessing }
Game >> winner [
	(self hasWinner) ifTrue: [ ^winner ] ifFalse: [ TheresNoWinnerYet signal: 'No winner yet.' ].
]
