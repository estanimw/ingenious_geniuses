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

{ #category : #'as yet unclassified' }
Game >> allTheDieHaveBeenCheckedUsing: index and: numberOfDie [
	^index <= numberOfDie
]

{ #category : #accessing }
Game >> board [
	^ board
]

{ #category : #'turn managing' }
Game >> chooseNextPlayer [
	players next.
]

{ #category : #'as yet unclassified' }
Game >> completeInitializationIfAllPlayersAreValidatedUsing: aBoard and: allThePlayers and: return [
(return)	
		ifTrue: [ 
				board := aBoard.
				players := allThePlayers.
				winner := 0 
			]
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
	| return |
	return := self validateDiceOfAllPlayers: allThePlayers using: aBoard.
	self completeInitializationIfAllPlayersAreValidatedUsing: aBoard and: allThePlayers and: return.
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

{ #category : #accessing }
Game >> validateDiceOf: aPlayer using: aBoard [
	| index allDieAreOk aDice aDie sidesOfTheDie numberOfDie condition |
	aDice := aPlayer dice.
	allDieAreOk := true.
	index := 1.
	numberOfDie := aDice dice size.
	[ (self allTheDieHaveBeenCheckedUsing: index and: numberOfDie) & allDieAreOk ]
		whileTrue: [ 
			aDie := aDice dice at: index.
			sidesOfTheDie := aDie sides.
			condition := sidesOfTheDie between: 4 and: (aBoard * (1/3)).
			(condition)
				ifTrue: [ index := index + 1 ]
				ifFalse: [ allDieAreOk := false ] 
		].
	^ allDieAreOk
]

{ #category : #initialization }
Game >> validateDiceOfAllPlayers: allThePlayers using: aBoard [
	| aPlayer allDiceAreOk |
	allDiceAreOk := true.
	aPlayer := allThePlayers current.
	(self validateDiceOf: aPlayer using: aBoard)
		ifTrue: allThePlayers next
		ifFalse: [ 
			allDiceAreOk := false.
			ThePlayerHasAnInvalidDie signal: 'The die are invalid' 
		].
	[ (allThePlayers currentIndex ~= 0) & allDiceAreOk ]
		whileTrue: [ 
			aPlayer := allThePlayers current.
			(self validateDiceOf: aPlayer using: aBoard)
				ifTrue: allThePlayers next
				ifFalse: [ 
					allDiceAreOk := false.
					ThePlayerHasAnInvalidDie signal: 'The die are invalid' ] 
				].
	^ allDiceAreOk
]

{ #category : #accessing }
Game >> winner [
	(self hasWinner) ifTrue: [ ^winner ] ifFalse: [ TheresNoWinnerYet signal: 'No winner yet.' ].
]
