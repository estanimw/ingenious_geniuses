"
The Object that stores the information associated to winnersBoard, positionsBoard, roundsMadeBoard and has the duty to fill and update them.
"
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
LeaderBoard >> assignRankingPositionAccordingTo: numberOfSlotsPassedByAllThePlayers [
	| playerAtAGivenPosition meter |
	meter := 1.
	numberOfSlotsPassedByAllThePlayers
		reverseDo: [ :posc | 
			playerAtAGivenPosition := self findThePlayerWithPosition: posc.
			self update: winnersBoard at: playerAtAGivenPosition with: meter.
			meter := meter + 1 
			]
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
	self fillWinnersBoardWith: allThePlayers forThis: board
]

{ #category : #update }
LeaderBoard >> fillPositionsBoardWith: allThePlayers [
	allThePlayers do: [ :player | self update: positionsBoard at: player with: player currentPosition ]
]

{ #category : #update }
LeaderBoard >> fillRoundsMadeBoardWith: allThePlayers [
	allThePlayers do: [ :player | self update: roundsMadeBoard at: player with: player numberOfRoundsMade ]
]

{ #category : #update }
LeaderBoard >> fillWinnersBoardWith: allThePlayers forThis: board [
	| slotsPassedByAllThePlayersOrdered |
	self numberOfSlotsPassedBy: allThePlayers onThis: board.
	slotsPassedByAllThePlayersOrdered := self numberOfSlotsPassedByThePlayersInOrder.
	self assignRankingPositionAccordingTo: slotsPassedByAllThePlayersOrdered.
]

{ #category : #update }
LeaderBoard >> findThePlayerWithPosition: aPosition [
	 ^winnersBoard keyAtValue: aPosition.
]

{ #category : #initialization }
LeaderBoard >> initializeWith: allThePlayers forThis: board [.
	winnersBoard := Dictionary new.
	positionsBoard := Dictionary new.
	roundsMadeBoard := Dictionary new.
	self fillBoardsWith: allThePlayers forThis: board
]

{ #category : #update }
LeaderBoard >> numberOfSlotsPassedBy: allThePlayers onThis: board [
	allThePlayers
		do: [ :each | self update: winnersBoard at: each with: (roundsMadeBoard at: each) * board].
	allThePlayers
		do: [ :each | self update: winnersBoard at: each with: (winnersBoard at: each) + (positionsBoard at: each)]
]

{ #category : #update }
LeaderBoard >> numberOfSlotsPassedByThePlayersInOrder [
	^(winnersBoard values) sort.
]

{ #category : #quering }
LeaderBoard >> positionOf: aPlayer [ 
	^ positionsBoard at: aPlayer.
]

{ #category : #accessing }
LeaderBoard >> positionsBoard [
	^ positionsBoard
]

{ #category : #query }
LeaderBoard >> rankingOf: aPlayer [ 
	^winnersBoard at: aPlayer.
]

{ #category : #accessing }
LeaderBoard >> roundsMadeBoard [
	^ roundsMadeBoard
]

{ #category : #query }
LeaderBoard >> roundsMadeBy: aPlayer [ 
	^roundsMadeBoard at: aPlayer.
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
