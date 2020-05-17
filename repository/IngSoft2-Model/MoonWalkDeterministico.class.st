Class {
	#name : #MoonWalkDeterministico,
	#superclass : #BoardSlot,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
MoonWalkDeterministico >> applyEffectOfSlotOn: aPlayer from: allThePlayers forThe: board for: aNumberOfRounds [
	| n allButThePlayer |
	n := 1.
	
	allButThePlayer := allThePlayers copy.
	allButThePlayer remove: aPlayer.
	
	(allButThePlayer asOrderedCollection) do: [ :player | player move: n*(-1) on: board until: aNumberOfRounds ].
]
