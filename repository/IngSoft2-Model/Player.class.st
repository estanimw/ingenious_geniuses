"
This class models a player.
"
Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'dice',
		'currentPosition',
		'isWinner',
		'numberOfRoundsMade',
		'id'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialize }
Player class >> playsWith: aDice [
	^ (self new) initializeWith: 0 and: aDice and: 0.
]

{ #category : #playing }
Player >> changeNumberOfRoundsMadeAndPositionIn: slotsQuantity on: aBoard [
	currentPosition := currentPosition + slotsQuantity.
	(currentPosition > aBoard) ifTrue: [ 
		currentPosition := (currentPosition - aBoard).
		numberOfRoundsMade := numberOfRoundsMade + 1.
	]
]

{ #category : #accessing }
Player >> currentPosition [
	^currentPosition.
]

{ #category : #accessing }
Player >> dice [
	^dice
]

{ #category : #playing }
Player >> hasWonWith: aNumberOfRounds [
	(numberOfRoundsMade == aNumberOfRounds) ifTrue:[
		isWinner := true.
	].
]

{ #category : #accessing }
Player >> id [
	^ id
]

{ #category : #initialization }
Player >> initializeWith: aPosition and: aDice and: roundsMade [
	currentPosition := aPosition.
	dice := aDice.
	numberOfRoundsMade := roundsMade.
	isWinner := false.
	id := (((Random new) next) * 100) asInteger.
]

{ #category : #accessing }
Player >> isWinner [
	^isWinner.
]

{ #category : #playing }
Player >> move: slotsQuantity on: aBoard until: aNumberOfRounds [
		self changeNumberOfRoundsMadeAndPositionIn: slotsQuantity on: aBoard.
		self hasWonWith: aNumberOfRounds
	
]

{ #category : #accessing }
Player >> numberOfRoundsMade [
	^numberOfRoundsMade
]

{ #category : #playing }
Player >> throwDiceOn: aBoard until: aNumberOfRounds [
	| number |
	number := dice roll.
	self move: number on: aBoard until: aNumberOfRounds
]
