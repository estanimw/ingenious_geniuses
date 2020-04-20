"
This class models a game.
"
Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'board',
		'players',
		'winner'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Game class >> playedBy: players on: aBoard [
	^ (self new) initializeWith: players and: aBoard.
]

{ #category : #accessing }
Game >> board [
	^ board
]

{ #category : #'turn managing' }
Game >> chooseNextTurn [
	players next.
]

{ #category : #'player information' }
Game >> currentPlayer [
	^players current.
]

{ #category : #'player information' }
Game >> currentPlayerIsWinner [
	^(self currentPlayer) isWinner.
]

{ #category : #'player information' }
Game >> currentPlayerPosition [
	^(self currentPlayer) currentPosition.
]

{ #category : #'game status' }
Game >> hasWinner [
	(self currentPlayerIsWinner) ifTrue: [ winner := (self currentPlayer)].
	^(self currentPlayerIsWinner).
]

{ #category : #initialization }
Game >> initializeWith: allThePlayers and: aBoard [ 
	board := aBoard.
	players := allThePlayers.
	winner := 0.
]

{ #category : #'turn managing' }
Game >> playTurn [
	self currentPlayer throwDice.
]

{ #category : #accessing }
Game >> players [
	^ players
]

{ #category : #accessing }
Game >> winner [
	(winner isMemberOf: Player) ifTrue: [ ^winner ] ifFalse: [ ^'error' ].
]
