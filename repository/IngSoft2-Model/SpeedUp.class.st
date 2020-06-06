"
This object is a subclass of BoardSlot and has the responsability to apply it´s effect to the player or players of the Game.
"
Class {
	#name : #SpeedUp,
	#superclass : #BoardSlot,
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
SpeedUp >> applyEffectFrom: game [
	| player |
	player := game currentPlayer.
	game move: player ANumberOfSlotsEqualTo: 4
	"
	aPlayer move: 4 on: board until: aNumberOfRounds"
]
