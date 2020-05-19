"
This object is a subclass of BoardSlot and has the responsability to apply it´s effect to the player or players of the Game.
"
Class {
	#name : #SpeedUp,
	#superclass : #BoardSlot,
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
SpeedUp >> applyEffectOfSlotOn: aPlayer from: allThePlayers forThe: board for: aNumberOfRounds [
	aPlayer move: 4 on: board until: aNumberOfRounds
]
