"
This object is a subclass of BoardSlot and has the responsability to apply it´s effect to the player or players of the Game. Similar to MoonWalk but it´s not random
"
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
