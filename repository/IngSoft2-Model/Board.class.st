"
This object has an orderedCollection of BoardSlots and has the responsability to apply a certain distribution of the quantity of each kind of BoardSlot and delegate the apply effect on the player to the BoardSlot accordingly
"
Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'numberOfSlots',
		'slotsList'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Board class >> of: aSlotsArray [
	^ self new initializeWith: aSlotsArray
]

{ #category : #playing }
Board >> applyEffectOfTheSlotAtThePositionOfCurrentPlayerFrom: game [
	| slotWhereThePlayerIsAt playerCurrentPosition currentPlayer |
	currentPlayer := game currentPlayer.
	playerCurrentPosition := game positionOf: currentPlayer.
	slotWhereThePlayerIsAt := slotsList at: playerCurrentPosition.
	slotWhereThePlayerIsAt applyEffectFrom: game
]

{ #category : #initialization }
Board >> initializeWith: aSlotsArray [
	numberOfSlots := aSlotsArray size.
	slotsList := aSlotsArray
]

{ #category : #accessing }
Board >> numberOfSlots [
	^ numberOfSlots
]

{ #category : #accessing }
Board >> slotsList [
	^ slotsList
]
