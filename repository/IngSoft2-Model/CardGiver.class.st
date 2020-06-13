"
Giver
"
Class {
	#name : #CardGiver,
	#superclass : #BoardSlot,
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
CardGiver >> applyEffectTo: aPlayer from: game [
	game giveCardToPlayer: aPlayer.
]
