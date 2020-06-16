"
This object has an orderedCollection of BoardSlots and has the responsability to apply a certain distribution of the quantity of each kind of BoardSlot and delegate the apply effect on the player to the BoardSlot accordingly
"
Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'numberOfSlots',
		'slotsList',
		'lastSlot'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Board class >> ofASlotDistribution: aSlotsArray [
	^ self new initializeWith: aSlotsArray
]

{ #category : #playing }
Board >> applyEffectOfTheSlotAtThePositionOfPlayer: aPlayer from: game [
	| slotWhereThePlayerIsAt aPlayerPosition |
	aPlayerPosition := game positionOf: aPlayer.
	slotWhereThePlayerIsAt := slotsList at: aPlayerPosition.
	lastSlot := slotWhereThePlayerIsAt.
	slotWhereThePlayerIsAt applyEffectTo: aPlayer from: game
]

{ #category : #initialization }
Board >> initializeWith: aSlotsArray [
	numberOfSlots := aSlotsArray size.
	slotsList := aSlotsArray
]

{ #category : #accesing }
Board >> lastSlot [
	^ lastSlot
]

{ #category : #accessing }
Board >> numberOfSlots [
	^ numberOfSlots
]

{ #category : #accessing }
Board >> slotsList [
	^ slotsList
]
