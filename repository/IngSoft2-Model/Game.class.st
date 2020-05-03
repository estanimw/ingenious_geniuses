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
		'boardOfPositions',
		'boardOfRoundsMade'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Game class >> playedBy: players on: aBoard until: xRounds [
	^ (self new) initializeWith: players and: aBoard until: xRounds.
]

{ #category : #'as yet unclassified' }
Game >> allTheDieHaveBeenCheckedUsing: index and: numberOfDie [
	^index <= numberOfDie
]

{ #category : #accessing }
Game >> board [
	^ board
]

{ #category : #'as yet unclassified' }
Game >> boardOfPositions [
	^boardOfPositions.
]

{ #category : #accessing }
Game >> boardOfRoundsMade [
	^boardOfRoundsMade
]

{ #category : #'turn managing' }
Game >> chooseNextPlayer [
	players next.
]

{ #category : #'as yet unclassified' }
Game >> completeInitializationIfAllPlayersAreValidatedUsing: aBoard and: allThePlayers and: return and: xRounds [
(return)	
		ifTrue: [ 
				board := aBoard.
				players := allThePlayers.
				winner := 0.
				roundsForTheGameToBeOver := xRounds.
				self initializeBoardOfPositionsUsing: allThePlayers.
				self initializeBoardOfRoundsMadeUsing: allThePlayers.
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

{ #category : #accesing }
Game >> currentPlayerNumberOfRoundsMade [
	^self currentPlayer numberOfRoundsMade
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

{ #category : #'as yet unclassified' }
Game >> initializeBoardOfPositionsUsing: allThePlayers [
	| aPlayer |
	boardOfPositions := Dictionary new.
	aPlayer := allThePlayers current.
	boardOfPositions at: aPlayer put: aPlayer currentPosition.
	allThePlayers next.
	[ (allThePlayers currentIndex ~= 0) ]
		whileTrue: [ 
			aPlayer := allThePlayers current.
			boardOfPositions at: aPlayer put: aPlayer currentPosition.
			allThePlayers next.
		].
]

{ #category : #initialization }
Game >> initializeBoardOfRoundsMadeUsing: allThePlayers [
	| aPlayer |
	boardOfRoundsMade := Dictionary new.
	aPlayer := allThePlayers current.
	boardOfRoundsMade at: aPlayer put: aPlayer numberOfRoundsMade.
	allThePlayers next.
	[ (allThePlayers currentIndex ~= 0) ]
		whileTrue: [ 
			aPlayer := allThePlayers current.
			boardOfRoundsMade at: aPlayer put: aPlayer numberOfRoundsMade.
			allThePlayers next.
		].
]

{ #category : #initialization }
Game >> initializeWith: allThePlayers and: aBoard until: xRounds [
	| return |
	return := self validateDiceOfAllPlayers: allThePlayers using: aBoard.
	self completeInitializationIfAllPlayersAreValidatedUsing: aBoard and: allThePlayers and: return and: xRounds.
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
	| previousNumberOfRoundsMade currentNumberOfRoundsMade |
	previousNumberOfRoundsMade := self currentPlayerNumberOfRoundsMade.
	self currentPlayer throwDiceOn: self board until: self roundsForTheGameToBeOver.
	boardOfPositions at: (self currentPlayer) put: (self currentPlayerPosition).
	currentNumberOfRoundsMade := self currentPlayerNumberOfRoundsMade.
	(previousNumberOfRoundsMade ~= currentNumberOfRoundsMade) ifTrue: [ boardOfRoundsMade at: (self currentPlayer) put: (self currentPlayerNumberOfRoundsMade) ]
]

{ #category : #accessing }
Game >> players [
	^ players
]

{ #category : #accessing }
Game >> roundsForTheGameToBeOver [
	^roundsForTheGameToBeOver.
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
