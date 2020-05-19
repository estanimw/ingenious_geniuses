"
This object has the responsability to throw a Dice and move a number of slots equal to the number thrown by the Dice
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

{ #category : #'instance creation' }
Player class >> playsWith: aDice [
	^ (self new) initializeWith: 0 and: aDice and: 0.
]

{ #category : #updating }
Player >> changeNumberOfRoundsMadeAndPositionIn: slotsQuantity on: aBoard [
	currentPosition := currentPosition + slotsQuantity.
	currentPosition > aBoard numberOfSlots
		ifTrue: [ currentPosition := currentPosition - aBoard numberOfSlots.
			numberOfRoundsMade := numberOfRoundsMade + 1 ].
	currentPosition < 0
		ifTrue: [ currentPosition := currentPosition + aBoard numberOfSlots + 1.
			numberOfRoundsMade := numberOfRoundsMade - 1 ]
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
	"id := (Time now) nanoSecond."
	id := ((Random new) next).
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
