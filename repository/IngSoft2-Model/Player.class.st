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

{ #category : #initialization }
Player >> initializeWith: aPosition and: aDice and: roundsMade [
	currentPosition := aPosition.
	dice := aDice.
	numberOfRoundsMade := roundsMade.
	isWinner := false.
	id := ((Random new) next).
]
