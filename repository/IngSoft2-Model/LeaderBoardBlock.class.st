"
This object has as instance variables the information related to a player; for example the position or number of rounds made and has the responsability to update this information after each turn
"
Class {
	#name : #LeaderBoardBlock,
	#superclass : #Object,
	#instVars : [
		'player',
		'playerPosition',
		'playerRoundsMade',
		'slotsPassedByThePlayer'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
LeaderBoardBlock class >> forA: aPlayer [
	^ self new initializeWithA: aPlayer
]

{ #category : #comparing }
LeaderBoardBlock >> <= aLeaderBoardBlock [
	^ slotsPassedByThePlayer <= aLeaderBoardBlock slotsPassedByThePlayer
]

{ #category : #update }
LeaderBoardBlock >> calculateTotalNumberOfSlotsAdvancedIn: board [
	slotsPassedByThePlayer := playerRoundsMade * board + playerPosition
]

{ #category : #update }
LeaderBoardBlock >> changePositionAndRoundsMadeBy: aPlayer forThis: board [
	playerPosition := aPlayer currentPosition.
	playerRoundsMade := aPlayer numberOfRoundsMade.
	self calculateTotalNumberOfSlotsAdvancedIn: board
]

{ #category : #initialization }
LeaderBoardBlock >> initializeWithA: aPlayer [
	player := aPlayer.
	playerPosition := aPlayer currentPosition.
	playerRoundsMade := aPlayer numberOfRoundsMade.
	slotsPassedByThePlayer := 0.
]

{ #category : #'player information' }
LeaderBoardBlock >> playerId [
	^ player id
]

{ #category : #accessing }
LeaderBoardBlock >> playerPosition [
	^ playerPosition
]

{ #category : #accessing }
LeaderBoardBlock >> playerRoundsMade [
	^ playerRoundsMade
]

{ #category : #accessing }
LeaderBoardBlock >> slotsPassedByThePlayer [
	^ slotsPassedByThePlayer
]
