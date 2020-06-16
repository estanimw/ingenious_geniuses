"
A Redo Card.
"
Class {
	#name : #Redo,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
Redo >> applyEffectOverATarget: aTarget on: theGame [
	| lastCardPlayed theManagerOfCards |
	theManagerOfCards := theGame managerOfEffects.
	lastCardPlayed := theManagerOfCards lastCardPlayed.
	lastCardPlayed applyEffectOverATarget: aTarget on: theGame.
]

{ #category : #initialization }
Redo >> initializeCard [
	typeOfCard := 'instant'
]
