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

{ #category : #'as yet unclassified' }
LeaderBoardBlock class >> creationWithA: aPlayer [
	^(self new) initializeWithA: aPlayer.
]

{ #category : #'as yet unclassified' }
LeaderBoardBlock >> <= aLeaderBoardBlock [
	^ slotsPassedByThePlayer <= aLeaderBoardBlock slotsPassedByThePlayer
]

{ #category : #'as yet unclassified' }
LeaderBoardBlock >> changePositionAndRoundsMadeOf: aPlayer forThis: board [
	playerPosition := aPlayer currentPosition.
	playerRoundsMade := aPlayer numberOfRoundsMade.
	slotsPassedByThePlayer := playerRoundsMade * board + playerPosition
]

{ #category : #initialization }
LeaderBoardBlock >> initializeWithA: aPlayer [
	player := aPlayer.
	playerPosition := aPlayer currentPosition.
	playerRoundsMade := aPlayer numberOfRoundsMade.
	slotsPassedByThePlayer := 0.
]

{ #category : #'as yet unclassified' }
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
