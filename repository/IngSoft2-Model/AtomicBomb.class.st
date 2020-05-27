"
This object is a subclass of BoardSlot and has the responsability to apply it´s effect to the player or players of the Game.
"
Class {
	#name : #AtomicBomb,
	#superclass : #BoardSlot,
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
AtomicBomb >> applyEffectOfTheSlotAtThePositionOfCurrentPlayerFromThe: game [
	| playerCurrentPosition |
	(game players) do: [ :player | 
		playerCurrentPosition := game positionOf: player.
		game move: player ANumberOfSlotsEqualTo: playerCurrentPosition * -1 ]
	
	"| playerCurrentPosition |
	allThePlayers
		do: [ :player | 
			playerCurrentPosition := player currentPosition.
			player
				move: playerCurrentPosition * -1
				on: board
				until: aNumberOfRounds ]"
]
