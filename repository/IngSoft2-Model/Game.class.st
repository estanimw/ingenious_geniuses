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
		'boardOfRoundsMade',
		'boardOfWhoIsWinning'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Game class >> playedBy: players on: aBoard until: aNumberOfRounds [
	^ (self new) initializeWith: players and: aBoard until: aNumberOfRounds.
]

{ #category : #'argument validation' }
Game >> allTheDieHaveBeenCheckedUsing: index and: numberOfDie [
	^index <= numberOfDie
]

{ #category : #accessing }
Game >> board [
	^ board
]

{ #category : #accessing }
Game >> boardOfPositions [
	^boardOfPositions.
]

{ #category : #accessing }
Game >> boardOfRoundsMade [
	^boardOfRoundsMade
]

{ #category : #accessing }
Game >> boardOfWhoIsWinning [
	^ boardOfWhoIsWinning
]

{ #category : #'turn managing' }
Game >> chooseNextPlayer [
	players next.
]

{ #category : #initialization }
Game >> completeInitializationIfAllPlayersAreValidatedUsing: aBoard and: allThePlayers and: aCondition and: aNumberOfRounds [
	aCondition
		ifTrue: [ board := aBoard.
			players := allThePlayers.
			winner := 0.
			roundsForTheGameToBeOver := aNumberOfRounds.
			self initializeBoardOfPositionsUsing: allThePlayers.
			self initializeBoardOfRoundsMadeUsing: allThePlayers.
			self initializeBoardOfWhoIsWinning.
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

{ #category : #accessing }
Game >> currentPlayerNumberOfRoundsMade [
	^self currentPlayer numberOfRoundsMade
]

{ #category : #'player information' }
Game >> currentPlayerPosition [
	^(self currentPlayer) currentPosition.
]

{ #category : #update }
Game >> fill: theBoardOfWhoIsWinning using: iterator and: totalNumberOfSlotsPassedByAllThePlayers and: numberOfPlayers [
	| aPlayer |
	aPlayer := theBoardOfWhoIsWinning keyAtValue: (totalNumberOfSlotsPassedByAllThePlayers at: numberOfPlayers - iterator + 1).
	self update: theBoardOfWhoIsWinning at: aPlayer  with: iterator.
]

{ #category : #accessing }
Game >> fillBoardOfWhoIsWinning [
	| allThePlayers totalNumberOfSlotsPassedByAllThePlayers numberOfPlayers iterator |
	allThePlayers := boardOfPositions keys.
	self fillTotalNumberOfSlotsPassedFrom: allThePlayers into: boardOfWhoIsWinning.
	totalNumberOfSlotsPassedByAllThePlayers := boardOfWhoIsWinning values.
	numberOfPlayers := boardOfWhoIsWinning size.
	self sortArray: totalNumberOfSlotsPassedByAllThePlayers.
	iterator := 1.
	[ self thereArePlayersLeftToBeCheckedUsing: iterator and: numberOfPlayers ]
		whileTrue: [
			self fill: boardOfWhoIsWinning using: iterator and: totalNumberOfSlotsPassedByAllThePlayers and: numberOfPlayers.
			iterator := iterator + 1
		].
	^ boardOfWhoIsWinning.
]

{ #category : #update }
Game >> fillPositionOfAPlayerInTheBoardOfPositionsFrom: allThePlayers [
	| aPlayer |
	aPlayer := allThePlayers current.
	self update: boardOfPositions at: aPlayer  with: (aPlayer currentPosition).
	allThePlayers next.
]

{ #category : #initialization }
Game >> fillRoundsMadeOfAPlayerInTheBoardOfRoundsMadeFrom: allThePlayers [
	| aPlayer |
	aPlayer := allThePlayers current.
	self update: boardOfRoundsMade at: aPlayer  with: aPlayer numberOfRoundsMade.
	allThePlayers next.
]

{ #category : #update }
Game >> fillTotalNumberOfSlotsPassedFrom: allThePlayers into: theBoardOfWhoIsWinning [
	allThePlayers
		do: [ :each | 
			self update: theBoardOfWhoIsWinning at: each  with: (boardOfRoundsMade at: each) * board
		].
	allThePlayers
		do: [ :each | 
			self update: theBoardOfWhoIsWinning at: each with: ((theBoardOfWhoIsWinning at: each) + (boardOfPositions at: each))
		].
]

{ #category : #'game status' }
Game >> hasWinner [
	(self currentPlayerIsWinner) ifTrue: [ winner := (self currentPlayer)].
	^(self currentPlayerIsWinner).
]

{ #category : #initialization }
Game >> initializeBoardOfPositionsUsing: allThePlayers [
	boardOfPositions := Dictionary new.
	self fillPositionOfAPlayerInTheBoardOfPositionsFrom: allThePlayers.
	[ allThePlayers currentIndex ~= 0 ]
		whileTrue: [ self fillPositionOfAPlayerInTheBoardOfPositionsFrom: allThePlayers. ]
]

{ #category : #initialization }
Game >> initializeBoardOfRoundsMadeUsing: allThePlayers [
	boardOfRoundsMade := Dictionary new.
	self fillRoundsMadeOfAPlayerInTheBoardOfRoundsMadeFrom: allThePlayers.
	[ allThePlayers currentIndex ~= 0 ]
		whileTrue: [ self fillRoundsMadeOfAPlayerInTheBoardOfRoundsMadeFrom: allThePlayers. ]
]

{ #category : #initialization }
Game >> initializeBoardOfWhoIsWinning [
	boardOfWhoIsWinning := Dictionary new.
	self fillBoardOfWhoIsWinning.
	
]

{ #category : #initialization }
Game >> initializeWith: allThePlayers and: aBoard until: aNumberOfRounds [
	| aCondition |
	aCondition := self validateDiceOfAllPlayers: allThePlayers using: aBoard.
	self completeInitializationIfAllPlayersAreValidatedUsing: aBoard and: allThePlayers and: aCondition and: aNumberOfRounds.
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
	self update: boardOfPositions at: (self currentPlayer)  with: (self currentPlayerPosition).
	currentNumberOfRoundsMade := self currentPlayerNumberOfRoundsMade.
	(previousNumberOfRoundsMade ~= currentNumberOfRoundsMade) ifTrue: [ self update: boardOfRoundsMade at: (self currentPlayer)  with: (self currentPlayerNumberOfRoundsMade) ].
]

{ #category : #accessing }
Game >> players [
	^ players
]

{ #category : #accessing }
Game >> roundsForTheGameToBeOver [
	^roundsForTheGameToBeOver.
]

{ #category : #sorting }
Game >> sortArray: anArray [
	anArray sort.
]

{ #category : #'argument validation' }
Game >> thereArePlayersLeftToBeCheckedUsing: iterator and: numberOfPlayers [
	^ iterator <= numberOfPlayers.
]

{ #category : #update }
Game >> update: aBoard at: anIndex with: aValue [
	aBoard at: anIndex put: aValue.
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
