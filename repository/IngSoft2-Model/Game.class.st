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
Game >> chooseNextPlayer [
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
	| auxPlayer aux return |
	return := true.
	auxPlayer := allThePlayers current.
	"aux := allThePlayers currentIndex."
	
	(self validateDice: auxPlayer)
				ifTrue: (allThePlayers next)
				ifFalse: [return := false. Error signal: 'Error con los dados'.].
	
	[ (allThePlayers currentIndex ~= 0) & (return == true)]
		whileTrue: [
			(self validateDice: auxPlayer)
				ifTrue: (allThePlayers next)
				ifFalse: [return := false. Error signal: 'Error con los dados'.].
			].
		
	return 
		ifTrue: [
			board := aBoard.
			players := allThePlayers.
			winner := 0.]
]

{ #category : #playing }
Game >> play [
	[self hasWinner]
		whileFalse: [ 
			self playTurn.
			(self hasWinner) ifFalse: [ self chooseNextPlayer. ]
		]
]

{ #category : #'turn managing' }
Game >> playTurn [
	self currentPlayer throwDiceOn: (self board).
]

{ #category : #accessing }
Game >> players [
	^ players
]

{ #category : #'as yet unclassified' }
Game >> validateDice: aPlayer [
	| index return aDice aux |
	aDice := aPlayer dice.
	return := true.
	index := 1.
	aux := aDice dice at: 1.
	[ index <= aDice dice size & (return ~= false) ]
		whileTrue: [ | aux2 |
			aux2 := (aDice dice at: index) sides.
			
			((aux2 >= 4) & (aux2<=10))
				ifTrue: [ index := index + 1 ]
				ifFalse: [ return := false ]
		].
	^ return
]

{ #category : #accessing }
Game >> winner [
	(self hasWinner) ifTrue: [ ^winner ] ifFalse: [ TheresNoWinnerYet signal: 'No winner yet.' ].
]
