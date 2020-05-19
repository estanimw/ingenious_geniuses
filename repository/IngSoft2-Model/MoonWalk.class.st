"
This object is a subclass of BoardSlot and has the responsability to apply it´s effect to the player or players of the Game.
"
Class {
	#name : #MoonWalk,
	#superclass : #BoardSlot,
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
MoonWalk >> applyEffectOfSlotOn: aPlayer from: allThePlayers forThe: board for: aNumberOfRounds [
	| n allThePlayersButAPlayer |
	n := (Random new next * 10) asInteger.
	allThePlayersButAPlayer := self remove: aPlayer from: allThePlayers.
	
	allThePlayersButAPlayer asOrderedCollection
		do: [ :player | player move: n *  -1 on: board until: aNumberOfRounds ]
]

{ #category : #utilities }
MoonWalk >> remove: aPlayer from: allThePlayers [
	| allButThePlayer |
	allButThePlayer := allThePlayers copy.
	allButThePlayer remove: aPlayer.
	^ allButThePlayer
]
