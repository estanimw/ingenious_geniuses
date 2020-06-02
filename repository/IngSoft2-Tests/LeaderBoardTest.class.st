Class {
	#name : #LeaderBoardTest,
	#superclass : #TestCase,
	#instVars : [
		'juan',
		'pancho',
		'board',
		'players',
		'leaderBoard'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
LeaderBoardTest >> assertCurrentNumberOfRoundsMadeBy: aPlayer equals: numberOfRoundsMade [
	self
		assert: (leaderBoard roundsMadeBy: juan)
		equals: numberOfRoundsMade.
]

{ #category : #asserting }
LeaderBoardTest >> assertCurrentPositionOf: aPlayer equals: aFinalPosition [
	^self assert: (leaderBoard positionOf: aPlayer) equals: aFinalPosition
]

{ #category : #asserting }
LeaderBoardTest >> assertRankingOf: aPlayer equals: aRankPosition [
	self
		assert: (leaderBoard rankingOf: aPlayer)
		equals: aRankPosition.
]

{ #category : #asserting }
LeaderBoardTest >> assertRowOfPlayer: aPlayer nameOfThePlayerEquals: aString [
	leaderBoard withRowOf: aPlayer do: [ :aRow | ^aRow player ].
]

{ #category : #asserting }
LeaderBoardTest >> assertRowOfPlayer: aPlayer positionOfThePlayerEquals: aFinalPosition [
	leaderBoard withRowOf: aPlayer do: [ :aRow | ^aRow playerPosition ].
]

{ #category : #asserting }
LeaderBoardTest >> assertRowOfPlayer: aPlayer roundsMadeByThePlayerEquals: aNumberOfRounds [
	leaderBoard withRowOf: aPlayer do: [ :aRow | ^aRow playerRoundsMade ].
]

{ #category : #asserting }
LeaderBoardTest >> assertRowOfPlayer: aPlayer slotsPassedByThePlayerEquals: aNumberOfSlots [
	leaderBoard withRowOf: aPlayer do: [ :aRow | ^aRow slotsPassedByThePlayer ].
]

{ #category : #moving }
LeaderBoardTest >> player: aPlayer movesANumberOfSlotsEqualTo: aSlotQuantity [
	leaderBoard updateRowOfThis: aPlayer inA: aSlotQuantity forThis: board.
	leaderBoard updateOrderOfRows.
]

{ #category : #running }
LeaderBoardTest >> setUp [
	super setUp.
	board := Board of: { NoEffect new . NoEffect new . NoEffect new . NoEffect new . NoEffect new . NoEffect new}.
	juan := 'Juan'.
	pancho := 'Pancho'.
	players := OrderedCollection with: juan with: pancho.
	leaderBoard := LeaderBoard with: players.

]

{ #category : #tests }
LeaderBoardTest >> testBoardOfPositionsChangesAfterEveryMovement [
	
	self assertCurrentPositionOf: juan equals: 1.
	self assertCurrentPositionOf: pancho equals: 1.
	
	self player: juan movesANumberOfSlotsEqualTo: 3.
	self assertCurrentPositionOf: juan equals: 4.
	self assertCurrentPositionOf: pancho equals: 1.
	
	self player: pancho movesANumberOfSlotsEqualTo: 1.
	self assertCurrentPositionOf: juan equals: 4.
	self assertCurrentPositionOf: pancho equals: 2.
	
	
]

{ #category : #tests }
LeaderBoardTest >> testBoardOfRoundsMadeChangesAfterEveryMovement [
	self assertCurrentNumberOfRoundsMadeBy: juan equals: 0.
	self assertCurrentNumberOfRoundsMadeBy: pancho equals: 0.
	
	self player: juan movesANumberOfSlotsEqualTo: 3.
	self player: pancho movesANumberOfSlotsEqualTo: 5.
	
	self assertCurrentNumberOfRoundsMadeBy: juan equals: 0.
	self assertCurrentNumberOfRoundsMadeBy: pancho equals: 0.
	
	self player: juan movesANumberOfSlotsEqualTo: 5.
	self player: pancho movesANumberOfSlotsEqualTo: 3.
	
	self assertCurrentNumberOfRoundsMadeBy: juan equals: 1.
	self assertCurrentNumberOfRoundsMadeBy: pancho equals: 1.
]

{ #category : #tests }
LeaderBoardTest >> testBoardOfWhoIsWinningChangesAfterEveryMovement [
	| pedrito renzo |
	pedrito := 'Pedrito'.
	renzo := 'Renzo'.
	players := OrderedCollection with: juan with: pancho with: pedrito with: renzo.
	leaderBoard := LeaderBoard with: players.
	
	self assertRankingOf: juan equals: 1.
	self assertRankingOf: pancho equals: 2.
	self assertRankingOf: pedrito equals: 3.
	self assertRankingOf: renzo equals: 4.
	
	self player: juan movesANumberOfSlotsEqualTo: 1.
	self assertRankingOf: juan equals: 1.
	
	self player: pancho movesANumberOfSlotsEqualTo: 2.
	self assertRankingOf: pancho equals: 1.
	self assertRankingOf: juan equals: 2.
	
	self player: pedrito movesANumberOfSlotsEqualTo: 2.
	self assertRankingOf: pedrito equals: 1.
	self assertRankingOf: pancho equals: 2.
	self assertRankingOf: juan equals: 3.
	
	self player: renzo movesANumberOfSlotsEqualTo: 5.
	self assertRankingOf: renzo equals: 1.
	self assertRankingOf: pancho equals: 2.
	self assertRankingOf: pedrito equals: 3.
	self assertRankingOf: juan equals: 4.


]

{ #category : #tests }
LeaderBoardTest >> testLeaderBoardRowHasAllTheInformationAboutAPlayer [

	self assertRowOfPlayer: juan nameOfThePlayerEquals: 'Juan'.
	self assertRowOfPlayer: juan positionOfThePlayerEquals: 1.
	self assertRowOfPlayer: juan roundsMadeByThePlayerEquals: 0.
	self assertRowOfPlayer: juan slotsPassedByThePlayerEquals: 1.
	
	self player: juan movesANumberOfSlotsEqualTo: 4.
	
	self assertRowOfPlayer: juan nameOfThePlayerEquals: 'Juan'.
	self assertRowOfPlayer: juan positionOfThePlayerEquals: 5.
	self assertRowOfPlayer: juan roundsMadeByThePlayerEquals: 0.
	self assertRowOfPlayer: juan slotsPassedByThePlayerEquals: 5.
	
	self player: juan movesANumberOfSlotsEqualTo: 3.
	
	self assertRowOfPlayer: juan nameOfThePlayerEquals: 'Juan'.
	self assertRowOfPlayer: juan positionOfThePlayerEquals: 2.
	self assertRowOfPlayer: juan roundsMadeByThePlayerEquals: 1.
	self assertRowOfPlayer: juan slotsPassedByThePlayerEquals: 8.

	
]
