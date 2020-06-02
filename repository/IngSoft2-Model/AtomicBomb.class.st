"
This object is a subclass of BoardSlot and has the responsability to apply it´s effect to the player or players of the Game.
"
Class {
	#name : #AtomicBomb,
	#superclass : #BoardSlot,
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
AtomicBomb >> applyEffectFrom: game [
	| playerCurrentPosition |
	(game players) do: [ :player | 
		playerCurrentPosition := game positionOf: player.
		game move: player ANumberOfSlotsEqualTo: (playerCurrentPosition-1) * -1 ].
]
