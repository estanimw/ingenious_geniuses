"
This object has as instance variables the information related to a player; for example the position or number of rounds made and has the responsability to update this information after each turn
"
Class {
	#name : #LeaderBoardRow,
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
LeaderBoardRow class >> forPlayer: aPlayer [
	^ self new initializeWithA: aPlayer
]

{ #category : #comparing }
LeaderBoardRow >> <= aLeaderBoardRow [
	^ slotsPassedByThePlayer <= aLeaderBoardRow slotsPassedByThePlayer
]

{ #category : #utilities }
LeaderBoardRow >> changePositionAndRoundsMadeByAPlayer: aPlayer withOneLessRoundMadeForThisBoard: aBoard [
	playerPosition := playerPosition + aBoard numberOfSlots.
	playerRoundsMade := playerRoundsMade - 1 
]

{ #category : #utilities }
LeaderBoardRow >> changePositionAndRoundsMadeByAPlayer: aPlayer withOneMoreRoundMadeForThisBoard: aBoard [
	playerPosition := playerPosition - aBoard numberOfSlots.
	playerRoundsMade := playerRoundsMade + 1
]

{ #category : #update }
LeaderBoardRow >> changePositionAndRoundsMadeByaPlayer: aPlayer inASlotsQuantity: aSlotsQuantity forThisBoard: aBoard [
	playerPosition := playerPosition + aSlotsQuantity.
	playerPosition > aBoard numberOfSlots
		ifTrue: [ self changePositionAndRoundsMadeByAPlayer: aPlayer withOneMoreRoundMadeForThisBoard: aBoard ].
	playerPosition < 1
		ifTrue: [ self changePositionAndRoundsMadeByAPlayer: aPlayer withOneLessRoundMadeForThisBoard: aBoard ].
	self updateSlotsPassedByThePlayer: aPlayer forThisBoard: aBoard
]

{ #category : #comparing }
LeaderBoardRow >> currentPlayerHasMadeNumberOf: roundsForTheGameToBeOver [
	^ playerRoundsMade == roundsForTheGameToBeOver
]

{ #category : #initialization }
LeaderBoardRow >> initializeWithA: aPlayer [
	player := aPlayer.
	playerPosition := 1.
	playerRoundsMade := 0.
	slotsPassedByThePlayer := 1
]

{ #category : #'player information' }
LeaderBoardRow >> player [
	^ player
]

{ #category : #accessing }
LeaderBoardRow >> playerPosition [
	^ playerPosition
]

{ #category : #accessing }
LeaderBoardRow >> playerRoundsMade [
	^ playerRoundsMade
]

{ #category : #accessing }
LeaderBoardRow >> slotsPassedByThePlayer [
	^ slotsPassedByThePlayer
]

{ #category : #utilities }
LeaderBoardRow >> updateSlotsPassedByThePlayer: aPlayer forThisBoard: aBoard [
	slotsPassedByThePlayer := playerRoundsMade * aBoard numberOfSlots + playerPosition
]
