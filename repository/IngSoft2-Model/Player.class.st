"
This class models a player.
"
Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'dice',
		'currentPosition',
		'isWinner'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialize }
Player class >> playsWith: aDice [
	^ (self new) initializeWith: 0 and: aDice.
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
Player >> initializeWith: aPosition and: aDice [
	currentPosition := aPosition.
	dice := aDice.
	isWinner := false.
]

{ #category : #accessing }
Player >> isWinner [
	^isWinner.
]

{ #category : #positioning }
Player >> move: slotsQuantity on: aBoard [
	currentPosition := currentPosition + slotsQuantity.
	(currentPosition > aBoard) ifTrue: [ currentPosition := aBoard. isWinner := true].
	
]

{ #category : #playing }
Player >> throwDiceOn: aBoard [
	| number |
	number := dice roll.
	self move: number on: aBoard.
]
