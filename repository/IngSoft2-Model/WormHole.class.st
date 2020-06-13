"
This object is a subclass of BoardSlot and has the responsability to apply it´s effect to the player or players of the Game.
"
Class {
	#name : #WormHole,
	#superclass : #BoardSlot,
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
WormHole >> applyEffectTo: aPlayer from: game [
	game move: aPlayer ANumberOfSlotsEqualTo: -4
]
