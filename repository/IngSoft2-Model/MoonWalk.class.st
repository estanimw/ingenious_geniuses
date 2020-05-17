Class {
	#name : #MoonWalk,
	#superclass : #BoardSlot,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
MoonWalk >> applyEffectOfSlotOn: aPlayer from: allThePlayers forThe: board for: aNumberOfRounds [
	| n allButThePlayer |
	n := (((Random new) next)*10) asInteger.
	
	allButThePlayer := allThePlayers copy.
	allButThePlayer remove: aPlayer.
	
	(allButThePlayer asOrderedCollection) do: [ :player | player move: n*(-1) on: board until: aNumberOfRounds ].
]