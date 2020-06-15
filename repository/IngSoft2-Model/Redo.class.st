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
	| lastCard theManagerOfCards |
	theManagerOfCards := theGame managerOfEffects.
	lastCard := theManagerOfCards lastCardPlayed.
	lastCard applyEffectOverATarget: aTarget on: theGame.
]

{ #category : #initialization }
Redo >> initializeCard [
	typeOfCard := 'instant'
]
