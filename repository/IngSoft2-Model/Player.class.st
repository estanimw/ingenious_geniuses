"
This class represents a player in the game.
"
Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'position',
		'dice',
		'boardSlots',
		'winner'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialize }
Player class >> creation: dice [ 
	^(self new) initializeWithPositionAndDice: (OrderedCollection with: 0 with: dice).
]

{ #category : #'as yet unclassified' }
Player >> boardSlots [
	^boardSlots.
]

{ #category : #'as yet unclassified' }
Player >> boardSlots: anInteger [ 
	boardSlots := anInteger
]

{ #category : #accessing }
Player >> dice [
	^ dice
]

{ #category : #initialization }
Player >> initializeWithPositionAndDice: aBlockClosure [ 
	position := aBlockClosure removeFirst.
	dice := aBlockClosure removeFirst.
	winner := false.
]

{ #category : #moving }
Player >> move: anInteger [ 
	position := position + anInteger.
	(position > boardSlots) ifTrue: [ position := boardSlots. winner := true ].
]

{ #category : #accessing }
Player >> position [
	^ position
]

{ #category : #advancing }
Player >> throwDice [
	| number |
	number := dice roll.
	self move:number.
]

{ #category : #accesing }
Player >> winner [
	^winner.
]
