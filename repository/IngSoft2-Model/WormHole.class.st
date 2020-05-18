Class {
	#name : #WormHole,
	#superclass : #BoardSlot,
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
WormHole >> applyEffectOfSlotOn: aPlayer from: allThePlayers forThe: board for: aNumberOfRounds [
	aPlayer move: -4 on: board until: aNumberOfRounds
]
