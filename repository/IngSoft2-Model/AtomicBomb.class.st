Class {
	#name : #AtomicBomb,
	#superclass : #BoardSlot,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
AtomicBomb >> applyEffectOfSlotOn: aPlayer from: allThePlayers forThe: board for: aNumberOfRounds [
	| posicionActual |
	allThePlayers do: [ :player | posicionActual := player currentPosition. player move: (posicionActual*(-1)) on: board until: aNumberOfRounds ].
]
