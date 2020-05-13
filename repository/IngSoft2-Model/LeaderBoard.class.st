Class {
	#name : #LeaderBoard,
	#superclass : #Object,
	#instVars : [
		'winnersBoard',
		'positionsBoard',
		'roundsMadeBoard'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
LeaderBoard class >> creationWith: allThePlayers forThis: board [.
	^(self new) initializeWith: allThePlayers forThis: board.
]

{ #category : #update }
LeaderBoard >> fill: theBoardOfWhoIsWinning using: iterator and: totalNumberOfSlotsPassedByAllThePlayers and: numberOfPlayers [
	| aPlayer |
	aPlayer := theBoardOfWhoIsWinning keyAtValue: (totalNumberOfSlotsPassedByAllThePlayers at: numberOfPlayers - iterator + 1).
	self update: theBoardOfWhoIsWinning at: aPlayer with: iterator.
]

{ #category : #update }
LeaderBoard >> fillBoardsWith: allThePlayers forThis: board [
	self fillPositionsBoardWith: allThePlayers.
	self fillRoundsMadeBoardWith: allThePlayers.
	self fillWinnersBoardForThis: board
]

{ #category : #update }
LeaderBoard >> fillPositionsBoardWith: allThePlayers [
	(allThePlayers options) do: [ :player | self update: positionsBoard at: player with: player currentPosition ]
]

{ #category : #update }
LeaderBoard >> fillRoundsMadeBoardWith: allThePlayers [
	(allThePlayers options) do: [ :player | self update: roundsMadeBoard at: player with: player numberOfRoundsMade ]
]

{ #category : #update }
LeaderBoard >> fillTotalNumberOfSlotsPassedByFrom: allThePlayers into: theBoardOfWhoIsWinning forThis: board [
	allThePlayers
		do: [ :each | self update: theBoardOfWhoIsWinning at: each with: (roundsMadeBoard at: each) * board].
	allThePlayers
		do: [ :each | self update: theBoardOfWhoIsWinning at: each with: (theBoardOfWhoIsWinning at: each) + (positionsBoard at: each)]
]

{ #category : #update }
LeaderBoard >> fillWinnersBoardForThis: board [
	| allThePlayers totalNumberOfSlotsPassedByAllThePlayers numberOfPlayers iterator |
	allThePlayers := positionsBoard keys.	"the keys of the dictionary boardOfPositions are all the players of the game"
	self fillTotalNumberOfSlotsPassedByFrom: allThePlayers into: winnersBoard forThis: board.
	totalNumberOfSlotsPassedByAllThePlayers := winnersBoard values.
	numberOfPlayers := winnersBoard size.
	self sortArray: totalNumberOfSlotsPassedByAllThePlayers.
	iterator := 1.
	[ iterator <= numberOfPlayers ]
		whileTrue: [ 
			self fill: winnersBoard using: iterator and: totalNumberOfSlotsPassedByAllThePlayers and: numberOfPlayers.
			iterator := iterator + 1 
		].
	^ winnersBoard
]

{ #category : #initialization }
LeaderBoard >> initializeWith: allThePlayers forThis: board [.
	winnersBoard := Dictionary new.
	positionsBoard := Dictionary new.
	roundsMadeBoard := Dictionary new.
	self fillBoardsWith: allThePlayers forThis: board
]

{ #category : #accessing }
LeaderBoard >> positionsBoard [
	^ positionsBoard
]

{ #category : #accessing }
LeaderBoard >> roundsMadeBoard [
	^ roundsMadeBoard
]

{ #category : #sorting }
LeaderBoard >> sortArray: anArray [
	anArray sort.
	
]

{ #category : #update }
LeaderBoard >> update: aBoard at: anIndex with: aValue [
    aBoard at: anIndex put: aValue.
]

{ #category : #accessing }
LeaderBoard >> winnersBoard [
	^ winnersBoard
]
