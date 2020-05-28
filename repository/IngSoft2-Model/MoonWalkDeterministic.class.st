"
This object is a subclass of BoardSlot and has the responsability to apply it´s effect to the player or players of the Game. Similar to MoonWalk but it´s not random
"
Class {
	#name : #MoonWalkDeterministic,
	#superclass : #BoardSlot,
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
MoonWalkDeterministic >> applyEffectFrom: game [
	| n allThePlayersButAPlayer player |
	n := 1.
	player := game currentPlayer.
	allThePlayersButAPlayer := self remove: player from: game players.
	allThePlayersButAPlayer do: [ :aPlayer | game move: aPlayer ANumberOfSlotsEqualTo: n * -1 ]
	"
	allThePlayersButAPlayer asOrderedCollection
		do: [ :player | player move: n * -1 on: board until: aNumberOfRounds ]"
]

{ #category : #utilities }
MoonWalkDeterministic >> remove: aPlayer from: allThePlayers [
	| allButThePlayer |
	allButThePlayer := allThePlayers copy.
	allButThePlayer remove: aPlayer.
	^ allButThePlayer
]
