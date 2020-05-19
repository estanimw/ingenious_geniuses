"
This object is a subclass of BoardSlot and has the responsability to apply it´s effect to the player or players of the Game.
"
Class {
	#name : #AtomicBomb,
	#superclass : #BoardSlot,
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
AtomicBomb >> applyEffectOfSlotOn: aPlayer from: allThePlayers forThe: board for: aNumberOfRounds [
	| playerCurrentPosition |
	allThePlayers
		do: [ :player | 
			playerCurrentPosition := player currentPosition.
			player
				move: playerCurrentPosition * -1
				on: board
				until: aNumberOfRounds ]
]
