Class {
	#name : #MoonWalkDeterministic,
	#superclass : #BoardSlot,
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
MoonWalkDeterministic >> applyEffectOfSlotOn: aPlayer from: allThePlayers forThe: board for: aNumberOfRounds [
	| n allThePlayersButAPlayer |
	n := 1.
	allThePlayersButAPlayer := self remove: aPlayer from: allThePlayers.
	
	allThePlayersButAPlayer asOrderedCollection
		do: [ :player | player move: n * -1 on: board until: aNumberOfRounds ]
]

{ #category : #utilities }
MoonWalkDeterministic >> remove: aPlayer from: allThePlayers [
	| allButThePlayer |
	allButThePlayer := allThePlayers copy.
	allButThePlayer remove: aPlayer.
	^ allButThePlayer
]
