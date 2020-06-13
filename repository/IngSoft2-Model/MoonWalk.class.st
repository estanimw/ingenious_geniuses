"
This object is a subclass of BoardSlot and has the responsability to apply it´s effect to the player or players of the Game.
"
Class {
	#name : #MoonWalk,
	#superclass : #BoardSlot,
	#instVars : [
		'n'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
MoonWalk class >> createSlot [
	^ self new initializeWithN: ((Random new next * 10) asInteger).
]

{ #category : #'instance creation' }
MoonWalk class >> createSlotWithN: aNumber [
	^self new initializeWithN: aNumber.
]

{ #category : #playing }
MoonWalk >> applyEffectTo: aPlayer from: game [
	game moveEveryPlayerButThePlayer: aPlayer aNumberOfSlotsEqualTo: n.
]

{ #category : #initialization }
MoonWalk >> initializeWithN: anNumber [
	n := anNumber.
]
