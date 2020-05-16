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

{ #category : #accessing }
LeaderBoard class >> creationWith: allThePlayers forThis: board [.
	^(self new) initializeWith: allThePlayers forThis: board.
]

{ #category : #'as yet unclassified' }
LeaderBoard >> createBlockForA: player [
	| leaderBoardBlock |
	leaderBoardBlock := LeaderBoardBlock creationWithA: player.
	blocksOfPlayers add: leaderBoardBlock.
]

{ #category : #'as yet unclassified' }
LeaderBoard >> fillBlockOfEachPlayerFor: allThePlayers [
	allThePlayers do: [ :player | self createBlockForA: player ]
]

{ #category : #initialization }
LeaderBoard >> initializeWith: allThePlayers forThis: board [.
	blocksOfPlayers := OrderedCollection new.
	self fillBlockOfEachPlayerFor: allThePlayers.
	
]

{ #category : #quering }
LeaderBoard >> positionOf: aPlayer [ 
	blocksOfPlayers do: [ :block | (block playerId == aPlayer id) ifTrue: [ ^block playerPosition ] ]
]

{ #category : #query }
LeaderBoard >> rankingOf: aPlayer [ 
	| positionInTheRanking |
	positionInTheRanking := 1.
	blocksOfPlayers do: [ :block | (block playerId == aPlayer id) ifTrue: [ ^positionInTheRanking ]. positionInTheRanking := positionInTheRanking + 1 ]
]

{ #category : #query }
LeaderBoard >> roundsMadeBy: aPlayer [ 
	blocksOfPlayers do: [ :block | (block playerId == aPlayer id) ifTrue: [ ^block playerRoundsMade ] ]
]

{ #category : #'as yet unclassified' }
LeaderBoard >> updateBlockOfThis: player forThis: board [
	blocksOfPlayers do: [ :block | (block playerId == player id) ifTrue: [ 
			block changePositionAndRoundsMadeOf: player forThis: board.
		]
	].
]

{ #category : #'as yet unclassified' }
LeaderBoard >> updateOrderOfBlocks [
	blocksOfPlayers := (blocksOfPlayers sort) reversed.
]
