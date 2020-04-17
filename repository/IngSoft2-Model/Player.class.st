"
This class models a player.
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
	^ (self new) initializeWithPositionAndDice: (OrderedCollection with: 0 with: dice).
]

{ #category : #'as yet unclassified' }
Player class >> move [
	self shouldBeImplemented.
]

{ #category : #accessing }
Player >> boardSlots [
	^ boardSlots
]

{ #category : #'as yet unclassified' }
Player >> boardSlots: numberOfSlots [
	boardSlots := numberOfSlots.
]

{ #category : #'as yet unclassified' }
Player >> dice [
	^ dice
]

{ #category : #initialization }
Player >> initializeWithPositionAndDice: information [ 
	position := information removeFirst.
	dice := information removeFirst.
	winner := false.
]

{ #category : #accessing }
Player >> move: anInteger [ 
	position := position + anInteger.
	(position > boardSlots) ifTrue: [ position := boardSlots . winner := true].
	
]

{ #category : #'as yet unclassified' }
Player >> position [
	^ position
]

{ #category : #'as yet unclassified' }
Player >> throwDice [
	| number |
	number := dice roll.
	self move: number.
]

{ #category : #'as yet unclassified' }
Player >> winner [
	^winner.
]
