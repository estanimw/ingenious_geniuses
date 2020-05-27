"
This object is a subclass of BoardSlot and has the responsability to apply it´s effect to the player or players of the Game.
"
Class {
	#name : #MoonWalk,
	#superclass : #BoardSlot,
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
MoonWalk >> applyEffectOfTheSlotAtThePositionOfCurrentPlayerFromThe: game [
	| n allThePlayersButAPlayer player |
	n := (Random new next * 10) asInteger.
	player := game currentPlayer.
	allThePlayersButAPlayer := self remove: player from: game players.
	allThePlayersButAPlayer do: [ :aPlayer | game move: aPlayer ANumberOfSlotsEqualTo: n * -1 ]
	"
	allThePlayersButAPlayer asOrderedCollection
		do: [ :player | player move: n * -1 on: board until: aNumberOfRounds ]"
]

{ #category : #utilities }
MoonWalk >> remove: aPlayer from: allThePlayers [
	| allButThePlayer |
	allButThePlayer := allThePlayers copy.
	allButThePlayer remove: aPlayer.
	^ allButThePlayer
]
