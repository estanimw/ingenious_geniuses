Class {
	#name : #SpeedUp,
	#superclass : #BoardSlot,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
SpeedUp >> applyEffectOfSlotOn: aPlayer from: allThePlayers forThe: board for: aNumberOfRounds [
	aPlayer move: 4 on: board until: aNumberOfRounds.
]
