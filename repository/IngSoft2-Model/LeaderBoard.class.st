"
The Object that stores the information associated to winnersBoard, positionsBoard, roundsMadeBoard and has the duty to fill and update them.
"
Class {
	#name : #LeaderBoard,
	#superclass : #Object,
	#instVars : [
		'blocksOfPlayers'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
LeaderBoard class >> with: allThePlayers forThis: board [
	^ self new initializeWith: allThePlayers forThis: board
]

{ #category : #query }
LeaderBoard >> checkIfPlayerIn: aBlock is: aPlayer [
	^ aBlock playerId == aPlayer id.
]

{ #category : #initialization }
LeaderBoard >> createBlockForA: player [
	| leaderBoardBlock |
	leaderBoardBlock := LeaderBoardBlock forA: player.
	blocksOfPlayers add: leaderBoardBlock.
]

{ #category : #initialization }
LeaderBoard >> fillBlockOfEachPlayerFor: allThePlayers [
	allThePlayers do: [ :player | self createBlockForA: player ]
]

{ #category : #initialization }
LeaderBoard >> initializeWith: allThePlayers forThis: board [.
	blocksOfPlayers := OrderedCollection new.
	self fillBlockOfEachPlayerFor: allThePlayers.
	
]

{ #category : #query }
LeaderBoard >> positionOf: aPlayer [
	blocksOfPlayers
		do: [ :block | 
			(self checkIfPlayerIn: block is: aPlayer)
				ifTrue: [ ^ block playerPosition ] ]
]

{ #category : #query }
LeaderBoard >> rankingOf: aPlayer [
	| positionInTheRanking |
	positionInTheRanking := 1.
	blocksOfPlayers
		do: [ :block | 
			(self checkIfPlayerIn: block is: aPlayer)
				ifTrue: [ ^ positionInTheRanking ].
			positionInTheRanking := positionInTheRanking + 1 ]
]

{ #category : #query }
LeaderBoard >> roundsMadeBy: aPlayer [
	blocksOfPlayers
		do: [ :block | 
			(self checkIfPlayerIn: block is: aPlayer)
				ifTrue: [ ^ block playerRoundsMade ] ]
]

{ #category : #update }
LeaderBoard >> updateBlockOfThis: player forThis: board [
	blocksOfPlayers
		do: [ :block | 
			(self checkIfPlayerIn: block is: player)
				ifTrue: [ block changePositionAndRoundsMadeBy: player forThis: board ] ]
]

{ #category : #update }
LeaderBoard >> updateOrderOfBlocks [
	blocksOfPlayers := (blocksOfPlayers sort) reversed.
]
