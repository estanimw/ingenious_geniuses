"
An Effect
"
Class {
	#name : #BoardSlot,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
BoardSlot >> applyEffectOfSlotOn: aPlayer from: allThePlayers forThe: board for: aNumberOfRounds [
	^self subclassResponsibility
]
