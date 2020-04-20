"
This class models a player.
"
Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'dice',
		'boardOfTheGame',
		'currentPosition',
		'isWinner'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialize }
Player class >> playsWith: aDice on: aBoard [
	^ (self new) initializeWith: 0 and: aDice on: aBoard.
]

{ #category : #accessing }
Player >> boardOfTheGame [ 
	^ boardOfTheGame.
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
Player >> initializeWith: aPosition and: aDice on: aBoard [ 
	currentPosition := aPosition.
	dice := aDice.
	boardOfTheGame := aBoard.
	isWinner := false.
]

{ #category : #accessing }
Player >> isWinner [
	^isWinner.
]

{ #category : #positioning }
Player >> move: slotsQuantity [ 
	currentPosition := currentPosition + slotsQuantity.
	(currentPosition > (boardOfTheGame numberOfSlots)) ifTrue: [ currentPosition := (boardOfTheGame numberOfSlots). isWinner := true].
	
]

{ #category : #accessing }
Player >> slotsOfTheBoardOfTheGame [
	^boardOfTheGame numberOfSlots.
]

{ #category : #playing }
Player >> throwDice [
	| number |
	number := dice roll.
	self move: number.
]
