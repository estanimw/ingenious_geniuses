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
		'numberOfRoundsMade'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialize }
Player class >> playsWith: aDice [
	^ (self new) initializeWith: 0 and: aDice and: 0.
]

{ #category : #accessing }
Player >> currentPosition [
	^ currentPosition.
]

{ #category : #accessing }
Player >> dice [
	^ dice
]

{ #category : #initialization }
Player >> initializeWith: aPosition and: aDice and: roundsMade [
	currentPosition := aPosition.
	dice := aDice.
	numberOfRoundsMade := roundsMade.
	isWinner := false.
]

{ #category : #accessing }
Player >> isWinner [
	^isWinner.
]

{ #category : #positioning }
Player >> move: slotsQuantity on: aBoard until: xRounds [
	currentPosition := currentPosition + slotsQuantity.
	(currentPosition > aBoard) ifTrue: [ 
		currentPosition := (currentPosition - aBoard).
		numberOfRoundsMade := numberOfRoundsMade + 1.
		(numberOfRoundsMade == xRounds) ifTrue:[
			isWinner := true.
			].
		].
	
]

{ #category : #accessing }
Player >> numberOfRoundsMade [
	^numberOfRoundsMade
]

{ #category : #playing }
Player >> throwDiceOn: aBoard until: xRounds [
	| number |
	number := dice roll.
	self move: number on: aBoard until: xRounds
]
